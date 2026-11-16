#!/bin/bash

#Generate init files for candidates

for file in ./###GPAW_init/xyz/*.xyz; do
    Elements=($(sed 's/ .*//' $file));
    E1=$(echo "${Elements[2]}"| tr -d '\r');
    E2=$(echo "${Elements[3]}"| tr -d '\r');
    Names=$(echo "${E1}${E2}2"| tr -d '\r');
    echo $Names

    bash Sub2.sh $Names $E1 $E2

done