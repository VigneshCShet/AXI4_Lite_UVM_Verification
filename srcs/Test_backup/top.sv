`include "interface.sv"
`include "axi_package.sv"
module tb;
  import uvm_pkg::*;
  import axi_pkg ::*;
  
  bit clk;
  bit rst;
  
  axi_if intf(clk, rst);
  
  initial clk = 0;
  
  always #5 clk = ~clk;
  
  initial begin
    @(posedge clk);
    rst = 0;
    repeat(2)@(posedge clk);
    rst = 1;
  end
  
  initial begin
    uvm_config_db#(virtual axi_if) :: set(null, "*", "vif", intf);
    run_test("base_test");
  end
endmodule
