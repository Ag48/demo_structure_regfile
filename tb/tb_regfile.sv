module tb_regfile;

  timeunit 1ns;
  timeprecision 1ns;
  logic clk, rst_n;
  logic [7:0] addr;
  logic [7:0] din, dout;
  logic ren, wen;

  localparam time L_CLK_PERIOD = 10;

  regfile DUT (.*);

  initial begin
    clk = 1'b0;
    forever #(L_CLK_PERIOD/2) clk = ~clk;
  end

  initial begin
    rst_n = 1'b1;
    addr = 'h0;
    din = 'h0;
    ren = 'b0;
    wen = 'b0;
    // set reset
    #(L_CLK_PERIOD * 2);
    rst_n = 'b0;
    // release reset
    #(L_CLK_PERIOD * 2);
    rst_n = 'b1;
  end

  initial begin
    @(posedge(rst_n));
    ren = 'b1;
    // read intial value
    for (int i = 0; i < 4; i++) begin
      @(posedge(clk));
      addr = i;
      $display("[%10t] dout[%d]: %h", $time, addr, dout);
    end
    // write value
    repeat (10) @(posedge(clk));
    ren = 'b0;
    wen = 'b1;
    for (int i = 0; i < 4; i++) begin
      addr = i;
      din = i * 2;
      @(posedge(clk));
    end
    // read written value
    ren = 'b1;
    wen = 'b0;
    repeat (10) @(posedge(clk));
    for (int i = 0; i < 4; i++) begin
      addr = i;
      @(posedge(clk));
      $display("[%10t] [%d] dout[%d]: %h", $time, i, addr, dout);
    end
    $finish;
  end

  // initial begin 
  //   $display("clk, rst_n, addr, din, ren, wen, dout");
  //   forever @(posedge(clk)) begin
  //     $display("[%10t] %b %b %h %h %b %b %h", $time, clk, rst_n, addr, din, ren, wen, dout);
  //   end
  // end
endmodule

