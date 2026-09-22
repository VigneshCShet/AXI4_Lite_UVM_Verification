class axi_environment extends uvm_env;
  `uvm_component_utils(axi_environment)
  
  axi_write_agent w_agi;
  axi_read_agent r_agi;
  axi_out_agent ago;
  
  virtual_seqr vseqr;
  
  axi_scoreboard scr;
  axi_coverage_collector cov;
  axi_config cfg;
  
  extern function new(string name, uvm_component parent);
  
  extern function void build_phase(uvm_phase phase);
  
  extern function void connect_phase(uvm_phase phase);
  
endclass

function axi_environment::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction

function void axi_environment :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  
  cfg = axi_config :: type_id :: create("cfg");
  
  cfg.write_agent = UVM_ACTIVE;
  cfg.read_agent = UVM_ACTIVE;
  cfg.out_agent = UVM_PASSIVE;
  
  uvm_config_db #(axi_config) :: set(this, "*", "axi_config", cfg);
  
  w_agi = axi_write_agent  :: type_id :: create("w_agi", this);    
  r_agi = axi_read_agent  :: type_id :: create("r_agi", this);  
  ago = axi_out_agent  :: type_id :: create("ago", this);
  
  scr = axi_scoreboard :: type_id :: create("scr", this);
  cov = axi_coverage_collector :: type_id :: create("cov", this);
  
  vseqr = virtual_seqr :: type_id :: create("vseqr", this);
  
endfunction

function void axi_environment :: connect_phase(uvm_phase phase);
  
  super.connect_phase(phase);
  
  r_agi.r_ip_mon.ipmon_r.connect(scr.inp_mon_r.analysis_export);
  r_agi.r_ip_mon.ipmon_r.connect(cov.imp_r);
  w_agi.w_ip_mon.ipmon_w.connect(scr.inp_mon_w.analysis_export);
  w_agi.w_ip_mon.ipmon_w.connect(cov.analysis_export);
  
  ago.out_mon.out_mon_r.connect(scr.out_mon_r.analysis_export);
  ago.out_mon.out_mon_w.connect(scr.out_mon_w.analysis_export);
  vseqr.w_sqr = w_agi.w_seqr;
  vseqr.r_sqr = r_agi.r_seqr;
  
endfunction
