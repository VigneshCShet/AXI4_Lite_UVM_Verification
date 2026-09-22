class alu_input_monitor extends uvm_monitor;
  `uvm_component_utils(alu_input_monitor)
  
  trans imon;
  uvm_analysis_port #(trans) inp_mon_port;
  virtual alu_if.mimod vif;
  
  function new(string name = "alu_inp_monitor", uvm_component parent = null);
    super.new(name, parent);
    inp_mon_port = new("inp_mon_port", this);
  endfunction
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    
    if(!uvm_config_db #(virtual alu_if) :: get(this, "", "vif", vif)) begin
      `uvm_fatal(get_type_name(), "Virtual Interface is not set in Input Monitor")
      
    end
    `uvm_info(get_type_name(),"Building", UVM_NONE)  
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      imon = trans::type_id::create("imon", this);
      get_from_vif();
      $display("\n ------------------------------------------- INPUT MONITOR ------------------------------------------- \n");
      `uvm_info(get_type_name, $sformatf("Recieving input signals \n CE = %b |OPA = %0h | OPB = %0h | CIN = %b | CMD = %0h | MODE = %0h | INP_VALID = %b | RESET = %b", imon.ce, imon.opa, imon.opb, imon.cin, imon.cmd, imon.mode, imon.inp_valid, imon.reset), UVM_NONE)
      $display("---------------------------------------------------------------------------------------------------------");
      inp_mon_port.write(imon);
    end
  endtask
  
  task get_from_vif();
  
    imon.opa       = vif.mi_cb.opa;
    imon.opb       = vif.mi_cb.opb;
    imon.ce        = vif.mi_cb.ce;
    imon.cmd       = vif.mi_cb.cmd;
    imon.mode      = vif.mi_cb.mode;
    imon.inp_valid = vif.mi_cb.inp_valid;
    imon.cin       = vif.mi_cb.cin;
    imon.reset     = vif.mi_cb.reset;
    @(vif.mi_cb);
  endtask
  
endclass
