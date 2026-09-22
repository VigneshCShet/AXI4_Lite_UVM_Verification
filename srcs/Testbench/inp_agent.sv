class axi_write_agent extends uvm_agent;
  `uvm_component_utils(axi_write_agent)
  
  axi_write_sequencer w_seqr;
  axi_write_driver w_drv;
  axi_write_input_monitor w_ip_mon;
  axi_config cfg;
  
  extern function  new(string name, uvm_component parent);
  
  extern function void build_phase(uvm_phase phase);
  
  extern function void connect_phase(uvm_phase phase);
  
endclass

function axi_write_agent :: new(string name, uvm_component parent);
  super.new(name, parent);
endfunction

function void axi_write_agent :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  
  if(!uvm_config_db #(axi_config) :: get(this, "", "axi_config", cfg))
    `uvm_fatal(get_name, "Config not set")
    
  if(cfg.write_agent == UVM_ACTIVE) begin
    w_seqr = axi_write_sequencer :: type_id :: create("w_seqr", this);
    w_drv  = axi_write_driver    :: type_id :: create("w_drv", this);
  end
  
  w_ip_mon = axi_write_input_monitor :: type_id :: create("w_ip_mon", this);
  
endfunction

function void axi_write_agent :: connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  w_drv.seq_item_port.connect(w_seqr.seq_item_export);
endfunction




class axi_read_agent extends uvm_agent;
  `uvm_component_utils(axi_read_agent)
  
  axi_read_sequencer r_seqr;
  axi_read_driver r_drv;
  axi_read_input_monitor r_ip_mon;
  axi_config cfg;

  extern function new(string name, uvm_component parent); 
  
  extern function void build_phase(uvm_phase phase);
  
  extern function void connect_phase(uvm_phase phase);
  
endclass



function axi_read_agent :: new(string name, uvm_component parent);
  super.new(name, parent);
endfunction

function void axi_read_agent :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  
  if(!uvm_config_db #(axi_config) :: get(this, "", "axi_config", cfg))
    `uvm_fatal(get_name, "Config not set")
    
  if(cfg.read_agent == UVM_ACTIVE) begin
    r_seqr = axi_read_sequencer :: type_id :: create("r_seqr", this);
    r_drv  = axi_read_driver    :: type_id :: create("r_drv", this);
  end
  
  r_ip_mon = axi_read_input_monitor :: type_id :: create("r_ip_mon", this);
  
endfunction

function void axi_read_agent :: connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  r_drv.seq_item_port.connect(r_seqr.seq_item_export);
endfunction

