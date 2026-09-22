class axi_write_driver extends uvm_driver #(trans);
  `uvm_component_utils(axi_write_driver)
  virtual axi_if.drmod vif;
  
  bit v1, v2;
  bit [2:0] vs, vw;
  bit [2:0] count;
  
  extern function new(string name, uvm_component parent);
  
  extern function void build_phase(uvm_phase phase);
  
  extern task run_phase(uvm_phase phase);
  
  extern task drive();
  
  extern task drive_without_waiting_for_ready();
  
  extern task drive_bready_after_4_clk_cycle();
  
  extern task drive_ready_always_high();
  
endclass

function axi_write_driver :: new(string name, uvm_component parent);
  super.new(name, parent);
endfunction

function void axi_write_driver :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db #(virtual axi_if.drmod) :: get(this, "", "vif_drmod", vif)) begin
    `uvm_fatal(get_name, "VIF Not set")
  end
endfunction

task axi_write_driver :: run_phase(uvm_phase phase);
  forever begin
    seq_item_port.get_next_item(req);
    
    if(req.awvalid || req.wvalid) begin
      $display("\n\n----------------------------------------------------------------------------- WRITE DRIVER -----------------------------------------------------------------------------\n");
      `uvm_info(get_name, $sformatf("\n\nawaddr = %0h | awprot = %b | awvalid = %b | wdata = %0h | wstrb = %b | wvalid = %b", req.awaddr, req.awprot, req.awvalid, req.wdata, req.wstrb, req.wvalid), UVM_NONE)
      $display("\n--------------------------------------------------------------------------------------------------------------------------------------------------------------------\n\n");
    end
    
    if(req.dr == 0)
      drive(); 
      
    if(req.dr == 1)
      drive_without_waiting_for_ready();
      
    if(req.dr == 2)
      drive_bready_after_4_clk_cycle();
      
    if(req.dr == 3)
      drive_ready_always_high();
      
    seq_item_port.item_done();
  end
endtask

task axi_write_driver :: drive();
  fork
  //Write address channel
    begin
      vif.dr_cb.awaddr  <= req.awaddr;
      vif.dr_cb.awprot  <= req.awprot;
      vif.dr_cb.awvalid <= req.awvalid;
      
      if(req.awvalid) begin
        v1 = 1;
        @(vif.dr_cb iff vif.dr_cb.awready == 1);
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
        @(vif.dr_cb iff vif.dr_cb.wready == 1);
        
        @(vif.dr_cb);
        vif.dr_cb.wvalid <= 0;
      end
    end
  join

  //Write Response
  if(v1 && v2) begin
    @(vif.dr_cb iff vif.dr_cb.bvalid == 1);
    vif.dr_cb.bready <= 1;
    @(vif.dr_cb);
    vif.dr_cb.bready <= 0;
    v1 = 0;
    v2 = 0;
  end
  
  if(!req.awvalid && !req.wvalid) begin
    @(vif.dr_cb);
  end
  
endtask

task axi_write_driver :: drive_without_waiting_for_ready();
  fork
  //Write address channel
    begin
      vif.dr_cb.awaddr  <= req.awaddr;
      vif.dr_cb.awprot  <= req.awprot;
      vif.dr_cb.awvalid <= req.awvalid;
      
      if(req.awvalid) begin
        v1 = 1;
        //@(vif.dr_cb iff vif.dr_cb.awready == 1);
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
       // @(vif.dr_cb iff vif.dr_cb.wready == 1);         
        @(vif.dr_cb);
        vif.dr_cb.wvalid <= 0;
      end
    end
  join
  
  if(v1 && v2) begin
    count++;
    v1 = 0;
    v2 = 0;
  end
  
  
  //Write Response
  if(count >= 4) begin
  //  @(vif.dr_cb iff vif.dr_cb.bvalid == 1);
    vif.dr_cb.bready <= 1;
    @(vif.dr_cb);
    vif.dr_cb.bready <= 0;
    v1 = 0;
    v2 = 0;
    count = 0;
  end
  if(!req.awvalid && !req.wvalid) begin
    @(vif.dr_cb);
  end
  
endtask

task axi_write_driver :: drive_bready_after_4_clk_cycle();
  fork
  //Write address channel
    begin
      vif.dr_cb.awaddr  <= req.awaddr;
      vif.dr_cb.awprot  <= req.awprot;
      vif.dr_cb.awvalid <= req.awvalid;
      
      if(req.awvalid) begin
        v1 = 1;
        @(vif.dr_cb iff vif.dr_cb.awready == 1);
        //@(vif.dr_cb);
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
        @(vif.dr_cb iff vif.dr_cb.wready == 1);
        
       // @(vif.dr_cb);
        vif.dr_cb.wvalid <= 0;
      end
    end
  join
  
  //Write Response
  if(v1 && v2) begin
    @(vif.dr_cb iff vif.dr_cb.bvalid == 1);
    repeat(4) @(vif.dr_cb);
    vif.dr_cb.bready <= 1;
    @(vif.dr_cb);
    vif.dr_cb.bready <= 0;
    v1 = 0;
    v2 = 0;
  end
  
  if(!req.awvalid && !req.wvalid) begin
    @(vif.dr_cb);
  end
  
endtask

task axi_write_driver :: drive_ready_always_high();
  fork
  //Write address channel
    begin
      vif.dr_cb.awaddr  <= req.awaddr;
      vif.dr_cb.awprot  <= req.awprot;
      vif.dr_cb.awvalid <= req.awvalid;
      
      if(req.awvalid) begin
        v1 = 1;
        @(vif.dr_cb iff vif.dr_cb.awready == 1);
        repeat(6) @(vif.dr_cb);
      end
    end
    
  //Write data Channel
    begin
      vif.dr_cb.wdata  <= req.wdata;
      vif.dr_cb.wstrb  <= req.wstrb;
      vif.dr_cb.wvalid <= req.wvalid;
      
      if(req.wvalid) begin
        v2 = 1;
        @(vif.dr_cb iff vif.dr_cb.wready == 1);
        
        repeat(6) @(vif.dr_cb);
      end
    end
  join

  //Write Response
  if(v1 && v2) begin
    @(vif.dr_cb iff vif.dr_cb.bvalid == 1);
    vif.dr_cb.bready <= 1;
    @(vif.dr_cb);
    v1 = 0;
    v2 = 0;
  end
  
  if(!req.awvalid && !req.wvalid) begin
    @(vif.dr_cb);
  end
  
endtask

class axi_read_driver extends uvm_driver #(trans);
  `uvm_component_utils(axi_read_driver)
  virtual axi_if.drmod vif;
  bit v3;
  bit vs;
  bit [2:0] count;
  
  extern function new(string name, uvm_component parent);
  
  extern function void build_phase(uvm_phase phase);
  
  extern task run_phase(uvm_phase phase);
  
  extern task drive();
  
  extern task drive_without_waiting_for_ready();
  
  extern task drive_rready_after_4_clk_cycle();
  
  extern task drive_ready_always_high();
  
