#!/bin/bash

#SBATCH --job-name=SC
#SBATCH --qos=snsm19
#SBATCH --partition=snsm_itn19
#SBATCH --output=output.%j
#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --mem-per-cpu=8192
#SBATCH --mail-user=longm2@usf.edu


module purge
module add apps/vasp/6.2.0

mpirun vasp
