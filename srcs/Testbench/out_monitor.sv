class axi_out_monitor extends uvm_monitor;
  `uvm_component_utils(axi_out_monitor)
  virtual axi_if.momod vif;
  
  uvm_analysis_port #(trans) out_mon_r;
  uvm_analysis_port #(trans) out_mon_w;
  trans omon_r, omon_w;
  
  extern function new(string name, uvm_component parent);
  
  extern function void build_phase(uvm_phase phase);
  
  extern task run_phase(uvm_phase phase);
  
  extern function void send_read(trans omon);
  
  extern function void send_write(trans omon);
  
endclass

function axi_out_monitor::new(string name, uvm_component parent);
  super.new(name, parent);
  
  out_mon_r = new("out_mon_r", this);
  out_mon_w = new("out_mon_w", this);
  
  omon_r    = trans :: type_id :: create("omon_r");
  omon_w    = trans :: type_id :: create("omon_w");
  
endfunction

function void axi_out_monitor::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db #(virtual axi_if.momod) :: get(this, "", "vif_momod", vif)) begin
    `uvm_fatal(get_name(), "VIF not set")
  end
endfunction

task axi_out_monitor::run_phase(uvm_phase phase);
  fork
    begin
      @(vif.mo_cb);
      forever begin
        if(vif.mo_cb.rvalid && vif.mo_cb.rready) begin
          omon_r.rdata = vif.mo_cb.rdata;
          omon_r.rresp = vif.mo_cb.rresp;
          send_read(omon_r);
        end
        
        if(vif.mo_cb.bvalid && vif.mo_cb.bready) begin
          omon_w.bresp = vif.mo_cb.bresp;
          send_write(omon_w);
        end
        
        @(vif.mo_cb);
      end
    end
    
    forever begin
      @(negedge vif.rst);
      omon_w.bresp = vif.bresp;
      omon_w.rresp = vif.rresp;
      omon_w.rdata = vif.rdata;
      send_write(omon_w);
    end
    
  join
endtask
 
function void axi_out_monitor::send_read(trans omon);
  trans omon_c;
  $cast(omon_c, omon.clone());
  $display("\n\n----------------------------------------------------------------- OUTPUT MONITOR READ ---------------------------------------------------------------------------------\n");
    `uvm_info(get_name, $sformatf("\n\nRDATA = %0h | RRESP = %b", omon_c.rdata, omon_c.rresp), UVM_LOW)
  $display("\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------\n\n");
  out_mon_r.write(omon_c);
endfunction

function void axi_out_monitor::send_write(trans omon);
  trans omon_c;
  $cast(omon_c, omon.clone());
  $display("\n\n----------------------------------------------------------------- OUTPUT MONITOR WRITE ---------------------------------------------------------------------------------\n");
    `uvm_info(get_name, $sformatf("\n\nBRESP = %b", omon_c.bresp), UVM_LOW)
  $display("\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------\n\n");
  out_mon_w.write(omon_c);
endfunction
