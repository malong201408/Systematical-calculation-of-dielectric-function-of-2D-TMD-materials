#!/bin/bash

# Extract Q function at 20nm separation

for file in ./###_VASP_init/POSCAR/*.vasp; do
    Names=($(sed '1q;d' $file));
    Elements=($(sed '6q;d' $file));

    bash Sub601.sh  $Names
done