#!/bin/bash
#### See https://hpc.llnl.gov/training/tutorials/slurm-and-moab#LC

##### These lines are for Slurm
#SBATCH -N 8
#SBATCH -J 3dPeregrine
#SBATCH -t 1:00:00
#SBATCH -p pdebug
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

export TITLE=2Dn128_half_G02
export VELOCITY=".212175*min(1,20*t),0"

# export TITLE=2Dn128_half_G20
# export VELOCITY="16.967126*min(1,20*t),0.0"
 
# export TITLE=2Dn128_half_G50
# export VELOCITY="42.417815*min(1,20*t),0.0"
 
# export TITLE=2Dn128_half_G100
# export VELOCITY="84.835630*min(1,20*t),0.0"

##### Launch parallel job using srun
srun -n128 /g/g20/lobad1/ablateOpt/ablate \
	--input /p/lustre1/lobad1/ablateInputs/peregrineMotorChem.3D.V02/peregrineMotor.Pgs.3D.V02.yaml \
	-yaml::environment::title 2Dn128_half_G02 \
	-yaml::solvers::[1]::processes::[0]::velocity ".212175*min(1,20*t),0" \
	-yaml::timestepper::arguments::ts_max_steps 250 # 1000000 \
	-yaml::timestepper::domain::faces [120,18,18]

echo 'Done'
