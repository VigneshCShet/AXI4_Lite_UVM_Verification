  `include "defines.svh"
interface axi_if(input bit clk, rst);
//write address channel
  logic [`aw - 1 : 0] awaddr;
  logic [2:0] awprot;
  logic awvalid;
  logic awready; //output

//write data channel
  logic [`dw -1 : 0] wdata;
  logic [`dw/8 - 1 : 0] wstrb;
  logic wvalid;
  logic wready; //output

//write response channel  
  logic [1:0] bresp; //output
  logic bvalid; //output
  logic bready;

//read address channel
  logic [`aw -1 : 0]araddr;
  logic [2:0] arprot;
  logic arvalid;
  logic arready; //output

//read data channel
  logic [`dw - 1 : 0] rdata; //output
  logic [1:0] rresp; //output
  logic rvalid; //output
  logic rready;
  
  clocking dr_cb @(posedge clk);
    default input #1 output #0;
    input awready, wready, arready, bvalid, rvalid;
    output awaddr, awprot, awvalid, wdata, wstrb, wvalid, bready, araddr, arprot, arvalid, rready;
  endclocking
  
  clocking mi_cb @(posedge clk);
    default input #1 output #0;
    input awaddr, awprot, awvalid, wdata, wstrb, wvalid, bready, araddr, arprot, arvalid, rready, rst, arready, awready, wready;
  endclocking
  
  clocking mo_cb @(posedge clk);
    default input #1 output #0;
    input awready, wready, bresp, bvalid, arready, rdata, rresp, rvalid, awvalid, bready, wvalid, arvalid, rready;
  endclocking
  
  modport drmod(clocking dr_cb);
  modport mimod(clocking mi_cb);
  modport momod(clocking mo_cb);
  
endinterface
