#!/bin/bash

source env.sh

###########
# INCISIVE
#
CDS_LIC_FILE=5280@randy39:5281@randy39:5282@randy39:5283@randy39:5284@randy39:5285@randy39:5286@randy39:5287@randy39:5288@randy39:5289@randy39
export CDS_LIC_FILE

CDSHOME=/home/Tools/Cadence/INCISIVE15.20.010
PATH+=:$CDSHOME/tools/bin
export PATH

LD_LIBRARY_PATH+=:$CDSHOME/tools/lib
export LD_LIBRARY_PATH

echo "==================="
echo "  Run ${LIB}.sv"
echo "==================="
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

