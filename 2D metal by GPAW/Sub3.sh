#!/bin/bash

JobName=$1;
A1=$(echo "$2"| tr -d '\r');
A2=$(echo "$3"| tr -d '\r');
SubNames=$(echo "$A1$A2"| tr -d '\r');

## Extract .cvs file to new folder


if [ ! -d "./##sigma_all" ];then
    mkdir ./##sigma_all
fi


cp ./$1/df_$1_xx.csv ./##sigma_all

cd ./##sigma_all

# Remove first row and second and third column (NFL effects in .cvs)

cut -d, -f1,4- df_$1_xx.csv > df_$1_LFE_xx.csv

sed '1d' df_$1_LFE_xx.csv > diel_$1.csv

# Calculate Real and Img conductivity (in Angstrom/s) by using thickness of layers

awk -v th="$4", '{print $1 " " 10^12*$3*241.8*$1*th/(4*3.14)}' OFS=, diel_$1.csv > $1sig_Rxx.csv

awk -v th="$4", '{print $1 " " (10^12*241.8*$1*th/(4*3.14)-10^12*$2*241.8*$1*th/(4*3.14))}' OFS=, diel_$1.csv > $1sig_Imxx.csv

rm -r df_$1_xx.csv df_$1_LFE_xx.csv diel_$1.csv

cd ..