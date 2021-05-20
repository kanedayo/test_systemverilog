module test;

  typedef enum {ADD, SUB, DIV, MOV} inst_e;

  int      m_int;
  bit[3:0] m_array[];
  inst_e   inst;

  // Print out the items.
  function void print();
    $display("m_int:%0d", m_int);
    $display("m_array.size:%0d", m_array.size());
    foreach(m_array[i])
      $display("m_array[%0d]:%0d", i, m_array[i]);
    $display("inst:%s", inst.name());
  endfunction
  function void myrand();
    m_int = $random;
    m_array = new[4];
    foreach(m_array[i])
      m_array[i] = $random;
    inst = inst.next();
  endfunction
  
  function void run;
    for (int i = 0; i < 5; i++) begin
      myrand();
      print();
    end
  endfunction
  
  initial run();
  
endmodule
