interface ramif;
  logic [23:0] addr;
  logic        wen;
  logic [31:0] wdata;
  logic        ren;
  logic [31:0] rdata;

  modport mst (
    output addr,
    output wen,
    output wdata,
    output ren,
    input  rdata
  );
  modport slv (
    input  addr,
    input  wen,
    input  wdata,
    input  ren,
    output rdata
  );
endinterface : ramif

module test_cbcd;
  logic clk=1;
  logic rst=0;
  always  # 5 clk <= ~clk;
  initial #15 rst = 1;
 
  ramif svramif();
  ramif tbramif();

  cbcd  cbcd ( .*,
    .svram(svramif.mst),
    .tbram(tbramif.mst) );

  dummy_ram #("svram") svram ( .*, .ram(svramif.slv) );
  dummy_ram #("tbram") tbram ( .*, .ram(tbramif.slv) );

endmodule : test_cbcd

module dummy_ram #( parameter name = "dummy_ram" )
  (
    input clk,
    input rst,
    ramif.slv ram
  );
  always_ff @(posedge clk or negedge rst) begin
    if ( ram.wen ) $display("%s:[W]addr = 0x%06x",name,ram.addr);
    if ( ram.ren ) $display("%s:[R]addr = 0x%06x",name,ram.addr);
  end
endmodule : dummy_ram

module cbcd #( parameter K = 256 )
  (
    input clk,
    input rst,
    //ramif.mst svram, // OK
    //ramif.mst tbram // OK
    interface.mst svram,
    interface.mst tbram
  );

  logic [23:0]  svram_addr;
  logic         svram_wen;
  logic [31:0]  svram_wdata;
  logic         svram_ren;
  logic [31:0]  svram_rdata;

  logic [23:0]  tbram_addr;
  logic         tbram_wen;
  logic [31:0]  tbram_wdata;
  logic         tbram_ren;
  logic [31:0]  tbram_rdata;

  initial begin
    svram_addr = 'h123456;
    tbram_addr = 'h654321;
    @(posedge rst);
    @(posedge clk) svram_wen = 1;
    @(posedge clk) svram_wen = 0;
    @(posedge clk) tbram_ren = 1;
    @(posedge clk) tbram_ren = 0;
    #100;
    $finish;
  end

  always_comb begin
    svram.addr = svram_addr;
    svram.wen  = svram_wen;
    svram.wdata= svram_wdata;
    svram.ren  = svram_ren;
    svram_rdata= svram.rdata;

    tbram.addr = tbram_addr;
    tbram.wen  = tbram_wen;
    tbram.wdata= tbram_wdata;
    tbram.ren  = tbram_ren;
    tbram_rdata= tbram.rdata;
  end
endmodule
