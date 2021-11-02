#!/bin/bash

source env.sh

rm -fr plot_iq.exe

LIB=libplot_iq
echo "==================="
echo "  Create ${LIB}.so"
echo "==================="
OPT=(
# -v 
  -B macro_default
  -W lib:libplot_iq
  -T link:lib
  -d libplot_iq
        plot_iq.m
)

mkdir -p  libplot_iq
chmod g+w libplot_iq

ssh matlab@randy35 cd `pwd` \; /MATLAB/$REV/bin/mcc ${OPT[*]} 



SRC=plot_iq
echo "==================="
echo "  Create ${SRC}.so"
echo "==================="
OPT=(
  -Wall
  -fPIC
  -shared
  -I libplot_iq
  -I $MATLABROOT/extern/include/
  -std=c99
)

## for gcc 6.3.x
#source scl_source enable devtoolset-6
gcc ${OPT[*]} -o ${SRC}.so ${SRC}.c

echo "==================="
echo "  Create ${SRC}.exe"
echo "==================="
## for gcc 6.3.x
#source scl_source enable devtoolset-6
#gcc ${OPT[*]}  ${SRC}.c

CMD0=(
gcc
-c
-DMX_COMPAT_64
-DMATLAB_MEXCMD_RELEASE=R2018a
-DUSE_MEX_CMD
-D_GNU_SOURCE
-DUNIX
-DX11
-I"libplot_iq"
-I $MATLABROOT/extern/include/
#-I $MATLABROOT/simulink/include/
-Wall
-Wextra
-std=c99
-O2
-fwrapv
-DNDEBUG
plot_iq.c
-o plot_iq.o
)
CMD1=(
gcc
-pthread
-Wl,-rpath-link,$MATLABROOT/bin/glnxa64
-O plot_iq.o
libplot_iq/libplot_iq.so
-Llibplot_iq
#"$MATLABROOT/sys/os/glnxa64/orig/libstdc++.so.6" # for R2020b
#"$MATLABROOT/bin/glnxa64/glibc-2.17_shim.so" # for R2020b
-L"$MATLABROOT/bin/glnxa64"
-L"$MATLABROOT/runtime/glnxa64"
-lm
-lmwmclmcrrt
-o plot_iq.exe
)
${CMD0[*]}
${CMD1[*]}

MKEXE=(
gcc
#-c
-DMX_COMPAT_64
-DMATLAB_MEXCMD_RELEASE=R2018a
-DUSE_MEX_CMD
-D_GNU_SOURCE
-DUNIX
-DX11
-I"libplot_iq"
-I $MATLABROOT/extern/include/
#-I $MATLABROOT/simulink/include/
-Wall
-Wextra
-std=c99
-O2
-fwrapv
-DNDEBUG
plot_iq.c
#-o plot_iq.o

-pthread
-Wl,-rpath-link,$MATLABROOT/bin/glnxa64
#-O plot_iq.o
libplot_iq/libplot_iq.so
-Llibplot_iq
"$MATLABROOT/sys/os/glnxa64/orig/libstdc++.so.6" # for R2020b
"$MATLABROOT/bin/glnxa64/glibc-2.17_shim.so" # for R2020b
-L"$MATLABROOT/runtime/glnxa64"
-lm
-lmwmclmcrrt
-o plot_iq.exe
)
#${MKEXE[*]}


## OPT=(
## # -v
##   -R2018a
##   -Llibplot_iq
##   -Ilibplot_iq
##   libplot_iq/libplot_iq.so
##   plot_iq.c
##   CFLAGS=" $CFLAGS -Wall -Wextra -std=c99 "
## )
## 
## #export LD_PRELOAD=$MATLABROOT/bin/glnxa64/glibc-2.17_shim.so
## 
## #/MATLAB/$REV/bin/mbuild ${OPT[*]}
## #ssh matlab@randy35 cd `pwd` \; /MATLAB/$REV/bin/mbuild ${OPT[*]} 
## 
## 
## /MATLAB/$REV/bin/mbuild -R2018a \
##   -Llibplot_iq -Ilibplot_iq \
##   libplot_iq/libplot_iq.so plot_iq.c \
##   CFLAGS="$CFLAGS -Wall -Wextra -std=c99"

./plot_iq.exe
