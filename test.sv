interface my_interface #(
  parameter int value=10
)(input var int  i);
initial begin
  $display("Hellow Interface!!");
  $display("value = %d",value);
  $display("i = %d",i);
end
endinterface

module test;
  my_interface #(10) my_if   ();
  //my_interface #(99) v1[9:0] ();
  genvar i;
    generate for(i=0; i<9; i=i+1) begin
      my_interface #(99) v1 (i[7:0]);
    end
  endgenerate
endmodule
