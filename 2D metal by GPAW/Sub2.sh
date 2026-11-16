#!/bin/bash

JobName=$1;
A1=$(echo "$2"| tr -d '\r');
A2=$(echo "$3"| tr -d '\r');
SubNames=$(echo "$A1$A2"| tr -d '\r');


## Extract .cvs file to new folder


if [ ! -d "./##diel_all" ];then
    mkdir ./##diel_all
fi

if [ ! -d "./##pola_all" ];then
    mkdir ./##pola_all
fi

cp ./$1/df_$1_xx.csv ./##diel_all/
cp ./$1/pola_$1_xx.csv ./##pola_all/

cd ./##diel_all

    sed -i '1ihw, Re_NLF, Im_NLF, Re_LFE, Im_LFE' df_$1_xx.csv
    sed -i '2ieV, #1, #2, #3, #4' df_$1_xx.csv
    sed -i '3i#5, #6, #7, #8, #9' df_$1_xx.csv
    sed -i "3s/#8/Re(\\\g(e))\-$SubNames\\\-(2)/" df_$1_xx.csv
    sed -i "3s/#9/Im(\\\g(e))\-$SubNames\\\-(2)/" df_$1_xx.csv

cd ..

cd ./##pola_all

    sed -i '1ihw, Re_NLF, Im_NLF, Re_LFE, Im_LFE' pola_$1_xx.csv
    sed -i '2ieV, #1, #2, #3, #4' pola_$1_xx.csv
    sed -i '3i#5, #6, #7, #8, #9' pola_$1_xx.csv
    sed -i "3s/#8/Re(\\\g(e))\-$SubNames\\\-(2)/" pola_$1_xx.csv
    sed -i "3s/#9/Im(\\\g(e))\-$SubNames\\\-(2)/" pola_$1_xx.csv

cd ..
