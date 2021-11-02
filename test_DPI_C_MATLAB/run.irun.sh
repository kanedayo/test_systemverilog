#!/bin/bash

MATLABROOT=/home/Tools/MATLAB/MATLAB_Runtime/v99 # R2020b [F13]
LD_LIBRARY_PATH=${MATLABROOT}/runtime/glnxa64:${MATLABROOT}/bin/glnxa64:${MATLABROOT}/sys/os/glnxa64:${MATLABROOT}/extern/bin/glnxa64

export LD_LIBRARY_PATH

OPT=(
 +nc64bit
 -disable_sem2009
 -sv_lib $MATLABROOT/bin/glnxa64/libmwmclbase.so
 -sv_lib $MATLABROOT/runtime/glnxa64/libmwmclmcrrt.so
 -sv_lib libplot_iq/libplot_iq.so
 -sv_lib plot_iq.so
 -sv plot_iq.sv
)


# Run NC
irun ${OPT[*]}

