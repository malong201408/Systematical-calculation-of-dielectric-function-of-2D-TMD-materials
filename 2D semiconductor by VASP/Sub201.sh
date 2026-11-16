#!/bin/bash

JobName=$(sed '1q;d' init$@);

POTCAR_Path=$(sed '2q;d' init$@);
echo $POTCAR_Path;
ATOMS=($(sed '3q;d' init$@));
echo ${ATOMS[@]};
A1=$(echo "${ATOMS[0]}"| tr -d '\r');
A2=$(echo "${ATOMS[1]}"| tr -d '\r');
SubNames=$(echo "${A1}${A2}"| tr -d '\r');


if [ ! -d "./#DOS" ];then
    mkdir ./#DOS
fi


## 6. Initiate vaspkit calculation for DOS 
    cd ./$1/2_SCF/
    vaspkit -task 111 -file POSCAR
    mv TDOS.dat TDOS$@.dat
    sed -i '2i       #1        #2' TDOS$@.dat
    sed -i '3i       #3        #4' TDOS$@.dat
    sed -i "3s/#4/$SubNames\\\-(2)/" TDOS$@.dat

    cd ..
    cd ..
    mv ./$1/2_SCF/TDOS$@.dat ./#DOS/


    

       