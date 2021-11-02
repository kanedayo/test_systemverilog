#!/bin/bash

SRC=sample
INCDIR=/home/Tools/Cadence/INCISIVE15.20.010/tools/include/
OPT=(
  -Wall
  -fPIC
  -shared
  -std=c99
  -I $INCDIR
  -o ${SRC}.so
     ${SRC}.c
)

gcc ${OPT[*]}

## OPT=(
##  +nc64bit
##  -disable_sem2009
##  -sv_lib ${SRC}.so
##  -sv ${SRC}.sv
## )
## 
## # NG: Unsupported unpacked array datatype in formal argument.
## irun ${OPT[*]}

xvlog -sv ${SRC}.sv 
xelab  test -sv_lib ${SRC}.so  -R


#rm -fr INCA_libs

rm -fr irun.*
rm -fr xsim*
rm -fr webtalk*
rm -fr xelab.*
rm -fr xvlog.*

rm -fr sample.so
