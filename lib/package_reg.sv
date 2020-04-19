package package_reg;
  typedef struct packed {
    logic [7:0] read_write;
    logic [7:0] read_only;
    logic [7:0] write_clear;
    logic [7:0] read_clear;
  } s_regfile;

  union packed {
    s_regfile t_rf;
    logic [3:0] [7:0] ar_rf;
  } u_regfile;

endpackage
