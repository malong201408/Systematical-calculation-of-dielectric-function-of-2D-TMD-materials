#!/bin/bash

JobName=$(sed '1q;d' init$@);

POTCAR_Path=$(sed '2q;d' init$@);
echo $POTCAR_Path;
ATOMS=($(sed '3q;d' init$@));
echo ${ATOMS[@]};
A1=$(echo "${ATOMS[0]}"| tr -d '\r');
A2=$(echo "${ATOMS[1]}"| tr -d '\r');
SubNames=$(echo "${A1}${A2}"| tr -d '\r');


if [ ! -d "./#band" ];then
    mkdir ./#band
fi


## 11. Initial vaspkit calculation for band structures

    cd ./$1/3_band/
    vaspkit -task 211 -file POSCAR
    mv KLABELS KLABELS$@
    mv BAND.dat BAND$@.dat
    mv BAND_GAP BAND_GAP$@
    sed -i "3s/Band-Index/$SubNames\\\-(2)/" BAND$@.dat
    sed -i "2s/GAMMA/\\\g(G)/" KLABELS$@
    sed -i "5s/GAMMA/\\\g(G)/" KLABELS$@

    LL2=($(sed '2q;d' KLABELS$@));
    LL3=($(sed '3q;d' KLABELS$@));
    LL4=($(sed '4q;d' KLABELS$@));
    LL5=($(sed '5q;d' KLABELS$@));
    echo ${LL2[@]};
    echo ${LL3[@]};
    echo ${LL4[@]};
    echo ${LL5[@]};

    L2=$(echo "${LL2[@]}"| tr -d '\r');
    L3=$(echo "${LL3[@]}"| tr -d '\r');
    L4=$(echo "${LL4[@]}"| tr -d '\r');
    L5=$(echo "${LL5[@]}"| tr -d '\r');

    sed -i '1s/$/ Letter Coor/' BAND$@.dat
    sed -i "4s/$/ \\$L2/" BAND$@.dat
    sed -i "5s/$/ \\$L3/" BAND$@.dat
    sed -i "6s/$/ \\$L4/" BAND$@.dat
    sed -i "7s/$/ \\$L5/" BAND$@.dat

    cd ..
    cd ..

    mv ./$1/3_band/KLABELS$@ ./#band/
    mv ./$1/3_band/BAND$@.dat ./#band/
    mv ./$1/3_band/BAND_GAP$@ ./#band/

       