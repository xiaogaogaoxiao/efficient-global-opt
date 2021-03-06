#!/bin/sh

#SBATCH -J "afsndEE_mosek"
#SBATCH --array=0-14999%4096
#SBATCH --account=p_mwrc
#SBATCH --time=23:59:59
#SBATCH --mem-per-cpu=2583
#SBATCH --partition=haswell
#SBATCH --cpus-per-task=1
#SBATCH --output=/scratch/p_mwrc/log/%x-wp_%a-job_%A.out

export JOB_BASEDIR="/scratch/p_mwrc/${SLURM_JOB_NAME}"
export JOB_HPC_SAVEDIR="${JOB_BASEDIR}/results"

if [ ! -d ${JOB_BASEDIR} ]; then
	mkdir ${JOB_BASEDIR}
	mkdir ${JOB_HPC_SAVEDIR}
fi

EXE=$(readlink -e ../code/afsndEE_mosek)
DATA=$(readlink -e ../data/wp.h5)

module load foss
module load GCC
module load mosek
module load Gurobi

# for better error reporting (ticket 2018071041004097)
echo $LD_LIBRARY_PATH
ls -la $EBROOTGUROBI/lib/libgurobi80.so

dmtcp_launch $EXE $DATA
