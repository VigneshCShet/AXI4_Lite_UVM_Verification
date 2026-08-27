class axi_environment extends uvm_env;
  `uvm_component_utils(axi_environment)
  
  axi_inp_agent agi;
  axi_out_agent ago;
  axi_scoreboard scr;
  axi_config cfg;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    cfg = axi_config :: type_id :: create("cfg");
    cfg.inp_agent = UVM_ACTIVE;
    cfg.out_agent = UVM_PASSIVE;
    
    uvm_config_db #(axi_config) :: set(this, "*", "axi_config", cfg);
    
    agi = axi_inp_agent  :: type_id :: create("agi", this);
    ago = axi_out_agent  :: type_id :: create("ago", this);
    scr = axi_scoreboard :: type_id :: create("scr", this);
    
  endfunction
  
  function void connect_phase(uvm_phase phase);
    
    super.connect_phase(phase);
    
    agi.ip_mon.ipmon_r.connect(scr.inp_mon_r.analysis_export);
    agi.ip_mon.ipmon_w.connect(scr.inp_mon_w.analysis_export);
    ago.out_mon.out_mon_r.connect(scr.out_mon_r.analysis_export);
    ago.out_mon.out_mon_w.connect(scr.out_mon_w.analysis_export);
    
  endfunction
  
endclass
