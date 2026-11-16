#!/bin/bash

JobName=$(sed '1q;d' init$@);

POTCAR_Path=$(sed '2q;d' init$@);
echo $POTCAR_Path;
ATOMS=($(sed '3q;d' init$@));
echo ${ATOMS[@]};
A1=$(echo "${ATOMS[0]}"| tr -d '\r');
A2=$(echo "${ATOMS[1]}"| tr -d '\r');
A3=$(echo "$@"| tr -d '\r');
SubNames=$(echo "${A1}${A2}"| tr -d '\r');


# Create a #Q20 folder 

if [ ! -d "./#Q20" ];then
    mkdir ./#Q20
fi

# Move the Q_20 files to #Q20

    cp ./$1/Q_d10_$@_20.dat ./#Q20/

    cd ./#Q20/
    sed -i '1ihw	intTJoule	Qprop	Qeva' Q_d10_$@_20.dat
    sed -i '2ieV	Joule	#1	#2' Q_d10_$@_20.dat
    sed -i '3i#3	IntT(300K-400K)	#5-Q\\\-(prop)	#6-Q\\\-(evan)' Q_d10_$@_20.dat
    sed -i "3s/#5/$SubNames\\\-(2)/" Q_d10_$@_20.dat
    sed -i "3s/#6/$SubNames\\\-(2)/" Q_d10_$@_20.dat

    cd ..


    