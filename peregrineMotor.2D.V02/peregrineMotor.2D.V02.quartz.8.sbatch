#!/bin/bash
#### See https://hpc.llnl.gov/training/tutorials/slurm-and-moab#LC

##### These lines are for Slurm
#SBATCH -N 8
#SBATCH -J 2dPeregrineV02
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

##### Launch parallel job using srun
srun -n288 /g/g20/lobad1/ablateOpt/ablate \
	--input /p/lustre1/lobad1/ablateInputs/peregrineMotor.2D.V02/peregrineMotor.2D.V02.yaml \
	-yaml::environment::title 2Dn8 \
    -yaml::timestepper::arguments::ts_max_steps 10000 \
    -yaml::timestepper::domain::options::dm_refine 0


echo 'Done'
