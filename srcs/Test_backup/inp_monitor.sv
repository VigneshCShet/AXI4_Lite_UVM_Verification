class axi_input_monitor extends uvm_monitor;
  `uvm_component_utils(axi_input_monitor)
  
  virtual axi_if.mimod vif;
  
  uvm_analysis_port #(trans) ipmon_r;
  uvm_analysis_port #(trans) ipmon_w;
  //uvm_analysis_port #(trans) ip_rst;
  
  trans imon_r, imon_w, imon_rst;
  
  bit v1, v2, v3;
  
  bit [`aw - 1 : 0] awaddr;
  bit [`dw - 1 : 0] wdata;
  bit [`dw/8 - 1 : 0] wstrb;
  bit [2:0] awprot, arprot;
  
  bit [`aw - 1 : 0] araddr;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
    ipmon_r  = new("ipmon_r", this);
    ipmon_w  = new("ipmon_w", this);
    //ip_rst   = new("ip_rst", this);
    
    imon_r   = trans :: type_id :: create("imon_r");
    imon_w   = trans :: type_id :: create("imon_w");
   // imon_rst = trans :: type_id :: create("imon_rst");
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual axi_if) :: get(this, "", "vif", vif)) begin
      `uvm_fatal(get_type_name, "VIF is not set")
    end
  endfunction
  
  task run_phase(uvm_phase phase);
    @(vif.mi_cb);
    
    forever begin
      //send write address and data
      if(vif.mi_cb.awvalid && !v1 && vif.mi_cb.awready) begin
        imon_w.awaddr = vif.mi_cb.awaddr;
        imon_w.awprot = vif.mi_cb.awprot;
        imon_w.rst    = vif.mi_cb.rst;
        v1 = 1;
      end
      if(vif.mi_cb.wvalid && !v2 && vif.mi_cb.wready) begin
        imon_w.wdata  = vif.mi_cb.wdata;
        imon_w.wstrb  = vif.mi_cb.wstrb;
        imon_w.rst    = vif.mi_cb.rst;
        v2 = 1;
      end
      
      //send read address
      if(vif.mi_cb.arvalid && !v3 && vif.mi_cb.arready) begin
        imon_r.araddr = vif.mi_cb.araddr;
        imon_r.arprot = vif.mi_cb.arprot;
        imon_r.rst    = vif.mi_cb.rst;
        v3 = 1;
      end
      
      if(v3) begin
        send_read(imon_r);
        v3 = 0;
      end
      
      if(v1 && v2) begin
        send_write(imon_w);
        v1 = 0;
        v2 = 0;
      end
      @(vif.mi_cb);
    end
  endtask
  
  function void send_write(trans imon);
    trans inmon_w;
    $cast(inmon_w,imon.clone());
    ipmon_w.write(inmon_w);
  endfunction
  
  function void send_read(trans imon);
    trans inmon_r;
    $cast(inmon_r,imon.clone());
    ipmon_r.write(inmon_r);
  endfunction
  
  /*function void send_reset(trans imon);
    trans inmon_rst;
    inmon_rst = imon.clone();
    ip_rst.write(inmon_rst);
  endfunction*/
endclass
