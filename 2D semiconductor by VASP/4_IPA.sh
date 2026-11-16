#!/bin/bash

#Pass Names for 4_IPA calculation 

for file in ./###_VASP_init/POSCAR/*.vasp; do
    Names=($(sed '1q;d' $file));
    Elements=($(sed '6q;d' $file));

    bash Sub4.sh  $Names
done