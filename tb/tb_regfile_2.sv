`timescale 1ns/1ns
module tb_regfile_2;

  import package_ctrlreg::*;

  logic clk, rst_n;
  logic [7:0] addr;
  logic [7:0] din, dout;
  logic ren, wen;

  s_regfile s_rf_exp;
  logic [($size(s_regfile)/8-1):0][7:0] ar_rf_exp;
  assign ar_rf_exp = s_rf_exp;

  localparam time L_CLK_PERIOD = 10;

  regfile_2 DUT (.*);

  initial begin
    clk = 1'b0;
    forever #(L_CLK_PERIOD/2) clk = ~clk;
  end

  initial begin
    s_rf_exp = 'h0;
    t_init();
    ren = 'b1;
    // read intial value
    for (int i = 0; i < 4; i++) begin
      @(posedge(clk));
      addr = i;
      $display("[%10t] dout[%d]: %h", $time, addr, dout);
    end
    // write value
    repeat (10) @(posedge(clk));
    t_display_array(); 
    s_rf_exp.s_reg0.reg0 = 'b1;
    s_rf_exp.s_reg1.reg1 = 'b1;
    s_rf_exp.s_reg2.reg2 = 'b1;
    s_rf_exp.s_reg3.reg3 = 'b1;
    @(posedge(clk));
    ren = 'b0;
    wen = 'b1;
    t_display_array(); 
    for (int i = 0; i < 4; i++) begin
      addr = i;
      din = ar_rf_exp[i];
      @(posedge(clk));
    end
    t_display_array(); 
    // read written value
    ren = 'b1;
    wen = 'b0;
    repeat (10) @(posedge(clk));
    for (int i = 0; i < 4; i++) begin
      addr = i;
      @(posedge(clk));
      $display("[%10t] [%d] exp %h | dout %h", $time, i, ar_rf_exp[i],  dout);
    end
    $finish;
  end

  task t_init (); 
    rst_n <= 1'b1;
    addr <= 'h0;
    din <= 'h0;
    ren <= 'b0;
    wen <= 'b0;
    // set reset
    #(L_CLK_PERIOD * 2);
    rst_n <= 'b0;
    // release reset
    #(L_CLK_PERIOD * 2);
    rst_n <= 'b1;
  endtask

  task t_display_array();
    for (int i = 0; i < $size(ar_rf_exp); i++) begin
      $display("[%t] ar_rf_exp[%d]: %h", $time, i, ar_rf_exp[i]);
    end
  endtask

endmodule


