class alu_agent_act extends uvm_agent;
  `uvm_component_utils(alu_agent_act)
  
  alu_input_monitor mon;
  alu_driver drv;
  alu_sequencer seqr;
  alu_config cfg;
  
  function new(string name = "alu_agent_act", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    cfg = alu_config :: type_id :: create("cfg");
    
    if(!uvm_config_db #(alu_config) :: get(this, "", "alu_config", cfg))
      `uvm_fatal(get_type_name(), "act agent not configured")
    
    mon = alu_input_monitor :: type_id :: create("mon", this);
    
    if(cfg.input_agent == UVM_ACTIVE) begin
      seqr = alu_sequencer :: type_id :: create("seqr", this);
      drv  = alu_driver    :: type_id :: create("drv", this);
    end
      
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_type_name(),"Connected", UVM_NONE)
    if(cfg.input_agent == UVM_ACTIVE)
      drv.seq_item_port.connect(seqr.seq_item_export);
  endfunction
  
endclass
