`ifndef COMMON_LIB_PKG_SV
  `define COMMON_LIB_PKG_SV
  package common_lib_pkg;
    parameter p_NUM_CHANNEL = 8;
    function automatic logic[3:0] calc (input logic[7:0] a,b);
      if(a[7]) calc = a + b;
      else     calc = 0;
    endfunction
  endpackage
`endif
