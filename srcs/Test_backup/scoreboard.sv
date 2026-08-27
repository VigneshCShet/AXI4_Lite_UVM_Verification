class axi_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(axi_scoreboard)
  
  uvm_tlm_analysis_fifo #(trans) inp_mon_w;
  uvm_tlm_analysis_fifo #(trans) inp_mon_r;
 // uvm_tlm_analysis_fifo #(trans) inp_mon_rst;
  uvm_tlm_analysis_fifo #(trans) out_mon_w;
  uvm_tlm_analysis_fifo #(trans) out_mon_r;
  
  trans imon_w, imon_r, imon_rst, omon_w, omon_r;
  
  reg [7:0] mem [0 : (`depth - 1)];
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
    inp_mon_w = new("inp_mon_w", this);
    inp_mon_r = new("inp_mon_r", this);
    out_mon_w = new("out_mon_w", this);
    out_mon_r = new("out_mon_r", this);
    endfunction
  
  task run_phase(uvm_phase phase);
    fork
      /*begin
        forever begin
          inp_mon_rst.get(imon_rst);
         
          reference_model();
          
          out_mon.get(omon);
          
          validate_outputs();
        end
      end*/
      
      begin
        forever begin
          inp_mon_w.get(imon_w);
                   
          reference_model_write();
          
          out_mon_w.get(omon_w);
          
          validate_output_read();
        end
      end
      
      begin
        forever begin
          inp_mon_r.get(imon_r);
         
          reference_model_read();
          
          out_mon_r.get(omon_r);
          
          validate_output_write();
        end
      end
      
    join
    
  endtask
  
  task reference_model_write();
    if(!imon_w.rst) begin
    
      foreach(mem[i]) begin
        mem[i] = 0;
      end
      imon_w.bresp   = 0;
    end
    
    else begin

      if(imon_w.awaddr > 63) begin
        imon_w.bresp  = 2'b11;
      end
      
      //Slverr
      else if(imon_w.awaddr[1:0] != 0) begin
        imon_w.bresp  = 2'b10;
      end
      
     //slverr 
      else if(imon_w.awaddr[5:2] < 13 && imon_w.awaddr[5:2] > 9)begin
        imon_w.bresp  = 2'b10;
      end
      
      else begin
      
        foreach(imon_w.wstrb[i]) begin
          mem[imon_w.awaddr + i] = imon_w.wdata[i * 8 +: 8];
        end
        
        imon_w.bresp  = 2'b00;          
      end
 
    end
    
  endtask
  
  task reference_model_read();
    if(!imon_r.rst) begin
    
      foreach(mem[i]) begin
        mem[i] = 0;
      end
      
      imon_r.rresp   = 0;
    end
    
    else begin
    
      if(imon_r.araddr > 63) begin
        imon_r.rresp  = 2'b11;
      end
      
      //Slverr
      else if(imon_r.araddr[1:0] != 0) begin
        imon_r.rresp  = 2'b10;
      end
      
     //slverr 
      else if(imon_r.araddr[5:2] < 13 && imon_r.araddr[5:2] > 12)begin
        imon_r.rresp  = 2'b10;
      end
      
      else begin
        for(int i = 0; i < (`dw/8); i++) begin
          imon_r.rdata[i * 8 +: 8] = mem[imon_r.araddr + i];
        end
        imon_r.rresp  = 2'b00;
      end
             
    end
  endtask
  
  function void validate_output_read();
  
    $display("\n====================================================================== READ CHECK ================================================================================\n");
    if(imon_r.rdata == omon_r.rdata) begin
      `uvm_info("RDATA PASSED", $sformatf("Expected Output = %0h | Actual Output = %0h", imon_r.rdata, omon_r.rdata), UVM_NONE)
    end
    else begin
      `uvm_info("RDATA FAILED", $sformatf("Expected Output = %0h | Actual Output = %0h", imon_r.rdata, omon_r.rdata), UVM_LOW)
    end
    
    if(imon_r.rresp == omon_r.rresp) begin
      `uvm_info("RRESP PASSED", $sformatf("Expected Output = %0h | Actual Output = %0h", imon_r.rresp, omon_r.rresp), UVM_NONE)
    end
    else begin
      `uvm_info("RRESP FAILED", $sformatf("Expected Output = %0h | Actual Output = %0h", imon_r.rresp, omon_r.rresp), UVM_LOW)
    end
    
    $display("\n===================================================================== READ CHECK DONE ============================================================================\n\n");
  endfunction
  
  function void validate_output_write();
  
    $display("\n====================================================================== WRITE CHECK ================================================================================\n");
    
    
    if(imon_w.bresp == omon_w.bresp) begin
      `uvm_info("BRESP PASSED", $sformatf("Expected Output = %0h | Actual Output = %0h", imon_w.bresp, omon_w.bresp), UVM_NONE)
    end
    else begin
      `uvm_info("BRESP FAILED", $sformatf("Expected Output = %0h | Actual Output = %0h", imon_w.bresp, omon_w.bresp), UVM_LOW)
    end
    $display("\n===================================================================== WRITE CHECK DONE ==========================================================================\n\n");
  endfunction
endclass
