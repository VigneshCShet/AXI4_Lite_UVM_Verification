class alu_env extends uvm_env;
  `uvm_component_utils(alu_env)
  
  alu_agent_act agi;
  alu_agent_pas ago;
  alu_config cfg;
  alu_scoreboard scr;
  coverage_col cov;
  
  function new(string name = "env", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    cfg = alu_config :: type_id :: create("cfg");
    
    cfg.input_agent  = UVM_ACTIVE;
    cfg.output_agent = UVM_PASSIVE;
    
    `uvm_info(get_type_name, "Setting alu_config into config db", UVM_NONE)
    uvm_config_db #(alu_config) :: set(this, "*" , "alu_config", cfg);
    
    agi = alu_agent_act  :: type_id :: create("agi", this);
    ago = alu_agent_pas  :: type_id :: create("ago", this);
    scr = alu_scoreboard :: type_id :: create("scr", this);
    cov = coverage_col   :: type_id :: create("cov", this);
    
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agi.mon.inp_mon_port.connect(scr.inp_mon_rec.analysis_export);
    agi.mon.inp_mon_port.connect(cov.analysis_export);
    ago.mon.output_mon_port.connect(scr.out_mon_rec.analysis_export);
  endfunction
  
endclass
