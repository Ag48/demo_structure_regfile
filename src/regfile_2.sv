module regfile_2 (
  input logic clk,
  input logic rst_n,
  input logic [7:0] addr,
  input logic [7:0] din,
  input logic ren,
  input logic wen,
  output logic [7:0] dout
);

import package_ctrlreg::*;

// typedef

localparam s_regfile init_rf = '{4{8'hff}};

// internal signal definitions
s_regfile s_rf;
logic [($size(s_regfile)/8-1):0][7:0] array_ctrlreg;

// assign definitions
assign s_rf = array_ctrlreg;
assign dout = array_ctrlreg[addr[1:0]];

// data flow definitions

always_ff @(posedge clk, negedge rst_n) begin
  if (!rst_n) begin
    array_ctrlreg <= init_rf;
  end else if (wen) begin
    array_ctrlreg[addr[3:0]] <= din;
  end
end

endmodule
