class trans extends uvm_sequence_item;
  
  
  //write address channel
  rand bit [`aw - 1 : 0] awaddr;
  rand bit [2:0] awprot;
  rand bit awvalid;
  bit rst;
  logic awready; //output

//write data channel
  rand bit [`dw -1 : 0] wdata;
  rand bit [`dw/8 - 1 : 0] wstrb;
  rand bit wvalid;
  logic wready; //output

//write response channel  
  logic [1:0] bresp; //output
  logic bvalid; //output
  bit bready;

//read address channel
  rand bit [`aw -1 : 0]araddr;
  rand bit [2:0] arprot;
  rand bit arvalid;
  logic arready; //output

//read data channel
  logic [`dw - 1 : 0] rdata; //output
  logic [1:0] rresp; //output
  logic rvalid; //output
  bit rready;
  
  `uvm_object_utils_begin(trans)
    `uvm_field_int(awaddr, UVM_ALL_ON)
    `uvm_field_int(awprot, UVM_ALL_ON)
    `uvm_field_int(awvalid, UVM_ALL_ON)
    `uvm_field_int(wdata, UVM_ALL_ON)
    `uvm_field_int(awready, UVM_ALL_ON)
    `uvm_field_int(wdata, UVM_ALL_ON)
    `uvm_field_int(wstrb, UVM_ALL_ON)
    `uvm_field_int(wvalid, UVM_ALL_ON)
    `uvm_field_int(wready, UVM_ALL_ON)
    `uvm_field_int(bresp, UVM_ALL_ON)
    `uvm_field_int(bvalid, UVM_ALL_ON)
    `uvm_field_int(bready, UVM_ALL_ON)
    `uvm_field_int(araddr, UVM_ALL_ON)
    `uvm_field_int(arprot, UVM_ALL_ON)
    `uvm_field_int(arvalid, UVM_ALL_ON)
    `uvm_field_int(arready, UVM_ALL_ON)
    `uvm_field_int(arprot, UVM_ALL_ON)
    `uvm_field_int(arvalid, UVM_ALL_ON)
    `uvm_field_int(arready, UVM_ALL_ON)
    `uvm_field_int(rdata, UVM_ALL_ON)
    `uvm_field_int(rresp, UVM_ALL_ON)
    `uvm_field_int(rvalid, UVM_ALL_ON)
    `uvm_field_int(rready, UVM_ALL_ON)
    `uvm_field_int(rst, UVM_ALL_ON)
  `uvm_object_utils_end
  
  function new(string name = "trans");
    super.new(name);
  endfunction
  
  constraint rule1{
    soft araddr[1:0] == 0;
  }

  constraint rule2{
    soft awaddr[1:0] == 0;
  }
  
  constraint rule3{
    soft wstrb == 4'b1111;
  }
  
  constraint rule4{
    soft wvalid  == 0;
    soft awvalid == 0;
  }
 
  constraint rule5{
    soft arvalid == 0;
  }
  
  constraint rule6{
    soft araddr inside {[0:63]};
  }
  
endclass
