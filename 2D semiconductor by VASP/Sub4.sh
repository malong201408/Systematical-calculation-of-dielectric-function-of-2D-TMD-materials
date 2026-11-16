#!/bin/bash

JobName=$(sed '1q;d' init$@);

POTCAR_Path=$(sed '2q;d' init$@);
echo $POTCAR_Path;
ATOMS=($(sed '3q;d' init$@));
echo ${ATOMS[@]};


## 12. Copy  WAVECAR from 2_SCF to 4_IPA

   cp ./$1/2_SCF/WAVECAR ./$1/4_IPA/WAVECAR;   

## 13. Initiate VASP job 

    cd ./$1/4_IPA/
    qsub run.sh
    

       