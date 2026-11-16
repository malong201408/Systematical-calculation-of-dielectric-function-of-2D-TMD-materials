#!/bin/bash

#SBATCH --comment=#2
#SBATCH --job-name=#2
#SBATCH --ntasks=1
#SBATCH --time=3:00:00
#SBATCH --output=output.%j.test

module purge
module load apps/mathematica/12.3

math < Qfn.m