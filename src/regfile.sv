module regfile (
  input logic clk,
  input logic rst_n,
  input logic [7:0] addr,
  input logic [7:0] din,
  input logic ren,
  input logic wen,
  output logic [7:0] dout
);

import package_reg::*;

// typedef

localparam s_regfile init_rf = '{4{8'hff}};

// internal signal definitions


// assign definitions

assign dout = u_regfile.ar_rf[addr[1:0]];

// data flow definitions

always_ff @(posedge clk, negedge rst_n) begin
  if (!rst_n) begin
    u_regfile.ar_rf <= init_rf;
  end else if (wen) begin
    u_regfile.ar_rf[addr[1:0]] <= din;
  end
end

endmodule
