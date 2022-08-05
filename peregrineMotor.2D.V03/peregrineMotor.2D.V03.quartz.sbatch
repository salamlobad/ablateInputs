#!/bin/bash
#### See https://hpc.llnl.gov/training/tutorials/slurm-and-moab#LC

##### These lines are for Slurm
#SBATCH -N 1
#SBATCH -J 2dPeregrineV03
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
# velocity = "min(8.49762066621,8.49762066621*t/0.75) , 0.0"
# G 25
# velocity = "min(21.2440516655,21.2440516655*t/0.75) , 0.0"
# G 50
# velocity = "min(42.4881033311,42.4881033311*t/0.75) , 0.0"
# G 100
# velocity = "min(84.9762066621,84.9762066621*t/0.75) , 0.0"
# G 150
# velocity = "min(127.464309993,127.464309993*t/0.75) , 0.0"
# G 200
# velocity = "min(169.952413324,169.952413324*t/0.75) , 0.0"
# G 300
# velocity = "min(254.928619986,254.928619986*t/0.75) , 0.0"

##### Launch parallel job using srun
srun -n36 /g/g20/lobad1/ablateOpt/ablate \
        --input /p/lustre1/lobad1/ablateInputs/peregrineMotor.2D.V03/peregrineMotor.2D.V03.yaml \
        -yaml::environment::title 2Dn1peregrineSetATestA10 \
        -yaml::timestepper::arguments::ts_max_steps 500000 \
        -yaml::timestepper::io::interval 250 \
        -yaml::timestepper::domain::options::dm_refine 0 \
        -yaml::solvers::[1]::processes::[0]::velocity "min(42.4881033311,42.4881033311*t/0.01) , 0.0"

echo 'Done'