endclass

function axi_read_driver :: new(string name, uvm_component parent);
  super.new(name, parent);
endfunction

function void axi_read_driver :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db #(virtual axi_if.drmod) :: get(this, "", "vif_drmod", vif)) begin
    `uvm_fatal(get_name, "VIF Not set")
  end
endfunction

task axi_read_driver :: run_phase(uvm_phase phase);
  forever begin
    seq_item_port.get_next_item(req);
    
    if(req.arvalid) begin
      $display("\n\n----------------------------------------------------------------------------- READ DRIVER -----------------------------------------------------------------------------\n");
      `uvm_info(get_name, $sformatf("\n\naraddr = %0h | arprot = %b | arvalid = %b", req.araddr, req.arprot, req.arvalid), UVM_NONE)
      $display("\n--------------------------------------------------------------------------------------------------------------------------------------------------------------------\n\n");
    end
    
    if(req.dr == 0)
      drive(); 
      
    if(req.dr == 1)
      drive_without_waiting_for_ready();
      
    if(req.dr == 2)
      drive_rready_after_4_clk_cycle();
     
    if(req.dr == 3)
      drive_ready_always_high();  
    
    seq_item_port.item_done();
  end
endtask

task axi_read_driver :: drive();
  //Read Address channel      
  vif.dr_cb.araddr  <= req.araddr;
  vif.dr_cb.arprot  <= req.arprot;
  vif.dr_cb.arvalid <= req.arvalid;
  
  if(req.arvalid) begin
    v3 = 1;
    @(vif.dr_cb iff vif.dr_cb.arready == 1);
    @(vif.dr_cb);
    vif.dr_cb.arvalid <= 0;
  end
  
  //Read Response 
  if(v3) begin
    @(vif.dr_cb iff vif.dr_cb.rvalid == 1);
    vif.dr_cb.rready <= 1;
    @(vif.dr_cb);
    vif.dr_cb.rready <= 0;
    v3 = 0;
  end
  
  if(!req.arvalid) begin
    @(vif.dr_cb);
  end
      
