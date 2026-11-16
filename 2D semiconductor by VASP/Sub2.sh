#!/bin/bash

JobName=$(sed '1q;d' init$@);

POTCAR_Path=$(sed '2q;d' init$@);
echo $POTCAR_Path;
ATOMS=($(sed '3q;d' init$@));
echo ${ATOMS[@]};


## 4. Copy CONCAR from 1_relax to all the others.

    cp ./$1/1_relax/CONTCAR ./$1/1_relax/CONTCAR1;
    mv -f ./$1/1_relax/CONTCAR ./$1/1_relax/POSCAR;
    mv -f ./$1/1_relax/CONTCAR1 ./$1/1_relax/CONTCAR;                    #Update CONTCAR into POSCAR

    for i in ./$1/2_SCF/ ./$1/3_band/ ./$1/4_IPA/ ./$1/5_Chi/; do
        cp ./$1/1_relax/POSCAR $i;
    done                                                                 #Copy POSCAR into other folders



## 5. Initiate VASP job in 2_SCF

    cd ./$1/2_SCF/
    qsub run.sh
    

       