`timescale 1ns/1ps
module  dpi_test1;
  import "DPI" pure function int CFunc_x2(input int value);

    initial begin : main_block
      int c_value  = 0;
      int sv_value = 0;
      sv_value = 1;
      c_value = CFunc_x2(sv_value);
      $display("<<MGS>> : sv_value(%0d)*2 = c_value(%0d)\n", sv_value, c_value);

      $finish(2);
    end : main_block
endmodule : dpi_test1

