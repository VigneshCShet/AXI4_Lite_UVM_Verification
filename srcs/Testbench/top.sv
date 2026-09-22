`include "uvm_macros.svh"
`include "alu_package.sv"
`include "design.sv"

import uvm_pkg::*;
import alu_package::*;

module tb;

  bit clk, reset;
  
  alu_if intf(clk, reset);
  
  alu_assertion asst (
    .clk(clk), 
    .opb(intf.opb),
    .res(intf.res),
    .cmd(intf.cmd),
    .inp_valid(intf.inp_valid),
    .g(intf.g), 
    .l(intf.l), 
    .e(intf.e), 
    .err(intf.err), 
    .oflow(intf.oflow), 
    .cout(intf.cout), 
    .ce(intf.ce), 
    .mode(intf.mode), 
    .reset(intf.reset)
  );
  
  ALU_DESIGN #(.DW(`dw), .CW(`cw)) dut (.INP_VALID(intf.inp_valid),
     .OPA(intf.opa),
     .OPB(intf.opb),
     .CIN(intf.cin), 
     .CLK(clk), 
     .RST(reset),
     .CMD(intf.cmd), 
     .CE(intf.ce), 
     .MODE(intf.mode), 
     .COUT(intf.cout), 
     .OFLOW(intf.oflow), 
     .RES(intf.res), 
     .G(intf.g), 
     .E(intf.e), 
     .L(intf.l), 
     .ERR(intf.err)
   );
  
  always #5 clk = ~clk;
  
  initial clk = 0;
  
  initial begin
    @(posedge clk);
    reset = 1;
    `uvm_info("RESET","Reset Asserted", UVM_NONE)
    repeat(3) @(posedge clk);
    reset = 0;
    `uvm_info("RESET","Reset Deasserted", UVM_NONE)
    
    repeat(10)@(posedge clk);
    reset = 1;
    `uvm_info("RESET","Reset Asserted", UVM_NONE)
    repeat(3) @(posedge clk);
    reset = 0;
    `uvm_info("RESET","Reset Deasserted", UVM_NONE)
  end
  
  initial begin
    uvm_config_db #(virtual alu_if) :: set(null, "*", "vif", intf);
    
    run_test("base_test");
  end
  
endmodule
