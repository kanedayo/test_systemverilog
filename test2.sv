module sub;
endmodule


  interface myinterface;
    int shared_varible;

    initial begin
      $display("Hi %d", shared_varible++);
    end
//    always begin
//      $display("Hi from always block in interface $d",shared_varible++);
//    end

    interface if1;
      program my_prog;
        initial $display("Hellow Program!! from interface $d",shared_varible++);
      endprogram : my_prog
    endinterface
    if1 IF();
    // sub sub(); // NG
  endinterface


module test2;
  myinterface my();
  initial $display("Hi from %m");
endmodule : test2
