#!/bin/bash

JobName=$1;

A1=$(echo "$2"| tr -d '\r');
A2=$(echo "$3"| tr -d '\r');
SubNames=$(echo "$A1$A2"| tr -d '\r');


# Create a #HTP folder 

if [ ! -d "./#HTP" ];then
    mkdir ./#HTP
fi

# Append files of HTP_vs_distance into LHTP.dat file 

   cp ./$1/LQdata_d0_$1_10.dat ./$1/P_LHTPall_$1.dat
   cp ./$1/LQdata_d10_$1_100.dat ./$1/P_LHTP10.dat
   cp ./$1/LQdata_d100_$1_1000.dat ./$1/P_LHTP100.dat
   cp ./$1/LQdata_d1000_$1_2000.dat ./$1/P_LHTP1000.dat

# Creat a total column in each file
   cd ./$1/
   awk '{print $0 "	" $2+$3}' P_LHTPall_$1.dat > LHTPall_$1.dat
   awk '{print $0 "	" $2+$3}' P_LHTP10.dat > LHTP10.dat
   awk '{print $0 "	" $2+$3}' P_LHTP100.dat > LHTP100.dat
   awk '{print $0 "	" $2+$3}' P_LHTP1000.dat > LHTP1000.dat

# Append files

#   sed -i '1i\\' LHTP10.dat
#   sed -i '1i\\' LHTP100.dat
#   sed -i '1i\\' LHTP1000.dat

   cat LHTP10.dat >> LHTPall_$1.dat
   cat LHTP100.dat >> LHTPall_$1.dat
   cat LHTP1000.dat >> LHTPall_$1.dat

   sed -i '1iDistance	Phipropbb	Phievabb	Phitotbb' LHTPall_$1.dat
   sed -i '2inm	#1	#2	#3' LHTPall_$1.dat
   sed -i '3i#4	#5-prop	#6-evan	#7-total' LHTPall_$1.dat
   sed -i "3s/#5/$SubNames\\\-(2)/" LHTPall_$1.dat
   sed -i "3s/#6/$SubNames\\\-(2)/" LHTPall_$1.dat
   sed -i "3s/#7/$SubNames\\\-(2)/" LHTPall_$1.dat
 
   rm LHTP10.dat LHTP100.dat LHTP1000.dat P_LHTPall_$1.dat P_LHTP10.dat P_LHTP100.dat P_LHTP1000.dat

   cd ..

   cp ./$1/LHTPall_$1.dat ./#HTP/