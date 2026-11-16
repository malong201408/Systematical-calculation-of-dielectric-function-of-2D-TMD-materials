#!/bin/bash

JobName=$@;

### 1. Make the folder of steps, $1 is the name of the structure to be calculated

if [ -d "./$1" ];then
    rm -rf ./$1
fi

if [ ! -d "./$1" ];then
    mkdir ./$1
fi


## 2. Copy .xyz and python code to the folders
   cp -r ./###GPAW_init/xyz/$@.xyz ./$1/                                                      # Copy .xyz file to the folder
   cp -r ./###GPAW_init/gpaw_init/dielectric_function_intra_FD001_eta0001_kp10_xx.py ./$1/     # Copy python file to the folder

   cd ./$1/
   sed -i 's/sample/'$@'/g' dielectric_function_intra_FD001_eta0001_kp10_xx.py                 # change the names of target file

## 3. Run the pyhton jobs in each folder   
   python3 dielectric_function_intra_FD001_eta0001_kp10_xx.py                                  # run python jobs
   cd ..

       