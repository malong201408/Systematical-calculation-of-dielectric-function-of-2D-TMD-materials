#!/bin/bash

JobName=$(sed '1q;d' init$@);

echo $POTCAR_Path;
ATOMS=($(sed '3q;d' init$@));
echo ${ATOMS[@]};
A1=$(echo "${ATOMS[0]}"| tr -d '\r');
A2=$(echo "${ATOMS[1]}"| tr -d '\r');
SubNames=$(echo "${A1}${A2}"| tr -d '\r');


if [ ! -d "./#plasma" ];then
    mkdir ./#plasma
fi

cd ./$1/4_IPA/
    grep sumrule OUTCAR>preplasma$@.csv
    last_value=$(awk '{print $NF}' preplasma$@.csv)
    echo "$last_value" > pre2plasma$@.csv
    sed "s/$/ $@/" pre2plasma$@.csv >>plasma$@.csv

    rm -r preplasma$@.csv pre2plasma$@.csv

cd ..
cd ..

cp ./$1/4_IPA/plasma$@.csv ./#plasma/

cd ./$1/4_IPA/
   rm -r plasma$@.csv
cd ..
cd ..

cd ./#plasma/
   cat plasma$@.csv >>plasma_all.csv
cd ..