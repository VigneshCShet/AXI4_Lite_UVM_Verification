class alu_config extends uvm_object;
  `uvm_object_utils(alu_config)
  
  uvm_active_passive_enum input_agent;
  uvm_active_passive_enum output_agent;
   
  function new(string name = "alu_config");
    super.new(name);
  endfunction
  
endclass
