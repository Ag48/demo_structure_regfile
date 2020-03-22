module regfile (
  input logic clk,
  input logic rst_n,
  input logic [7:0] addr,
  input logic [7:0] din,
  input logic ren,
  input logic wen,
  output logic [7:0] dout
);

// typedef

typedef struct packed {
  logic [7:0] read_write;
  logic [7:0] read_only;
  logic [7:0] write_clear;
  logic [7:0] read_clear;
} t_regfile;

union packed {
  t_regfile t_rf;
  logic [3:0] [7:0] ar_rf;
} u_regfile;


localparam t_regfile init_rf = '{4{8'hff}};

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
