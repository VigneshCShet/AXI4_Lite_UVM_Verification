class alu_output_monitor extends uvm_monitor;
  `uvm_component_utils(alu_output_monitor)
  
  trans omon;
  virtual alu_if.momod vif;
  uvm_analysis_port #(trans) output_mon_port;
  
  function new(string name = "alu_output_monitor", uvm_component parent = null);
  
    super.new(name, parent);
    output_mon_port = new("output_mon_port", this);
    
  endfunction
  
  function void build_phase(uvm_phase phase);
  
    super.build_phase(phase);
    if(!uvm_config_db #(virtual alu_if) :: get(this, "", "vif", vif))
      `uvm_fatal(get_type_name(), "Virtual Interface in Monitor is not set")
      
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    forever begin
      omon = trans :: type_id :: create("omon");
      
      get_outputs_from_vif();
      $display("\n ------------------------------------------- OUTPUT MONITOR ------------------------------------------- \n");
      `uvm_info(get_type_name, $sformatf("Recieving output signals \n RES = %0h | COUT = %b | OFLOW = %b | G = %b | E = %b | L = %b | ERR = %b", omon.res, omon.cout, omon.oflow, omon.g, omon.e, omon.l, omon.err), UVM_NONE)
      $display("\n ------------------------------------------------------------------------------------------------------- \n");
      output_mon_port.write(omon);
      
    end
  endtask
  
  task get_outputs_from_vif();
  
    omon.res   = vif.mo_cb.res;
    omon.cout  = vif.mo_cb.cout;
    omon.oflow = vif.mo_cb.oflow;
    omon.g     = vif.mo_cb.g;
    omon.e     = vif.mo_cb.e;
    omon.l     = vif.mo_cb.l;
    omon.err   = vif.mo_cb.err;
    @(vif.mo_cb);

  endtask

endclass
