class base_test extends uvm_test;
  `uvm_component_utils(base_test)
  axi_environment env;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = axi_environment :: type_id :: create("env", this);
  endfunction
  
  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction
  
endclass

class regression_test extends base_test;
  `uvm_component_utils(regression_test)
  sanity_sequence s1;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    s1 = sanity_sequence :: type_id :: create("s1");
    
    phase.raise_objection(this);
    s1.start(env.agi.seqr);
    phase.drop_objection(this);
    
  endtask
  
endclass
