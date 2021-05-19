`timescale 1ns / 1ns
typedef struct {
                 bit f1;
                 int f2;
                 } s1;

import "DPI-C" function void SimpleFcn(input s1 in,output s1 out);

module top();
    s1 in,out;
    initial
      begin    
            in.f1=1'b0;  
            in.f2 = 400;
            $display("The input struct in SV has f1: %h and f2:%d",in.f1,in.f2);
            SimpleFcn(in,out);
            $display("The output struct in SV has f1: %h and f2:%d",out.f1,out.f2);
         end

endmodule :top
