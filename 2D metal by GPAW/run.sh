#!/bin/bash
#SBATCH --comment=#2
#SBATCH --job-name=#2
#SBATCH --qos=snsm19
#SBATCH --partition=snsm_itn19
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=24:00:00
#SBATCH --output=output.%j.test

module purge
module load apps/mathematica/12.3

math < Qfn.m