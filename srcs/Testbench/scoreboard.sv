class axi_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(axi_scoreboard)
  
  localparam int max_addr = `depth * 4;
  uvm_tlm_analysis_fifo #(trans) inp_mon_w;
  uvm_tlm_analysis_fifo #(trans) inp_mon_r;
  uvm_tlm_analysis_fifo #(trans) out_mon_w;
  uvm_tlm_analysis_fifo #(trans) out_mon_r;
  
  trans imon_w, imon_r, omon_w, omon_r;
  
  logic [`dw - 1 : 0] mem [bit [`aw - 1 : 0]];
  
  extern function new(string name, uvm_component parent);
  
  extern task run_phase(uvm_phase phase);
  
  extern task reference_model_write();
  
  extern task reference_model_read();
  
  extern function void validate_output_read();
  
  extern function void validate_output_write();
  
endclass

function axi_scoreboard::new(string name, uvm_component parent);
    super.new(name, parent);
    
    inp_mon_w   = new("inp_mon_w", this);
    inp_mon_r   = new("inp_mon_r", this);
    out_mon_w   = new("out_mon_w", this);
    out_mon_r   = new("out_mon_r", this);
endfunction

task axi_scoreboard::run_phase(uvm_phase phase);
    
    fork

      forever begin
        inp_mon_w.get(imon_w);
        `uvm_info(get_name, "Write:- Got from Input monitor", UVM_MEDIUM)
                 
        reference_model_write();
        `uvm_info(get_name, "Write:- Reference model is done", UVM_MEDIUM)
        
        out_mon_w.get(omon_w);
        `uvm_info(get_name, "Write:- Got from Output Monitor", UVM_MEDIUM)
        
        validate_output_write();
      end
     
      
      
      forever begin
        inp_mon_r.get(imon_r);
        `uvm_info(get_name, "Read:- Got from Input monitor", UVM_MEDIUM)  
               
        reference_model_read();
        `uvm_info(get_name, "Read:- Reference model is done", UVM_MEDIUM)  
                
        out_mon_r.get(omon_r);
        `uvm_info(get_name, "Read:- Got from Output Monitor", UVM_MEDIUM)
        
        validate_output_read();
      end
      
    join
    
  endtask

task axi_scoreboard::reference_model_write();
    if(!imon_w.rst) begin
    
      mem.delete();
      imon_w.bresp = 0;
      imon_w.rresp = 0;
      imon_w.rdata = 0;
      
    end
    
    else begin
      //decerr
      if(imon_w.awaddr > max_addr - 1) begin
        imon_w.bresp = 2'b11;
      end
      
      //Slverr
      else if(imon_w.awaddr[1:0] != 0) begin
        imon_w.bresp = 2'b10;
      end
      
     //slverr 
      else if(imon_w.awaddr[$clog2(max_addr) - 1 : 2] >= 10 && imon_w.awaddr[$clog2(max_addr) - 1 : 2] <= 12)begin
        imon_w.bresp = 2'b10;
      end
      
      else begin
      
        if(!mem.exists(imon_w.awaddr)) begin
          mem[imon_w.awaddr] = 0;
        end
        
        foreach(imon_w.wstrb[i]) begin
          if(imon_w.wstrb[i]) begin
            mem[imon_w.awaddr][i * 8 +: 8] = imon_w.wdata[i * 8 +: 8];
          end
        end
        
        imon_w.bresp = 2'b00;          
      end
 
    end
    $display("\n\n----------------------------------------------------------------- REFERENCE WRITE ---------------------------------------------------------------------------------\n");
      `uvm_info(get_name, $sformatf("\n\nBRESP = %b", imon_w.bresp), UVM_MEDIUM)
    $display("\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------\n\n");

  endtask
  
  task axi_scoreboard::reference_model_read();
    if(!imon_r.rst) begin
    
      mem.delete();
      imon_r.rdata = 0;
      imon_r.bresp = 0;
      imon_r.rresp = 2'b00;
    end
    
    else begin
      //decerr
      if(imon_r.araddr > max_addr - 1) begin
        imon_r.rresp = 2'b11;
      end
      
      //Slverr
      else if(imon_r.araddr[1:0] != 0) begin
        imon_r.rresp = 2'b10;
      end
    
     //slverr 
      else if(imon_r.araddr[$clog2(max_addr) - 1 : 2] >= 13 && imon_r.araddr[$clog2(max_addr) - 1 : 2] <= 14)begin
        imon_r.rresp = 2'b10;
      end
      
      else if(!mem.exists(imon_r.araddr)) begin
        imon_r.rdata = 0;
        imon_r.rresp = 2'b00;
      end
      
      else begin     
        imon_r.rdata = mem[imon_r.araddr];
        imon_r.rresp = 2'b00;
      end
             
    end
    $display("\n\n----------------------------------------------------------------- REFERENCE READ ---------------------------------------------------------------------------------\n");
      `uvm_info(get_name, $sformatf("\n\nRDATA = %0h | RRESP = %b", imon_r.rdata, imon_r.rresp), UVM_MEDIUM)
      $display("\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------\n\n");

  endtask
  
  function void axi_scoreboard::validate_output_read();
  
    $display("\n====================================================================== READ CHECK ================================================================================\n");
    $display("\n======================================================================  INPUTS  ==================================================================================\n");
    
    `uvm_info(get_name, $sformatf("\nARESET = %b | ARADDR = %0h | ARPROT = %b\n", imon_r.rst, imon_r.araddr, imon_r.arprot), UVM_NONE)
    
    if(imon_r.rresp === 0) begin  
      if(imon_r.rdata === omon_r.rdata) begin
        `uvm_info("RDATA PASSED", $sformatf("Expected Output = %0h | Actual Output = %0h", imon_r.rdata, omon_r.rdata), UVM_NONE)
      end
      else begin
        `uvm_info("RDATA FAILED", $sformatf("Expected Output = %0h | Actual Output = %0h", imon_r.rdata, omon_r.rdata), UVM_NONE)
      end
      
      if(imon_r.rresp === omon_r.rresp) begin
        `uvm_info("RRESP PASSED", $sformatf("Expected Output = %0b | Actual Output = %0b", imon_r.rresp, omon_r.rresp), UVM_NONE)
      end
      else begin
        `uvm_info("RRESP FAILED", $sformatf("Expected Output = %0b | Actual Output = %0b", imon_r.rresp, omon_r.rresp), UVM_NONE)
      end
    end
    else begin
      if(imon_r.rresp === omon_r.rresp) begin
        `uvm_info("RRESP PASSED", $sformatf("Expected Output = %0b | Actual Output = %0b", imon_r.rresp, omon_r.rresp), UVM_NONE)
      end
      else begin
        `uvm_info("RRESP FAILED", $sformatf("Expected Output = %0b | Actual Output = %0b", imon_r.rresp, omon_r.rresp), UVM_NONE)
      end
    end
    
    $display("\n===================================================================== READ CHECK DONE ============================================================================\n\n");
  endfunction
  
  function void axi_scoreboard::validate_output_write();
    if(imon_w.rst) begin
      $display("\n====================================================================== WRITE CHECK ================================================================================\n");
      
      $display("\n======================================================================== INPUTS ===================================================================================\n");
      `uvm_info(get_name, $sformatf("\nARESET = %b | AWADDR = %0h | AWPROT = %b | WDATA = %0h | WSTRB = %b \n", imon_w.rst, imon_w.awaddr, imon_w.awprot, imon_w.wdata, imon_w.wstrb), UVM_NONE)
      
      if(imon_w.bresp === omon_w.bresp) begin
        `uvm_info("BRESP PASSED", $sformatf("Expected Output = %0b | Actual Output = %0b", imon_w.bresp, omon_w.bresp), UVM_NONE)
      end
      else begin
        `uvm_info("BRESP FAILED", $sformatf("Expected Output = %0b | Actual Output = %0b", imon_w.bresp, omon_w.bresp), UVM_NONE)
      end
      $display("\n===================================================================== WRITE CHECK DONE ==========================================================================\n\n");
    end
    else begin
      $display("\n====================================================================== RESET CHECK ================================================================================\n");
      if(imon_w.bresp === omon_w.bresp) begin
        `uvm_info("BRESP PASSED", $sformatf("Expected Output = %0b | Actual Output = %0b", imon_w.bresp, omon_w.bresp), UVM_NONE)
      end
      else begin
        `uvm_info("BRESP FAILED", $sformatf("Expected Output = %0b | Actual Output = %0b", imon_w.bresp, omon_w.bresp), UVM_NONE)
      end
      
       if(imon_w.rdata === omon_w.rdata) begin
        `uvm_info("RDATA PASSED", $sformatf("Expected Output = %0h | Actual Output = %0h", imon_w.rdata, omon_w.rdata), UVM_NONE)
    end
      else begin
        `uvm_info("RDATA FAILED", $sformatf("Expected Output = %0h | Actual Output = %0h", imon_w.rdata, omon_w.rdata), UVM_NONE)
      end
      
      if(imon_w.rresp === omon_w.rresp) begin
        `uvm_info("RRESP PASSED", $sformatf("Expected Output = %0b | Actual Output = %0b", imon_w.rresp, omon_w.rresp), UVM_NONE)
      end
      else begin
        `uvm_info("RRESP FAILED", $sformatf("Expected Output = %0b | Actual Output = %0b", imon_w.rresp, omon_w.rresp), UVM_NONE)
      end
      $display("\n===================================================================== RESET CHECK DONE ============================================================================\n\n");
    end
  endfunction
