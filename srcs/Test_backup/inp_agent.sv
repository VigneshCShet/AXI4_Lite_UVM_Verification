class axi_inp_agent extends uvm_agent;
  `uvm_component_utils(axi_inp_agent)
  
  axi_sequencer seqr;
  axi_driver drv;
  axi_input_monitor ip_mon;
  axi_config cfg;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(axi_config) :: get(this, "", "axi_config", cfg))
      `uvm_fatal(get_type_name, "Config not set")
      
    if(cfg.inp_agent == UVM_ACTIVE) begin
      seqr = axi_sequencer :: type_id :: create("seqr", this);
      drv  = axi_driver    :: type_id :: create("drv", this);
    end
    
    ip_mon = axi_input_monitor :: type_id :: create("ip_mon", this);
    
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drv.seq_item_port.connect(seqr.seq_item_export);
  endfunction
  
endclass
