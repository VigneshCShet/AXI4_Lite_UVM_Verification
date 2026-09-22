//`include "design.v"
`include "Testbench/interface.sv"
`include "Testbench/assertions.sv"
`include "Testbench/axi_package.sv"

module tb;
  import uvm_pkg::*;
  import axi_pkg ::*;

  bit clk;
  bit rst;

  axi_if intf(clk, rst);
  
  //assertion
  axi_assertion asrt(
  .clk(clk), .rst(rst),
  .awaddr(intf.awaddr), .araddr(intf.araddr), 
  .wdata(intf.wdata), .rdata(intf.rdata), 
  .wstrb(intf.wstrb),
   .arprot(intf.arprot), .awprot(intf.awprot), 
   .bresp(intf.bresp), .rresp(intf.rresp),
  .awvalid(intf.awvalid), .wvalid(intf.wvalid), .bready(intf.bready), .rready(intf.rready), .arvalid(intf.arvalid),
  .awready(intf.awready), .wready(intf.wready), .arready(intf.arready), .bvalid(intf.bvalid), .rvalid(intf.rvalid)
);

  axi4_lite_slave #(
    .DATA_WIDTH(`dw),
    .ADDR_WIDTH(`aw),
    .MEM_DEPTH(`depth)
) dut (
 .ACLK(clk), .ARESETn(rst), .AWADDR(intf.awaddr), .AWPROT(intf.awprot), .AWVALID(intf.awvalid),
 .AWREADY(intf.awready), .WDATA(intf.wdata), .WSTRB(intf.wstrb), .WVALID(intf.wvalid), .WREADY(intf.wready), .BRESP(intf.bresp),
 .BVALID(intf.bvalid), .BREADY(intf.bready), .ARADDR(intf.araddr), .ARPROT(intf.arprot), .ARVALID(intf.arvalid), .ARREADY(intf.arready),
 .RDATA(intf.rdata), .RRESP(intf.rresp), .RVALID(intf.rvalid), .RREADY(intf.rready)
);

  initial clk = 1;

  always #5 clk = ~clk;

  task apply_reset();
    @(posedge clk);
    #2;
    rst = 0;
    `uvm_info("RESET", "Reset Asserted", UVM_MEDIUM)

    repeat(3)@(posedge clk);
    #2;
    rst = 1;
    `uvm_info("RESET", "Reset Deasserted", UVM_MEDIUM)
  endtask

  initial begin
    apply_reset();

    //repeat(20) @(posedge clk);

    apply_reset();

  end

  initial begin
    uvm_config_db#(virtual axi_if) :: set(null, "*", "vif", intf);
    uvm_config_db#(virtual axi_if.drmod) :: set(null, "*", "vif_drmod", intf);
    uvm_config_db#(virtual axi_if.mimod) :: set(null, "*", "vif_mimod", intf);
    uvm_config_db#(virtual axi_if.momod) :: set(null, "*", "vif_momod", intf);
    run_test("base_test");
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule
