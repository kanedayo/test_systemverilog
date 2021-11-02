`timescale 1ns / 1ns
module plot_iq;

  parameter len = 10;

  import "DPI-C" function int plot_iq_init();
  import "DPI-C" function int plot_iq_term();
  import "DPI-C" function int plot_real_imag( real re[0:len-1], real im[0:len-1], int len);

  //int len = 5;
  real re[0:len-1];
  real im[0:len-1];

  initial
  begin

    $display("[INFO]:plot_iq_init()\n");
    void'( plot_iq_init() );

    for(int i=0; i<len; i++) begin

      for(int k=0;k<len;k++) begin
        //re[k] = i;
        //im[k] = i + 10;
        re[k] = $random();
        im[k] = $random();
      end

      $display("plot_real_imag():[%d]\n",i);
      void'( plot_real_imag(re,im,len) );
    end

    $display("[INFO]:plot_iq_term()");
    void'( plot_iq_term() );

    $display("[INFO]:$finish()\n");
    $finish();
  end

endmodule :plot_iq
