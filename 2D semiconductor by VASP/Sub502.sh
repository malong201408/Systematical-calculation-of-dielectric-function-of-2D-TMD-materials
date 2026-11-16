#!/bin/bash

JobName=$(sed '1q;d' init$@);

POTCAR_Path=$(sed '2q;d' init$@);
echo $POTCAR_Path;
ATOMS=($(sed '3q;d' init$@));
echo ${ATOMS[@]};
A1=$(echo "${ATOMS[0]}"| tr -d '\r');
A2=$(echo "${ATOMS[1]}"| tr -d '\r');
SubNames=$(echo "${A1}${A2}"| tr -d '\r');


if [ ! -d "./#sigma" ];then
    mkdir ./#sigma
fi

   cp -r ./extractsig.sh ./$1/5_Chi/extract.sh 
## 18. Calculate the thickness of layer from POSCAR
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

## 19. Calculate the surface conductivities of materials 
    cd ./$1/5_Chi/
    
    bash extract.sh $Thick

    mv sig_Imxx.dat $@sig_Imxx.dat
    mv sig_Rxx.dat $@sig_Rxx.dat

#    sed -i '1ihw Im_sig_2D' $@sig_Imxx.dat
#    sed -i '2ieV #2' $@sig_Imxx.dat
#    sed -i '3i#3 #4' $@sig_Imxx.dat
#    sed -i "3s/#4/$SubNames\\\-(2)/" $@sig_Imxx.dat

#    sed -i '1ihw Re_sig_2D' $@sig_Rxx.dat
#    sed -i '2ieV #2' $@sig_Rxx.dat
#    sed -i '3i#3 #4' $@sig_Rxx.dat
#    sed -i "3s/#4/$SubNames\\\-(2)/" $@sig_Rxx.dat

    cd ..
    cd ..
    mv ./$1/5_Chi/$@sig_Imxx.dat ./#sigma/
    mv ./$1/5_Chi/$@sig_Rxx.dat ./#sigma/
