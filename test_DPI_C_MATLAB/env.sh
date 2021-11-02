#!/bin/bash

REV=R2019a; VER=v96 # G2
#REV=R2020a; VER=v98
#REV=R2020b; VER=v99 # F13
#REV=R2021b; VER=v911 # OB8

MATLABRUNTIME=/home/Tools/MATLAB/MATLAB_Runtime/$VER
MATLABROOT=$MATLABRUNTIME

# for mbuild
PATH=/usr/local/bin:/bin:/usr/bin
#PATH+=:/MATLAB/$REV/bin
PATH+=:$MATLABRUNTIME/bin
export PATH


## for gcc 6.3.x
source scl_source enable devtoolset-6

## for matlab runtime
LIBPATH=(
 ./
 $MATLABRUNTIME/runtime/glnxa64
 $MATLABRUNTIME/bin/glnxa64
 $MATLABRUNTIME/sys/os/glnxa64
 $MATLABRUNTIME/extern/bin/glnxa64
)

LD_LIBRARY_PATH=$(IFS=: ; echo "${LIBPATH[*]}")
export LD_LIBRARY_PATH

