#Passing C structs through SystemVerilog DPI-C layer

https://stackoverflow.com/questions/50351848/passing-c-structs-through-systemverilog-dpi-c-layer

```
#gcc -c -fPIC -Wall -ansi -pedantic -Wno-long-long -fwrapv -O0 dpi_top.c -o dpi_top.o
#gcc -shared -lm dpi_top.o -o dpi_top.so
gcc -Wall -fPIC -shared -o dpi_top.so dpi_top.c
```

```
irun -sv_lib dpi_top.so -sv top.sv +nc64bit
```


```
xvlog -sv top.sv
xelab top -sv_root ./ -sv_lib dpi_top.so -R
```
