#!/bin/bash
#### See https://hpc.llnl.gov/training/tutorials/slurm-and-moab#LC

##### These lines are for Slurm
#SBATCH -N 384
#SBATCH -J 2dSlab
#SBATCH -t 24:00:00
#SBATCH -p pbatch
#SBATCH --mail-type=ALL
#SBATCH -A sunyb
#SBATCH --mail-user=mtmcgurn@buffalo.edu

##### Load Required modules
# gcc
module load mkl/2019.0
module load valgrind/3.16.1
module load gcc/10.2.1
module load  cmake/3.21.1 

# Load PETSC ENV
export PETSC_DIR="/g/g15/mcgurn4/petsc"
export PETSC_ARCH="arch-ablate-opt-gcc" # arch-ablate-debug or arch-ablate-opt
export PKG_CONFIG_PATH="${PETSC_DIR}/${PETSC_ARCH}/lib/pkgconfig:$PKG_CONFIG_PATH"
export HDF5_ROOT="${PETSC_DIR}/${PETSC_ARCH}"  
# Include the bin directory to access mpi commands
export PATH="${PETSC_DIR}/${PETSC_ARCH}/bin:$PATH"

# Make a temp directory so that tchem has a place to vomit its files
mkdir tmp_$SLURM_JOBID
cd tmp_$SLURM_JOBID

# export TITLE=2Dn384_half_G02
# export VELOCITY=".212175*min(1,20*t),0"

# export TITLE=2Dn384_half_G20
# export VELOCITY="16.967126*min(1,20*t),0.0"
 
# export TITLE=2Dn384_half_G50
# export VELOCITY="42.417815*min(1,20*t),0.0"
 
# export TITLE=2Dn384_half_G100
# export VELOCITY="84.835630*min(1,20*t),0.0"

##### Launch parallel job using srun
srun -n13824 /g/g15/mcgurn4/ablateOpt/ablate \
	--input /p/lustre2/mcgurn4/ablateInputs/slabBurnerChem.2D.V20/slabBurner.Pgs.2D.V20.yaml \
	-yaml::environment::title 2Dn384_half_G02 \
	-yaml::solvers::[1]::processes::[0]::velocity ".212175*min(1,20*t),0" \
	-yaml::timestepper::domain::faces [1120,160]

	
echo 'Done'
