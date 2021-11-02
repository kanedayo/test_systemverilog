#!/bin/bash

########################################################
#cf. https://support.xilinx.com/s/article/72130?language=ja
#AR# 72130:
#   「/libstdc++.so.6: version `CXXABI_1.3.11' not found」
#   というエラー メッセージが表示される


#MATLABROOT=/home/Tools/MATLAB/MATLAB_Runtime/v99 # R2020b [F13]
#LD_LIBRARY_PATH=${MATLABROOT}/runtime/glnxa64:${MATLABROOT}/bin/glnxa64:${MATLABROOT}/sys/os/glnxa64:${MATLABROOT}/extern/bin/glnxa64
#export LD_LIBRARY_PATH

source env.sh

source /home/Tools/Xilinx/Vivado/2020.1/settings64.sh
LICENSE_FILE=(
  2100@192.168.1.39
  2102@192.168.1.39
  2104@192.168.1.39
  2106@192.168.1.39
  2108@192.168.1.39
)
XILINXD_LICENSE_FILE=$(IFS=: ; echo "${LICENSE_FILE[*]}")
export XILINXD_LICENSE_FILE


 #-sv_lib /opt/rh/devtoolset-6/root/lib/gcc/x86_64-redhat-linux/6.3.1/libstdc++.so
 #-sv_lib $MATLABROOT/sys/os/glnxa64/libstdc++.so.6
OPT=(
-sv_root /
#-sv_lib $MATLABROOT/bin/glnxa64/glibc-2.17_shim.so
#-sv_lib $MATLABROOT/sys/os/glnxa64/orig/libstdc++.so.6
 -sv_lib $MATLABROOT/sys/os/glnxa64/libstdc++.so.6
#-sv_lib $MATLABROOT/bin/glnxa64/libmwmclbase.so
 -sv_lib $MATLABROOT/runtime/glnxa64/libmwmclmcrrt.so

-sv_root `pwd`
 -sv_lib `pwd`/libplot_iq/libplot_iq.so
 -sv_lib `pwd`/plot_iq.so
)

#echo ${OPT[*]}

## PRELOAD=(
##   $MATLABROOT/bin/glnxa64/glibc-2.17_shim.so
##   $MATLABROOT/bin/glnxa64/libmwmclbase.so
##   #$MATLABROOT/sys/os/glnxa64/orig/libstdc++.so.6
##   #$MATLABROOT/sys/os/glnxa64/libstdc++.so.6
##   $MATLABROOT/runtime/glnxa64/libmwmclmcrrt.so
##   $MATLABROOT/bin/glnxa64/glibc-2.17_shim.so
##   `pwd`/libplot_iq/libplot_iq.so
##   `pwd`/plot_iq.so
## )
## 
## LD_PRELOAD=$(IFS=: ; echo "${PRELOAD[*]}")
## export LD_PRELOAD


#export LD_LIBRARY_PATH=$MATLABROOT/sys/os/glnxa64/orig:$LD_LIBRARY_PATH
#echo ${LD_LIBRARY_PATH[*]}

#unset LD_LIBRARY_PATH
xvlog -sv plot_iq.sv 
xelab  plot_iq ${OPT[*]}  -R

#xelab plot_iq -sv_root ./ -sv_lib libplot_iq/libplot_iq -sv_lib plot_iq -R
