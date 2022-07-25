import h5py
import numpy
import numpy as np
import os, sys
import cantera as ct
import bz2
import pickle
import _pickle as cPickle
from multiprocessing.pool import  ThreadPool as Pool

print('Running Python Version: ' + sys.version)
print('Running Cantera version: ' + ct.__version__)


def toStringAtt(string):
    ascii_type = h5py.string_dtype('ascii', len(string))
    return np.array(string.encode("latin-1"), dtype=ascii_type)


def computeYi(fields):
    eulerField = fields['solution_euler']
    densityYiField = fields['solution_densityYi']

    # create the field
    if 'yi' in fields:
        del fields['yi']
    yiField = fields.create_dataset("yi", densityYiField.shape, densityYiField.dtype)

    # copy over the attributes
    for name, value in densityYiField.attrs.items():
        yiField.attrs.create(name, value)

    components = yiField.shape[-1]

    for t in range(len(eulerField)):
        density = eulerField[t, :, 0]
        for c in range(components):
            yiField[t, :, c] = densityYiField[t, :, c] / density


def computeVel(fields):
    eulerField = fields['solution_euler']

    dim = eulerField.shape[-1] - 2
    velShape = list(eulerField.shape)
    velShape[-1] = dim

    # create the field
    if 'vel' in fields:
        del fields['vel']
    velField = fields.create_dataset("vel", tuple(velShape), eulerField.dtype)

    # add the required fields
    velField.attrs.create('timestepping', eulerField.attrs['timestepping'])
    velField.attrs.create('componentName0', toStringAtt('vel0'))
    velField.attrs.create('componentName1', toStringAtt('vel1'))
    velField.attrs.create('componentName2', toStringAtt('vel2'))
    velField.attrs.create('vector_field_type', toStringAtt('vector'))

    for t in range(len(eulerField)):
        density = eulerField[t, :, 0]
        for d in range(dim):
            velField[t, :, d] = eulerField[t, :, d + 2] / density


def computeTemperature(fields, gas):
    eulerField = fields['solution_euler']
    yiField = fields['yi']
    velField = fields['vel']

    tShape = list(eulerField.shape)
    tShape.pop()
    dim = velField.shape[-1]

    # create the field
    if 'T' in fields:
        del fields['T']
    tField = fields.create_dataset("T", tuple(tShape), eulerField.dtype)

    # add the required fields
    tField.attrs.create('timestepping', eulerField.attrs['timestepping'])
    tField.attrs.create('componentName0', toStringAtt('0'))
    tField.attrs.create('vector_field_type', toStringAtt('scalar'))

    speciesList = []
    for s in range(yiField.shape[-1]):
        attName = 'componentName' + str(s)
        speciesList.append(yiField.attrs[attName])

    for t in range(len(eulerField)):
        density = eulerField[t, :, 0]
        totalEnergy = eulerField[t, :, 1] / density
        for p in range(len(totalEnergy)):
            # compute the kinetic totalEnergy
            kineticEnergy = 0.0
            for c in range(dim):
                kineticEnergy += velField[t, p, c] ** 2
            internalEnergy = totalEnergy[p] - 0.5 * kineticEnergy
            specificVolume = 1.0 / density[p]

            # build the yi
            yi = dict(zip(speciesList, yiField[t, p, :]))

            # compute the reference enthalpy
            gas.TPY = 298.15, 101325.0, yi
            enthalpyOfFormation = gas.h

            # set the internal energy
            gas.UVY = (internalEnergy + enthalpyOfFormation), specificVolume, yi
            tField[t, p] = gas.T


def computeZmix(fields, gas, Yfuel,Yox):
    eulerField = fields['solution_euler']
    tShape = list(eulerField.shape)
    tShape.pop()
    # Load up the Yi from fields
    YiField = fields['yi']

    # Create the Zmix Field
    if 'Zmix' in fields:
        del fields['Zmix']
    ZField = fields.create_dataset("Zmix", tuple(tShape), eulerField.dtype)
    # add the required fields
    ZField.attrs.create('timestepping', eulerField.attrs['timestepping'])
    ZField.attrs.create('componentName0', toStringAtt('0'))
    ZField.attrs.create('vector_field_type', toStringAtt('scalar'))

    # Set Up Species List Based On Species Found
    speciesList = []
    for s in range(YiField.shape[-1]):
        attName = 'componentName' + str(s)
        speciesList.append(YiField.attrs[attName])
    nsp = len(speciesList)

    # This List should be ordered based on species locations in YiField
    # First step to calculating mixture fraction is determining
    # The weights for each Species
    Zcoeff = np.zeros(nsp)
    for i in range(nsp):
        s = speciesList[i]
        n = gas.n_atoms(s, 'H')
        m = gas.n_atoms(s, 'C')
        Zco = n * gas.molecular_weights[gas.species_index("H")] + m * gas.molecular_weights[gas.species_index("C")]
        Zcoeff[i] = (Zco / gas.molecular_weights[gas.species_index(s)])
    # Now based on Yfuel and Yoxidizer, determine the mixture fraction
    # Luckily Yoxidizer should be the left boundary condition and just the species mass fractions
    # of the first index
    Zox = 0
    Zf = 0
    for ns in range(nsp):
        # build the yi
        # yi = dict(zip(speciesList, yiField[t, p, :]))
        Zox = Zox + Zcoeff[ns] * Yox[ns]
        Zf = Zf + Zcoeff[ns] * Yfuel[ns]
    import multiprocessing
    from itertools import repeat
    from functools import partial
    pts = range(len(YiField[0]))
    for t in range(len(fields['solution_euler'])):
        for pt in pts:
            ZField[t, pt] = (Zcoeff.dot(YiField[t, pt, :]) - Zox) / (Zf - Zox + 1e-10)
            # ZField[t, pt] = Results[pt]
            # SetValue(ZField,Zcoeff,Zox,Zf,YiField,t,pt,nsp)
            # Zmix = 0;
            # for ns in range(nsp):
            #     Zmix = Zmix + Zcoeff[ns] * YiField[t, pt, ns]
            # Zmix = (Zmix - Zox) / (Zf - Zox + 1e-10)
            # ZField[t, pt] = Zmix;


