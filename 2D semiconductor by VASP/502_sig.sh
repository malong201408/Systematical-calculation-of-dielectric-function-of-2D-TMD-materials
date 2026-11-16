#!/bin/bash

# Calculate surface conductivities of materials

for file in ./###_VASP_init/POSCAR/*.vasp; do
    Names=($(sed '1q;d' $file));
    Elements=($(sed '6q;d' $file));

    bash Sub502.sh  $Names
done