#!/bin/bash

JobName=$(sed '1q;d' init$@);

POTCAR_Path=$(sed '2q;d' init$@);
echo $POTCAR_Path;
ATOMS=($(sed '3q;d' init$@));
echo ${ATOMS[@]};
A1=$(echo "${ATOMS[0]}"| tr -d '\r');
A2=$(echo "${ATOMS[1]}"| tr -d '\r');
A3=$(echo "$@"| tr -d '\r');
SubNames=$(echo "${A1}${A2}"| tr -d '\r');


# Create a #HTP folder 

if [ ! -d "./#HTP" ];then
    mkdir ./#HTP
fi

# Append files of HTP_vs_distance into LHTP.dat file 

   cp ./$1/LQdata_d0_$@_10.dat ./$1/LHTPall_$@.dat
   cp ./$1/LQdata_d10_$@_100.dat ./$1/LHTP10.dat
   cp ./$1/LQdata_d100_$@_1000.dat ./$1/LHTP100.dat
   cp ./$1/LQdata_d1000_$@_2000.dat ./$1/LHTP1000.dat

   cd ./$1/
   sed -i '1i\\' LHTP10.dat
   sed -i '1i\\' LHTP100.dat
   sed -i '1i\\' LHTP1000.dat

   cat LHTP10.dat >> LHTPall_$@.dat
   cat LHTP100.dat >> LHTPall_$@.dat
   cat LHTP1000.dat >> LHTPall_$@.dat

   sed -i '1iDistance	Phipropbb	Phievabb	Phitotbb' LHTPall_$@.dat
   sed -i '2inm	#1	#2	#3' LHTPall_$@.dat
   sed -i '3i#4	#5-prop	#6-evan	#7-tot' LHTPall_$@.dat
   sed -i "3s/#5/$SubNames\\\-(2)/" LHTPall_$@.dat
   sed -i "3s/#6/$SubNames\\\-(2)/" LHTPall_$@.dat
   sed -i "3s/#7/$SubNames\\\-(2)/" LHTPall_$@.dat

   cd ..

   cp ./$1/LHTPall_$@.dat ./#HTP/