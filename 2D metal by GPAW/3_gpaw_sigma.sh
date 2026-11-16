#!/bin/bash

##Import Names, Elements, and Thickness of layer into subcode

for file in ./###GPAW_init/xyz/*.xyz; do
    Elements=($(sed 's/ .*//' $file));
    E1=$(echo "${Elements[2]}"| tr -d '\r');
    E2=$(echo "${Elements[3]}"| tr -d '\r');
    Names=$(echo "${E1}${E2}2"| tr -d '\r');
    echo $Names

    Upper=($(sed '4q;d' $file));
    Lower=($(sed '5q;d' $file));

    Up=$(echo "${Upper[3]}"| bc)
    Lo=$(echo "${Lower[3]}"| bc)

    Thick=$(echo "$Up $Lo" | awk '{print ($1-$2)}')
    echo $Thick


    bash Sub3.sh $Names $E1 $E2 $Thick

done