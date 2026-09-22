`include "defines.svh"

interface alu_if (input bit clk, reset);
  logic [`dw-1:0] opa, opb;
  logic ce,mode,cin;
  logic [`cw-1:0] cmd;
  logic [1:0] inp_valid;
  logic [`dw * 2 -1:0] res;
  logic cout;
  logic oflow;
  logic g;
  logic e;
  logic l;
  logic err;
  
  clocking dr_cb @(posedge clk);
    default input #1 output #0;
    output opa, opb, ce, mode, cin, cmd, inp_valid;
  endclocking
  
  clocking mi_cb @(posedge clk);
    default input #1 output #0;
    input opa, opb, ce, mode, cin, cmd, inp_valid, reset;
  endclocking
  
  clocking mo_cb @(posedge clk);
    default input #1 output #0;
    input res, cout, oflow, g, e, l, err;
  endclocking
  
  modport drvmod(clocking dr_cb);
  modport mimod(clocking mi_cb);
  modport momod(clocking mo_cb);
  
endinterface
