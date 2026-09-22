class alu_agent_pas extends uvm_agent;
  `uvm_component_utils(alu_agent_pas)
  
  //alu_config cfg;
  alu_output_monitor mon;
  
  function new(string name = "alu_agent_pas", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon = alu_output_monitor :: type_id :: create("mon", this);
  endfunction

endclass 
