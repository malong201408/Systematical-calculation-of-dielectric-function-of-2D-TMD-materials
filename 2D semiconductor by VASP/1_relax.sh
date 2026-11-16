#!/bin/bash

#Generate init files for candidates

for file in ./###_VASP_init/POSCAR/*.vasp; do
    Names=($(sed '1q;d' $file));
    Elements=($(sed '6q;d' $file));
    echo $Names;
    echo $Names > init$Names; 
    echo "/apps/vasp/5.3.5/potpaw_PBE.52" >>init$Names; 
    ele=$(echo "${Elements[@]}"| tr -d '\r');
    echo $ele>>init$Names

    bash Sub1.sh $Names

done