#!/bin/bash

JobName=$(sed '1q;d' init$@);

POTCAR_Path=$(sed '2q;d' init$@);
echo $POTCAR_Path;
ATOMS=($(sed '3q;d' init$@));
echo ${ATOMS[@]};
A1=$(echo "${ATOMS[0]}"| tr -d '\r');
A2=$(echo "${ATOMS[1]}"| tr -d '\r');
SubNames=$(echo "${A1}${A2}"| tr -d '\r');


if [ ! -d "./#Chi" ];then
    mkdir ./#Chi
fi

   cp -r ./extractnew.sh ./$1/5_Chi/extract.sh 
## 16. Calculate the thickness of layer from POSCAR
   cd ./$1/5_Chi/
   
   Upper=($(sed '10q;d' POSCAR));
   Lower=($(sed '11q;d' POSCAR));
   C=($(sed '5q;d' POSCAR));

   Up=$(echo "${Upper[2]}"| bc)
   Lo=$(echo "${Lower[2]}"| bc)
   LC=$(echo "${C[2]}"| bc)

   Thick=$(echo "$Up $Lo $LC" | awk '{print $3*($1-$2)}')
   echo $Thick
   cd ..
   cd ..

## 17. Calculate the dielectric responses of materials 
    cd ./$1/5_Chi/
    
    bash extract.sh $Thick

    mv chi_Imxx.dat $@chi_Imxx.dat
    mv chi_Imyy.dat $@chi_Imyy.dat
    mv chi_Imzz.dat $@chi_Imzz.dat
    mv chi_Rxx.dat $@chi_Rxx.dat
    mv chi_Ryy.dat $@chi_Ryy.dat
    mv chi_Rzz.dat $@chi_Rzz.dat

    sed -i '1ihw Im_epsl Thz R_sig_2D' $@chi_Imxx.dat
    sed -i '2ieV #1 Thz #2' $@chi_Imxx.dat
    sed -i '3i#3 #4 #5 #6' $@chi_Imxx.dat
    sed -i "3s/#4/$SubNames\\\-(2)/" $@chi_Imxx.dat
    sed -i "3s/#6/$SubNames\\\-(2)/" $@chi_Imxx.dat

    sed -i '1ihw Re_epsl Thz Im_sig_2D' $@chi_Rxx.dat
    sed -i '2ieV #1 Thz #2' $@chi_Rxx.dat
    sed -i '3i#3 #4 #5 #6' $@chi_Rxx.dat
    sed -i "3s/#4/$SubNames\\\-(2)/" $@chi_Rxx.dat
    sed -i "3s/#6/$SubNames\\\-(2)/" $@chi_Rxx.dat

    cd ..
    cd ..
    mv ./$1/5_Chi/$@chi_Imxx.dat ./#Chi/
    mv ./$1/5_Chi/$@chi_Rxx.dat ./#Chi/
