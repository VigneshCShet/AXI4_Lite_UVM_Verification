class axi_driver extends uvm_driver #(trans);
  `uvm_component_utils(axi_driver)
  virtual axi_if.drmod vif;
  bit v1, v2, v3;
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual axi_if) :: get(this, "", "vif", vif)) begin
      `uvm_fatal(get_type_name, "VIF Not set")
    end
  endfunction
  
  task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      `uvm_info(get_type_name, $sformatf("\n %s", req.sprint()), UVM_NONE)
      drive(req);
      seq_item_port.item_done();
    end
  endtask
  
  task drive(trans tx);
    fork
    //Write address channel
      begin
        vif.dr_cb.awaddr  <= req.awaddr;
        vif.dr_cb.awprot  <= req.awprot;
        vif.dr_cb.awvalid <= req.awvalid;
        
        if(req.awvalid) begin
          v1 = 1;
          wait(vif.dr_cb.awready);
          @(vif.dr_cb);
          vif.dr_cb.awvalid <= 0;
        end
      end
      
    //Write data Channel
      begin
        vif.dr_cb.wdata  <= req.wdata;
        vif.dr_cb.wstrb  <= req.wstrb;
        vif.dr_cb.wvalid <= req.wvalid;
        
        if(req.wvalid) begin
          v2 = 1;
          wait(vif.dr_cb.wready);
          @(vif.dr_cb);
          vif.dr_cb.wvalid <= 0;
        end
      end
      
    //Read Address channel
      begin
      
        vif.dr_cb.araddr  <= req.araddr;
        vif.dr_cb.arprot  <= req.arprot;
        vif.dr_cb.arvalid <= req.arvalid;
        
        if(req.arvalid) begin
          v3 = 1;
          wait(vif.dr_cb.arready);
          @(vif.dr_cb);
          vif.dr_cb.wvalid <= 0;
        end
      end      
    join
    
    fork
    
    //Write Response
      begin
        if(v1 && v2) begin
          vif.dr_cb.bready <= 0;
          wait(vif.dr_cb.bvalid);
          @(vif.dr_cb);
          vif.dr_cb.bready <= 1;
          v1 = 0;
          v2 = 0;
        end
      end
     
    //Read Response 
      begin
        if(v3) begin
          vif.dr_cb.bready <= 0;
          wait(vif.dr_cb.rvalid);
          @(vif.dr_cb);
          vif.dr_cb.rready <= 1;
          v3 = 0;
        end
      end
    join
    
  endtask
endclass
