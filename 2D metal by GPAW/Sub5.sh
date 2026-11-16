#!/bin/bash

JobName=$1;

A1=$(echo "$2"| tr -d '\r');
A2=$(echo "$3"| tr -d '\r');
SubNames=$(echo "$A1$A2"| tr -d '\r');


# Create a #Q20 folder 

if [ ! -d "./#Q20" ];then
    mkdir ./#Q20
fi

# Move the Q_20 files to #Q20

    cp ./$1/Q_d10_$1_20.dat ./#Q20/

    cd ./#Q20/
    sed -i '1ihw	intTJoule	Qprop	Qeva' Q_d10_$1_20.dat
    sed -i '2ieV	Joule	#1	#2' Q_d10_$1_20.dat
    sed -i '3i#3	IntT(300K-400K)	#5-Q\\\-(prop)	#6-Q\\\-(evan)' Q_d10_$1_20.dat
    sed -i "3s/#5/$SubNames\\\-(2)/" Q_d10_$1_20.dat
    sed -i "3s/#6/$SubNames\\\-(2)/" Q_d10_$1_20.dat

    cd ..


    