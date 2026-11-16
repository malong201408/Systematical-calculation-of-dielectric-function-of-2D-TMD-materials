#!/bin/bash

JobName=$(sed '1q;d' init$@);

POTCAR_Path=$(sed '2q;d' init$@);
echo $POTCAR_Path;
ATOMS=($(sed '3q;d' init$@));
echo ${ATOMS[@]};
A1=$(echo "${ATOMS[0]}"| tr -d '\r');
A2=$(echo "${ATOMS[1]}"| tr -d '\r');
SubNames=$(echo "${A1}${A2}"| tr -d '\r');


if [ ! -d "./#sigma12" ];then
    mkdir ./#sigma12
fi
   cp ./#sigma/$@sig_Rxx.dat ./#sigma12/$@sig_Rxx.dat

   cd ./#sigma12/

   head -n 12 $@sig_Rxx.dat > $@sig12_Rxx.dat

   rm $@sig_Rxx.dat

   cd ..