class alu_driver extends uvm_driver #(trans);
  `uvm_component_utils(alu_driver)
  
  virtual alu_if.drvmod vif;
  
  function new(string name = "alu_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual alu_if) :: get(this, "", "vif", vif)) begin
      `uvm_fatal(get_type_name(), "Driver is not configured")
    end
    
    `uvm_info(get_type_name(),"Building", UVM_NONE)
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    forever begin
      //`uvm_info(get_type_name(),"Running", UVM_NONE)
      seq_item_port.get_next_item(req);
      $display("\n ------------------------------------------- Driving Signal ------------------------------------------- \n");
      `uvm_info(get_type_name, $sformatf("Driving input signals \n CE = %b |OPA = %0h | OPB = %0h | CIN = %b | CMD = %0h | MODE = %0h | INP_VALID = %b", req.ce, req.opa, req.opb, req.cin, req.cmd, req.mode, req.inp_valid), UVM_NONE)
      $display("---------------------------------------------------------------------------------------------------------");
      drive_to_vif(req);
      seq_item_port.item_done();
    end
    
  endtask
  
  task drive_to_vif(trans tx);
    
    vif.dr_cb.opa       <= tx.opa;
    vif.dr_cb.opb       <= tx.opb;
    vif.dr_cb.ce        <= tx.ce;
    vif.dr_cb.cmd       <= tx.cmd;
    vif.dr_cb.mode      <= tx.mode;
    vif.dr_cb.inp_valid <= tx.inp_valid;
    vif.dr_cb.cin       <= tx.cin;
    @(vif.dr_cb);
    
  endtask
  
endclass
