package package_ctrlreg;
  typedef struct packed {
    logic reg7;
    logic reg6;
    logic reg5;
    logic reg4;
    logic reg3;
    logic reg2;
    logic reg1;
    logic reg0;
  } s_reg;

  typedef struct packed {
    s_reg s_reg3;
    s_reg s_reg2;
    s_reg s_reg1;
    s_reg s_reg0;
  } s_regfile;

endpackage

