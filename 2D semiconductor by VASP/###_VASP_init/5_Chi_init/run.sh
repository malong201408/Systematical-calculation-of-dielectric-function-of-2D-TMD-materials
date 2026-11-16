#!/bin/bash

#SBATCH --job-name=Chi
#SBATCH --qos=snsm19
#SBATCH --partition=snsm_itn19
#SBATCH --output=output.%j
#SBATCH --time=48:00:00
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=2
#SBATCH --mem-per-cpu=65536
#SBATCH --mail-user=longm2@usf.edu


module purge
module add apps/vasp/6.2.0

mpirun vasp
