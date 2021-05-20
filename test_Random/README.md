- cf. https://edaplayground.com/x/5jim
- cf. https://edaplayground.com/x/2Xh

```
testbench.v  : Vivado
testbench2.v : Vivado
testbench3.v : Vivado & Incisive
```

```
xvlog -sv Bus_pkg.sv testbench.sv
xelab use_Bus_trans -sv_root ./ -R
```

```
xvlog -sv testbench2.sv 
xelab test -R
```


```
irun testbench3.sv -disable_sem2009
```
