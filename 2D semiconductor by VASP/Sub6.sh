#!/bin/bash

JobName=$(sed '1q;d' init$@);

POTCAR_Path=$(sed '2q;d' init$@);
echo $POTCAR_Path;
ATOMS=($(sed '3q;d' init$@));
echo ${ATOMS[@]};


### 1. Make the folder of steps, $1 is the name of the structure to be calculated

if [ -d "./$1" ];then
    rm -rf ./$1
fi

if [ ! -d "./$1" ];then
    mkdir ./$1
fi
     
### 2. Copy sigma files and .m file to the folder

    cp -r ./#sigma/$@sig_Imxx.dat $1
    cp -r ./#sigma/$@sig_Rxx.dat $1
    cp -r ./Qfn.m ./$1/Qfn.m
    cp -r ./run.sh $1
 
### 3. Change the corresponding input and export file names in .m and run.sh file
    
    cd $1
    sed -i "/#1/s/#1/$@/" Qfn.m
    sed -i "/#2/s/#2/$@_Qfn/" run.sh
    cd ..

### 4. Run the mathematica job

    cd $1

    #SBATCH --job-name=$@
    #SBATCH --ntasks=1
    #SBATCH --time=2:00:00
    #SBATCH --output=output.%j.test

    module purge
    module load apps/mathematica/12.3

    math < Qfn.m

    cd ..