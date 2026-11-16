#!/bin/bash

JobName=$1;
A1=$(echo "$2"| tr -d '\r');
A2=$(echo "$3"| tr -d '\r');
SubNames=$(echo "$A1$A2"| tr -d '\r');


### 1. Make the folder of steps, $1 is the name of the structure to be calculated

if [ -d "./$1" ];then
    rm -rf ./$1
fi

if [ ! -d "./$1" ];then
    mkdir ./$1
fi
     
### 2. Copy sigma files and .m file to the folder

    cp -r ./##sigma_all/$@sig_Imxx.csv $1
    cp -r ./##sigma_all/$@sig_Rxx.csv $1
    cp -r ./Qfn.m $1
    cp -r ./run.sh $1
 
### 3. Change the corresponding input and export file names in .m and run.sh file
    
    cd $1
    sed -i "/#1/s/#1/$@/" Qfn.m
    sed -i "/#2/s/#2/$@_Qfn/" run.sh
    cd ..

### 4. Run the mathematica job

    cd $1
    bash run.sh
    cd ..