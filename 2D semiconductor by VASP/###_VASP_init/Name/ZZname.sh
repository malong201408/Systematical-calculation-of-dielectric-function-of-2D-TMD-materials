#!/bin/bash

#Change the POSCAR names

for file in ./*.vasp; do   
    Elements=($(sed '6q;d' $file));
    echo ${Elements[@]};
    E1=$(echo "${Elements[0]}"| tr -d '\r');
    E2=$(echo "${Elements[1]}"| tr -d '\r');
    Names=$(echo "${E1}${E2}2"| tr -d '\r');
    echo $Names

    sed -i "1s/.*/$Names/g" $file

    cp $file $Names.vasp
done