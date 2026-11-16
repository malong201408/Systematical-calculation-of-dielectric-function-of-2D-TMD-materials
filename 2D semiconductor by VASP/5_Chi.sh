#!/bin/bash

#Pass Names for 5_Chi calculation 

for file in ./###_VASP_init/POSCAR/*.vasp; do
    Names=($(sed '1q;d' $file));
    Elements=($(sed '6q;d' $file));

    bash Sub5.sh  $Names
done