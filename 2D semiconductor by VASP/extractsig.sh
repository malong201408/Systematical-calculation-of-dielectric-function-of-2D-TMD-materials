#!/bin/bash

awk -v th="$@" 'BEGIN{i=1;j=1} /INVERSE MACRO/,\
                /XI_TO_W/ \
                 {if (NF==3) {a[i]=$2 ; i=i+1} 
                  else if (NF==6) {b[j]=$1; j=j+1} } \
                 END{for (k=1;k<i;k++) print a[k], (10^12*241.8*a[k]*th/(4*3.14)-10^12*b[3*(k-1)+1]*241.8*a[k]*th/(4*3.14))}' OUTCAR > sig_Imxx.dat


awk -v th="$@" 'BEGIN{i=1;j=1} /INVERSE MACRO/,\
                /XI_TO_W/ \
                 {if (NF==3) {a[i]=$2 ; i=i+1} 
                  else if (NF==6) {b[j]=$2; j=j+1} } \
                 END{for (k=1;k<i;k++) print a[k], 10^12*b[3*(k-1)+1]*241.8*a[k]*th/(4*3.14)}' OUTCAR > sig_Rxx.dat


