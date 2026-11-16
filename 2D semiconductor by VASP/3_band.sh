#!/bin/bash

#Pass Names for 3_band calculation 

for file in ./###_VASP_init/POSCAR/*.vasp; do
    Names=($(sed '1q;d' $file));
    Elements=($(sed '6q;d' $file));

    bash Sub3.sh  $Names
done