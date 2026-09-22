`include "Testbench/defines.svh"

interface axi_assertion(
  input bit clk, rst,
  input bit [`aw - 1 : 0] awaddr, araddr,
  input bit [`dw - 1 : 0] wdata, rdata,
  input bit [`dw/8 - 1 : 0] wstrb,
  input bit [2:0] arprot, awprot,
  input bit [1:0] bresp, rresp,
  input bit awvalid, wvalid, rready, arvalid,
  input bit awready, wready, arready, bvalid, rvalid, bready
);

  property awready_ch;
    @(posedge clk) disable iff(!rst)
    $rose(awvalid) |-> first_match(##[0:$] awready) ##1 !awready; 
  endproperty
  
  property wready_ch;
    @(posedge clk) disable iff(!rst)
    $rose(wvalid) |-> first_match(##[0:$] wready) ##1 !wready;
  endproperty
  
  property bvalid_ch;
    @(posedge clk) disable iff(!rst)
    $rose(awready) ##0 first_match(##[0:$] wready) |=> first_match(##[0:$] bvalid);
  endproperty
  
  property arready_ch;
    @(posedge clk) disable iff(!rst)
    $rose(arvalid) |-> first_match(##[0:$] arready); 
  endproperty
  
  property rvalid_ch;
    @(posedge clk) disable iff(!rst)
    $rose(arready) |-> first_match(##[0:$] $rose(rvalid));
  endproperty
  
  property bvalid_stbl_ch;
    int abresp= 0;
    int abvalid = 0;
    @(posedge clk) disable iff(!rst)
    ($rose(bvalid), abresp = bresp, abvalid= bvalid) |-> ((bresp == abresp) && (bvalid == abvalid)) until_with bready;
  endproperty
  
  property rvalid_stbl_ch;
    int a_rvalid = 0;
    int arresp = 0;
    int ardata = 0;
    @(posedge clk) disable iff(!rst)
    ($rose(rvalid), arresp = rresp, ardata = rdata, a_rvalid = rvalid) |-> (((rresp == arresp) && (rdata == ardata)) && (rvalid == a_rvalid)) until_with $rose(rready);
  endproperty
  
  assert property(awready_ch)
    $info("Assertion awready_ch Passed Successfully");
  else
    $info("Assertion awready_ch Failed");
    
  assert property(wready_ch)
    $info("Assertion wready_ch Passed Successfully");
  else
    $info("Assertion wready_ch Failed");
    
  assert property(bvalid_ch)
    $info("Assertion bvalid_ch Passed Successfully");
  else
    $info("Assertion bvalid_ch Failed");
    
  assert property(arready_ch)
    $info("Assertion arready_ch Passed Successfully");
  else
    $info("Assertion arready_ch Failed");
    
  assert property(rvalid_ch)
    $info("Assertion rvalid_ch Passed Successfully");
  else
    $info("Assertion rvalid_ch Failed");
    
  assert property(bvalid_stbl_ch)
    $info("Assertion bvalid_stbl_ch Passed Successfully");
  else
    $info("Assertion bvalid_stbl_ch Failed");
    
  assert property(rvalid_stbl_ch)
    $info("Assertion rvalid_stbl_ch Passed Successfully");
  else
    $info("Assertion rvalid_stbl_ch Failed");
    
endinterface
