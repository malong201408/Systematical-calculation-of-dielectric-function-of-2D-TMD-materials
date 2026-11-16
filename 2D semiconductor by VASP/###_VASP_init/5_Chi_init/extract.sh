#!/bin/bash

awk 'BEGIN{i=1;j=1} /INVERSE MACRO/,\
                /XI_TO_W/ \
                 {if (NF==3) {a[i]=$2 ; i=i+1} 
                  else if (NF==6) {b[j]=$1; j=j+1} } \
     END{for (k=1;k<i;k++) print a[k], b[3*(k-1)+1]}' OUTCAR > chi_Rxx.dat


awk 'BEGIN{i=1;j=1} /INVERSE MACRO/,\
                /XI_TO_W/ \
                 {if (NF==3) {a[i]=$2 ; i=i+1} 
                  else if (NF==6) {b[j]=$3; j=j+1} } \
     END{for (k=1;k<i;k++) print a[k], b[3*(k-1)+2]}' OUTCAR > chi_Ryy.dat

awk 'BEGIN{i=1;j=1} /INVERSE MACRO/,\
                /XI_TO_W/ \
                 {if (NF==3) {a[i]=$2 ; i=i+1} 
                  else if (NF==6) {b[j]=$5; j=j+1} } \
     END{for (k=1;k<i;k++) print a[k], b[3*(k-1)+3]}' OUTCAR > chi_Rzz.dat

awk 'BEGIN{i=1;j=1} /INVERSE MACRO/,\
                /XI_TO_W/ \
                 {if (NF==3) {a[i]=$2 ; i=i+1} 
                  else if (NF==6) {b[j]=$2; j=j+1} } \
     END{for (k=1;k<i;k++) print a[k], b[3*(k-1)+1]}' OUTCAR > chi_Imxx.dat

awk 'BEGIN{i=1;j=1} /INVERSE MACRO/,\
                /XI_TO_W/ \
                 {if (NF==3) {a[i]=$2 ; i=i+1} 
                  else if (NF==6) {b[j]=$4; j=j+1} } \
     END{for (k=1;k<i;k++) print a[k], b[3*(k-1)+2]}' OUTCAR > chi_Imyy.dat

awk 'BEGIN{i=1;j=1} /INVERSE MACRO/,\
                /XI_TO_W/ \
                 {if (NF==3) {a[i]=$2 ; i=i+1} 
                  else if (NF==6) {b[j]=$6; j=j+1} } \
     END{for (k=1;k<i;k++) print a[k], b[3*(k-1)+3]}' OUTCAR > chi_Imzz.dat

