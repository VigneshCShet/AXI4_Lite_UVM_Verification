class trans extends uvm_sequence_item;
  //`uvm_object_utils(trans)
  
  //Inputs
  rand bit [`dw - 1 : 0] opa;
  rand bit [`dw - 1 : 0] opb;
  rand bit [`cw - 1 : 0] cmd;
  rand bit [1:0] inp_valid;
  
  rand bit ce;
  rand bit mode;
  rand bit cin;
  
  bit reset;
  
  //Outputs
  logic [`dw * 2 - 1 : 0] res;
  logic cout;
  logic oflow;
  logic g;
  logic e;
  logic l;
  logic err;
  
  `uvm_object_utils_begin(trans)
    `uvm_field_int(opa, UVM_ALL_ON)
    `uvm_field_int(opb, UVM_ALL_ON)
    `uvm_field_int(cmd, UVM_ALL_ON)
    `uvm_field_int(inp_valid, UVM_ALL_ON)
    `uvm_field_int(ce, UVM_ALL_ON)
    `uvm_field_int(mode, UVM_ALL_ON)
    `uvm_field_int(cin, UVM_ALL_ON)
    `uvm_field_int(reset, UVM_ALL_ON)
    `uvm_field_int(res, UVM_ALL_ON)
    `uvm_field_int(cout, UVM_ALL_ON)
    `uvm_field_int(oflow, UVM_ALL_ON)
    `uvm_field_int(g, UVM_ALL_ON)
    `uvm_field_int(e, UVM_ALL_ON)
    `uvm_field_int(l, UVM_ALL_ON)
    `uvm_field_int(err, UVM_ALL_ON)
  `uvm_object_utils_end
  
  function new(string name = "trans");
    super.new(name);
  endfunction
  /*
  constraint rule1{
    cmd == 4 -> inp_valid == 2'b01;
    cmd == 0 -> inp_valid == 2'b11;
  }
  
  constraint rul2{
    cmd dist {0:= 20, 4:= 80};
  }
  
  constraint rule3{
    ce == 1;
  }
  
  constraint rule4{
    mode == 1;
  }*/
endclass
