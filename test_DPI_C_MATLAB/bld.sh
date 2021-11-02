#!/bin/bash

source env.sh

rm -fr plot_iq

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


#gcc -Wall -fPIC -shared -o plot_iq.so plot_iq.c

SRC=plot_iq
OPT=(
  -Wall
  -fPIC
  -shared
  -I libplot_iq
  -I $MATLABROOT/extern/include/
  -std=c99
)

gcc ${OPT[*]} -o ${SRC}.so ${SRC}.c

export LD_PRELOAD=$MATLABROOT/bin/glnxa64/glibc-2.17_shim.so

OPT=(
  -Wall
  -Wextra
  -I libplot_iq
  -I $MATLABROOT/extern/include/
  #-L $MATLABROOT/bin/glnxa64/libmwmclbase.so
  #-L $MATLABROOT/runtime/glnxa64/libmwmclmcrrt.so
  #-L $MATLABROOT/bin/glnxa64/
-L $MATLABROOT/bin/glnxa64/glibc-2.17_shim.so
-L $MATLABROOT/bin/glnxa64/
  -L $MATLABROOT/runtime/glnxa64/
  #-lmwmclbase
  -lmwmclmcrrt
  -std=c99
)

#gcc ${OPT[*]}  ${SRC}.c

OPT=(
# -v
  -R2018a
  -Llibplot_iq
  -Ilibplot_iq
  libplot_iq/libplot_iq.so
  plot_iq.c
  CFLAGS=" $CFLAGS -Wall -Wextra -std=c99 "
)
#/MATLAB/$REV/bin/mbuild ${OPT[*]}
#ssh matlab@randy35 cd `pwd` \; /MATLAB/$REV/bin/mbuild ${OPT[*]} 

/MATLAB/$REV/bin/mbuild -R2018a \
  -Llibplot_iq -Ilibplot_iq \
  libplot_iq/libplot_iq.so plot_iq.c \
  CFLAGS="$CFLAGS -Wall -Wextra -std=c99"

./plot_iq
