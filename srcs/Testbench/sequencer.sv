class axi_write_sequencer extends uvm_sequencer#(trans);
  `uvm_component_utils(axi_write_sequencer)
  
  extern function new(string name, uvm_component parent);
  
endclass

function axi_write_sequencer :: new(string name, uvm_component parent);
  super.new(name, parent);
endfunction

class axi_read_sequencer extends uvm_sequencer #(trans);
  `uvm_component_utils(axi_read_sequencer)
  
  extern function new(string name, uvm_component parent);
  
endclass

function axi_read_sequencer :: new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

class virtual_seqr extends uvm_sequencer #(trans);
  `uvm_component_utils(virtual_seqr)
  
  axi_write_sequencer w_sqr;
  axi_read_sequencer r_sqr;
  
  extern function new(string name, uvm_component parent);
  
endclass

function virtual_seqr :: new(string name, uvm_component parent);
  super.new(name, parent);
endfunction
