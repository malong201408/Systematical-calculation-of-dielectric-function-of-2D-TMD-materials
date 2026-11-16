#!/bin/bash

JobName=$(sed '1q;d' init$@);

POTCAR_Path=$(sed '2q;d' init$@);
echo $POTCAR_Path;
ATOMS=($(sed '3q;d' init$@));
echo ${ATOMS[@]};


## 6. Prepare KPOINTS for band calculations.

    cd ./$1/3_band/
    vaspkit -task 302 -file POSCAR
    mv -f KPATH.in KPOINTS

    cd ..
    cd ..

## 9. Copy CHG CHGCAR WAVECAR from 2_SCF to 3_band

   cp ./$1/2_SCF/CHG ./$1/3_band/CHG;
   cp ./$1/2_SCF/CHGCAR ./$1/3_band/CHGCAR;
   cp ./$1/2_SCF/WAVECAR ./$1/3_band/WAVECAR;   

## 10. Initiate VASP job in 3_band

    cd ./$1/3_band/
    qsub run.sh
    

       