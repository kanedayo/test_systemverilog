https://edaplayground.com/x/4D3t

```#bash
INCDIR=/home/Tools/Cadence/INCISIVE15.20.010/tools/include/
g++ -Wall -fPIC -shared -o my_dpi.so my_dpi.cpp -I $INCDIR

irun +nc64bit -sv_lib my_dpi.so -sv testvench.sv
```

```
xvlog -sv testvench.sv 
xelab  test -sv_lib my_dpi.so  -R
```
