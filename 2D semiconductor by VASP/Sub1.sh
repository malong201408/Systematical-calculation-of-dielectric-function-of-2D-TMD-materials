#!/bin/bash

JobName=$(sed '1q;d' init$@);

POTCAR_Path=$(sed '2q;d' init$@);
echo $POTCAR_Path;
ATOMS=($(sed '3q;d' init$@));
echo ${ATOMS[@]};

### 1. Make the folder of steps, $1 is the name of the structure to be calculated

if [ -d "./$1" ];then
    rm -rf ./$1
fi

if [ ! -d "./$1" ];then
    mkdir ./$1
fi

if [ -d "./$1/1_relax" ];then
    rm -rf ./$1/1_relax
fi
if [ ! -d "./$1/1_relax" ];then
    mkdir ./$1/1_relax
fi

if [ -d "./$1/2_SCF" ];then
    rm -rf ./$1/2_SCF
fi
if [ ! -d "./$1/2_SCF" ];then
    mkdir ./$1/2_SCF
fi

if [ -d "./$1/3_band" ];then
    rm -rf ./$1/3_band
fi
if [ ! -d "./$1/3_band" ];then
    mkdir ./$1/3_band
fi

if [ -d "./$1/4_IPA" ];then
    rm -rf ./$1/4_IPA
fi
if [ ! -d "./$1/4_IPA" ];then
    mkdir ./$1/4_IPA
fi

if [ -d "./$1/5_Chi" ];then
    rm -rf ./$1/5_Chi
fi
if [ ! -d "./$1/5_Chi" ];then
    mkdir ./$1/5_Chi
fi



## 2. Copy INCAR, POSCAR, POTCAR, run.sh to the folders
    cp -r ./###_VASP_init/1_relax_init/. ./$1/1_relax                    # Copy INCAR, run.sh to the 1_relax folder
    sed -i "1s/SYSTEM/SYSTEM = $1/g" ./$1/1_relax/INCAR                # Change the system name in INCAR file

    cp -r ./###_VASP_init/2_SCF_init/. ./$1/2_SCF                        # Copy INCAR, run.sh to the 2_SCF folder
    sed -i "1s/SYSTEM/SYSTEM = $1/g" ./$1/2_SCF/INCAR                  # Change the system name in INCAR file

    cp -r ./###_VASP_init/3_band_init/. ./$1/3_band                      # Copy INCAR, run.sh to the 3_band folder
    sed -i "1s/SYSTEM/SYSTEM = $1/g" ./$1/3_band/INCAR                 # Change the system name in INCAR file

    cp -r ./###_VASP_init/4_IPA_init/. ./$1/4_IPA                        # Copy INCAR, run.sh to the 4_IPA folder
    sed -i "1s/SYSTEM/SYSTEM = $1/g" ./$1/4_IPA/INCAR                  # Change the system name in INCAR file

    cp -r ./###_VASP_init/5_Chi_init/. ./$1/5_Chi                        # Copy INCAR, run.sh to the 5_Chi folder
    sed -i "1s/SYSTEM/SYSTEM = $1/g" ./$1/5_Chi/INCAR                  # Change the system name in INCAR file
  
    cp ./###_VASP_init/POSCAR/$1.vasp ./$1/1_relax/$i/POSCAR           # Copy POSCAR to 1_relax folder

    touch ./$1/1_relax/POTCAR                 # Create an empty file to write POTCAR
    
    for j in "${ATOMS[@]}"; do                   # Create POTCAR file frome the potential folder
	cat $POTCAR_Path/$j/POTCAR >> ./$1/1_relax/POTCAR
    done    
    
    for i in ./$1/2_SCF/ ./$1/3_band/ ./$1/4_IPA/ ./$1/5_Chi/; do
        cp ./$1/1_relax/POTCAR $i; 
    done                                                               #Copy POTCAR into each folder

    cd ./$1/1_relax/
    vaspkit -task 102 -file POSCAR -kpr 0.04
    cd ..  
    cd ..                                                              #Calculate KPOINTS with Vaspkit. Control the grid with 0.04

    for i in ./$1/2_SCF/ ./$1/3_band/ ./$1/4_IPA/ ./$1/5_Chi/; do
        cp ./$1/1_relax/KPOINTS $i; 
    done                                                               #Copy POTCAR into each folder


## 3. Initiate VASP job in 1_relax

    cd ./$1/1_relax/
    qsub run.sh
    

       