def SetValue(pt, ZField, Zcoeff, Zox, Zf, YiField, t, nsp):
    return (Zcoeff.dot(YiField[t, pt, :]) - Zox) / (Zf - Zox + 1e-10)


def SaveFileKenny(hdfFileName, fields):
    # Grab Arrays of Data we want, T, YiMajor/Minor, Zmix
    TField = fields['T']
    YiField = fields['yi']
    ZField = fields['Zmix']
    TimeSteps = len(fields['solution_euler'])
    NumPts = len(TField[0])
    NumSp = len(YiField[0][0])
    # NextWeWantToStore 2Dimensional Arrays corresponding to timestep/pt (Their Already Essentially in this format
    # so could probably just call somthing instead of creating something, but idk hdf5 enought atm...)
    ZSave = np.zeros((TimeSteps, NumPts))
    TSave = np.zeros((TimeSteps, NumPts))
    YiSave = np.zeros((TimeSteps, NumPts, NumSp))
    for t in range(TimeSteps):
        for npts in range(NumPts):
            ZSave[t, npts] = ZField[t, npts]
            TSave[t, npts] = TField[t, npts]
            for ns in range(NumSp):
                YiSave[t, npts, ns] = YiField[t, npts, ns]
    with bz2.BZ2File(hdfFileName[0:len(hdfFileName) - 5] + ".pbz2", 'w') as f:
        cPickle.dump([ZSave, TSave, YiSave], f)


def main(hdfFileName):
    h5 = h5py.File(hdfFileName, 'r+')

    # Check each of the cell fields
    fields = h5['cell_fields']
    # Load in the cti mech file
    gas = ct.Solution('gri30.yaml')
    # Assume YiFuel is just the same Equillibriated State
    gas.X = "C:5,H:8,O:2"
    gas.TP = 653, 101325.
    gas.equilibrate('TP')
    Yfuel = gas.Y
    YO2 = 0.22968530497578818
    gas.Y = "O2:" + str(YO2) + ",N2:" + str(1.-YO2)
    Yox = gas.Y
    import time
    start = time.time()
    computeYi(fields)
    computeVel(fields)
    computeTemperature(fields, gas)
    print("Starting Zmix Computation, the time already taken is :" + str(time.time() - start))
    computeZmix(fields, gas, Yfuel, Yox)
    SaveFileKenny(hdfFileName, fields)
    end = time.time()
    print(end - start)
    # for field in fields.items():
        # print(field)


if __name__ == '__main__':
    ct.Solution('gri30.xml')
    hdfFileName = "domain.00116.hdf5"
    fileString = "116"
    # hdfFileName = "C:\\Users\klbud\\Downloads\\domain\\domain\\domain.00"+fileString+".hdf5"
    print("Running timeFile: " + fileString)
    main(hdfFileName)

    #SetFileFold
    # path = "C:\\Users\klbud\Downloads\domain\domain\\"
    # #Grab Files from Folder, make sure they are hdf5 files for now as only check
    # Files = [os.path.join(path, f) for f in os.listdir(path) if f.endswith('.hdf5')]
    # #Create A pool to run Files
    # pool_obj = Pool()
    # pool_obj.map(main, Files)
    # Results = pool_obj.starmap(SetValue, zip(repeat(ZField), repeat(Zcoeff), repeat(Zox),
    #                                          repeat(Zf), repeat(YiField), repeat(t), pts, repeat(nsp)))
    # Results = pool_obj.map(partial(SetValue, ZField=ZField, Zcoeff=Zcoeff, Zox=Zox, Zf=Zf, YiField=YiField,
    #                                t=t, nsp=nsp),pts)
