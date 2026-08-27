class axi_config extends uvm_object;
  `uvm_object_utils(axi_config)
  
  uvm_active_passive_enum inp_agent;
  uvm_active_passive_enum out_agent;
  
  function new(string name = "axi_config");
    super.new(name);
  endfunction
  
endclass
