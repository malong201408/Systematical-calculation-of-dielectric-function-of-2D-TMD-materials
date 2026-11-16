#!/bin/bash

#Change the names of .xyz files

for file in ./*.xyz; do   
    Elements=($(sed 's/ .*//' $file));
    echo ${Elements[@]};
    E1=$(echo "${Elements[2]}"| tr -d '\r');
    E2=$(echo "${Elements[3]}"| tr -d '\r');
    Names=$(echo "${E1}${E2}2"| tr -d '\r');
    echo $Names

    cp $file $Names.xyz
done