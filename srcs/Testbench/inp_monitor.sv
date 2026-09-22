class axi_write_input_monitor extends uvm_monitor;
  `uvm_component_utils(axi_write_input_monitor)
  
  virtual axi_if.mimod vif;
 
  uvm_analysis_port #(trans) ipmon_w;
  
  uvm_analysis_port #(trans) ipmon_rst;
  
  trans imon_w;
  trans imon_rst;
  
  bit v1, v2;
  
  extern function new(string name, uvm_component parent);
  
  extern function void build_phase(uvm_phase phase);
  
  extern task run_phase(uvm_phase phase);
  
  extern function void send_write(trans imon);
  
endclass

function axi_write_input_monitor::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction

function void axi_write_input_monitor::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
  if(!uvm_config_db #(virtual axi_if.mimod) :: get(this, "", "vif_mimod", vif)) begin
    `uvm_fatal(get_name(), "VIF is not set")
  end
  
  ipmon_w   = new("ipmon_w", this);
  
  imon_w   = trans :: type_id :: create("imon_w");
  imon_rst = trans :: type_id :: create("imon_rst");
  
endfunction

task axi_write_input_monitor::run_phase(uvm_phase phase);
 
  fork
    begin
      @(vif.mi_cb iff vif.mi_cb.rst == 1);
      forever begin
        //send write address and data
        if(vif.mi_cb.awvalid && !v1 && vif.mi_cb.awready) begin
          imon_w.awaddr = vif.mi_cb.awaddr;
          imon_w.awprot = vif.mi_cb.awprot;
          imon_w.rst    = vif.mi_cb.rst;
          `uvm_info(get_name, "Write Address recieved", UVM_MEDIUM)
          v1 = 1;
        end
        if(vif.mi_cb.wvalid && !v2 && vif.mi_cb.wready) begin
          imon_w.wdata  = vif.mi_cb.wdata;
          imon_w.wstrb  = vif.mi_cb.wstrb;
          imon_w.rst    = vif.mi_cb.rst;
          `uvm_info(get_name, "Write Data recieved", UVM_MEDIUM)
          v2 = 1;
        end
        
        if(v1 && v2) begin
          $display("\n\n----------------------------------------------------------------- INPUT MONITOR WRITE ---------------------------------------------------------------------------------\n");
          `uvm_info(get_name, $sformatf("\n\nARESET = %b | AWADDR = %0h | AWPROT = %b | WDATA = %0h | WSTRB = %b", imon_w.rst, imon_w.awaddr, imon_w.awprot, imon_w.wdata, imon_w.wstrb), UVM_LOW)
          $display("\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------\n\n");

          send_write(imon_w);
          @(vif.mi_cb iff vif.mi_cb.bready == 1);
          v1 = 0;
          v2 = 0;
        end
        @(vif.mi_cb iff vif.mi_cb.rst == 1);
      end
    end
    
    forever begin
      @(negedge vif.rst);
      imon_rst.rst = vif.rst;
      send_write(imon_rst);
    end
    
  join
endtask

function void axi_write_input_monitor::send_write(trans imon);
  trans inmon_w;
  $cast(inmon_w,imon.clone());
  ipmon_w.write(inmon_w);
endfunction




class axi_read_input_monitor extends uvm_monitor;
  `uvm_component_utils(axi_read_input_monitor)
  
  virtual axi_if.mimod vif;
  
  uvm_analysis_port #(trans) ipmon_r;
  
  trans imon_r;
  
  bit v3;
  
  extern function new(string name, uvm_component parent);
  
  extern function void build_phase(uvm_phase phase);
  
  extern task run_phase(uvm_phase phase);
  
  extern function void send_read(trans imon);

endclass



function axi_read_input_monitor::new(string name, uvm_component parent);
  super.new(name, parent);    
endfunction

function void axi_read_input_monitor::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db #(virtual axi_if.mimod) :: get(this, "", "vif_mimod", vif)) begin
    `uvm_fatal(get_name, "VIF is not set")
  end
  ipmon_r  = new("ipmon_r", this);
  imon_r   = trans :: type_id :: create("imon_r");
endfunction

task axi_read_input_monitor::run_phase(uvm_phase phase);
  @(vif.mi_cb iff vif.mi_cb.rst == 1);
  
  forever begin
  
    //send read address
    if(vif.mi_cb.arvalid && !v3 && vif.mi_cb.arready) begin
      imon_r.araddr = vif.mi_cb.araddr;
      imon_r.arprot = vif.mi_cb.arprot;
      imon_r.rst    = vif.mi_cb.rst;
      `uvm_info(get_name, $sformatf("Read Address recieved ARADDR = %0h", vif.mi_cb.araddr), UVM_MEDIUM)
      v3 = 1;
    end
    
    if(v3) begin
      $display("\n\n----------------------------------------------------------------- INPUT MONITOR READ ---------------------------------------------------------------------------------\n");
      `uvm_info(get_name, $sformatf("\n\nARESET = %b | ARADDR = %0h | ARPROT = %b", imon_r.rst, imon_r.araddr, imon_r.arprot), UVM_LOW)
      $display("\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------\n\n");
      send_read(imon_r);
      @(vif.mi_cb iff vif.mi_cb.rready == 1);
      v3 = 0;
    end
    
    @(vif.mi_cb iff vif.mi_cb.rst == 1);
  end
  
endtask

function void axi_read_input_monitor::send_read(trans imon);
  trans inmon_r;
  $cast(inmon_r,imon.clone());
  ipmon_r.write(inmon_r);
endfunction