endtask

task axi_read_driver :: drive_without_waiting_for_ready();
  //Read Address channel      
  vif.dr_cb.araddr  <= req.araddr;
  vif.dr_cb.arprot  <= req.arprot;
  vif.dr_cb.arvalid <= req.arvalid;
  
  if(req.arvalid) begin
    vs = 1;
   // @(vif.dr_cb iff vif.dr_cb.arready == 1);
    @(vif.dr_cb);
  end
  
  if(vs) begin
    count++;
    vs = 0;
  end
  //Read Response 
  if(count >= 3) begin
    @(vif.dr_cb iff vif.dr_cb.rvalid == 1);
    vif.dr_cb.rready <= 1;
    @(vif.dr_cb);
    vif.dr_cb.rready <= 0;
    v3 = 0;
  end
  
  if(!req.arvalid) begin
    @(vif.dr_cb);
  end
      
endtask

task axi_read_driver :: drive_ready_always_high();
   //Read Address channel      
  vif.dr_cb.araddr  <= req.araddr;
  vif.dr_cb.arprot  <= req.arprot;
  vif.dr_cb.arvalid <= req.arvalid;
  vif.dr_cb.rready  <= 1;
  
  if(req.arvalid) begin
    v3 = 1;
    @(vif.dr_cb iff vif.dr_cb.arready == 1);
    repeat(6)@(vif.dr_cb);
    //vif.dr_cb.arvalid <= 0;
  end
  
  //Read Response 
  if(v3) begin
    @(vif.dr_cb iff vif.dr_cb.rvalid == 1);
    v3 = 0;
  end
  
  if(!req.arvalid) begin
    @(vif.dr_cb);
  end
      
endtask

task axi_read_driver :: drive_rready_after_4_clk_cycle();
  //Read Address channel      
  vif.dr_cb.araddr  <= req.araddr;
  vif.dr_cb.arprot  <= req.arprot;
  vif.dr_cb.arvalid <= req.arvalid;
  
  if(req.arvalid) begin
    v3 = 1;
    @(vif.dr_cb iff vif.dr_cb.arready == 1);
    //@(vif.dr_cb);
    vif.dr_cb.arvalid <= 0;
  end
  
  //Read Response 
  if(v3) begin
    @(vif.dr_cb iff vif.dr_cb.rvalid == 1);
    repeat(4) @(vif.dr_cb);
    
    vif.dr_cb.rready <= 1;
    @(vif.dr_cb);
    vif.dr_cb.rready <= 0;
    
    v3 = 0;
  end
  
  if(!req.arvalid) begin
    @(vif.dr_cb);
  end
      
endtask

