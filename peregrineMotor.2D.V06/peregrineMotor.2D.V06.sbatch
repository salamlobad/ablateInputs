#!/bin/bash
#### See https://hpc.llnl.gov/training/tutorials/slurm-and-moab#LC

##### These lines are for Slurm
#SBATCH -N 50
#SBATCH -J i8G150
#SBATCH -t 24:00:00
#SBATCH -p pbatch
#SBATCH --mail-type=ALL
#SBATCH -A sunyb
#SBATCH --mail-user=salamlob@buffalo.edu

##### Load Required modules
# gcc
module load mkl/2019.0
module load valgrind/3.16.1
module load gcc/10.2.1
module load cmake/3.21.1

# Load PETSC ENV
export PETSC_DIR="/g/g20/lobad1/petsc"
export PETSC_ARCH="arch-ablate-opt-gcc" # arch-ablate-debug or arch-ablate-opt
export PKG_CONFIG_PATH="${PETSC_DIR}/${PETSC_ARCH}/lib/pkgconfig:$PKG_CONFIG_PATH"
export HDF5_ROOT="${PETSC_DIR}/${PETSC_ARCH}"  
# Include the bin directory to access mpi commands
export PATH="${PETSC_DIR}/${PETSC_ARCH}/bin:$PATH"

# Make a temp directory so that tchem has a place to vomit its files
mkdir tmp_$SLURM_JOBID
cd tmp_$SLURM_JOBID

# G 10
# velocity = 8.49762066621
# G 25
# velocity = 21.2440516655
# G 50
# velocity = 42.4881033311
# G 100
# velocity = 84.9762066621
# G 150
# velocity = 127.464309993
# G 200
# velocity = 169.952413324,
# G 300
# velocity = 254.928619986

##### Launch parallel job using srun
srun -n1800 /g/g20/lobad1/ablateOpt/ablate \
        --input /p/lustre1/lobad1/ablateInputs/peregrineMotor.2D.V06/peregrineMotor.2D.V06.yaml \
        -yaml::environment::title 2Dn50peregrine_ignite8_G150_mV4.4_ref0_petscStep_rocketMonitor \
        -yaml::timestepper::arguments::ts_max_steps 100000000 \
        -yaml::timestepper::domain::fields::[0]::conservedFieldOptions::petscfv_type leastsquares
        -yaml::timestepper::domain::options::dm_refine 0

echo 'Done'
