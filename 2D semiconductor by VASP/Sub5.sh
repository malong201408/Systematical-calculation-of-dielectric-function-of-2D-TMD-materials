#!/bin/bash

JobName=$(sed '1q;d' init$@);

POTCAR_Path=$(sed '2q;d' init$@);
echo $POTCAR_Path;
ATOMS=($(sed '3q;d' init$@));
echo ${ATOMS[@]};


## 14. Copy  WAVECAR WAVEDER from 4_IPA to 5_Chi

   cp ./$1/4_IPA/WAVECAR ./$1/5_Chi/WAVECAR;
   cp ./$1/4_IPA/WAVEDER ./$1/5_Chi/WAVEDER;      

## 15. Initiate VASP job 

    cd ./$1/5_Chi/
    qsub run.sh
    

       