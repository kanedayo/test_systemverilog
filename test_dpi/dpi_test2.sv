`timescale 1ns/1ps
module dpi_test2;
  //import "DPI" context function void DumpInfo( void );
  import "DPI" context function void DumpInfo( );
  initial begin : main_block
    DumpInfo();
    $finish(2);
  end : main_block
endmodule : dpi_test2
