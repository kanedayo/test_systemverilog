interface A_if();
  int i=10;
  wire [7:0] w;
  initial $display("Hellow Interface!!");
endinterface : A_if

module test3;
  reg clk=0;
  always #10 clk=~clk;

  A_if DUT();
  sub s1( clk, DUT );
endmodule : test3

module sub (input clk, interface a);
  assign a.w = a.i;
  //always_ff @ (posedge clk) a.i <= a.i + 1;
  always @(posedge clk) begin
    a.i <= a.i + 1;
  end
  initial begin
    $monitor("a.i=%3d a.w=%3d time:%t", a.i, a.w, $time);
    #100 $finish;
  end
endmodule : sub
