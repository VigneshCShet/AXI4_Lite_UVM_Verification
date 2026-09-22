class alu_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(alu_scoreboard)
  
  trans imon;
  trans omon;
  uvm_tlm_analysis_fifo #(trans) inp_mon_rec;
  uvm_tlm_analysis_fifo #(trans) out_mon_rec;
  
  int op_cnt = 0;
  int ip_val_cnt = 0;
  
  
  bit [`dw - 1 : 0] OPA;
  bit [`dw - 1 : 0] OPB;
  bit [`cw - 1 : 0] CMD;
  bit [1:0] INP_VALID;
  
  bit CE;
  bit MODE;
  bit CIN;
  
  bit reset;
  
  //Outputs
  bit [`dw * 2 - 1 : 0] RES;
  bit COUT;
  bit OFLOW;
  bit G;
  bit E;
  bit L;
  bit ERR;
  
  logic [`dw * 2 - 1 : 0] res;
  logic cout;
  logic oflow;
  logic g;
  logic e;
  logic l;
  logic err;
  
  logic [`dw * 2 - 1 : 0] c_res;
  logic c_cout;
  logic c_oflow;
  logic c_g;
  logic c_e;
  logic c_l;
  logic c_err;
  
  logic [`dw * 2 - 1 : 0] r_res;
  logic r_cout;
  logic r_oflow;
  logic r_g;
  logic r_e;
  logic r_l;
  logic r_err;
  
  bit a_op  = 0;
  bit b_op  = 0;
  bit bt_op = 0;
  
  bit [`dw - 1 : 0] OPA_temp;
  bit [`dw - 1 : 0] OPB_temp;
  
  function new(string name = "alu_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    inp_mon_rec = new("inp_mon_rec", this);
    out_mon_rec = new("out_mon_rec", this);
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    forever begin
      
      inp_mon_rec.get(imon);
      out_mon_rec.get(omon);
      reference_model();
      validate_outputs();
    end
    
  endtask
  
  task reference_model();
    c_res   = r_res;
    c_cout  = r_cout;
    c_oflow = r_oflow;
    c_g     = r_g;
    c_l     = r_l;
    c_e     = r_e;
    c_err   = err;
    
    r_res   = res;
    r_cout  = cout;
    r_oflow = oflow;
    r_g     = g;
    r_l     = l;
    r_e     = e;
    
    if(imon.reset) begin
      res   = 0;
      cout  = 0;
      oflow = 0;
      g     = 0;
      e     = 0;
      l     = 0;
      err   = 0;
      
      op_cnt     = 0;
      a_op       = 0;
      b_op       = 0;
      ip_val_cnt = 0;
      
      OPA        = 0;
      OPB        = 0;
      CMD        = 0;
      INP_VALID  = 0;
      
      CE   = 0;
      MODE = 0;
      CIN  = 0;

      RES    = 0;
      COUT   = 0;
      OFLOW  = 0;
      G      = 0;
      E      = 0;
      L      = 0;
      ERR    = 0;
    end
    
    else begin
      if(imon.ce) begin
      
        if(CMD != imon.cmd || MODE != imon.mode) begin
          `uvm_info("CMD AND MODE CHANGE INPUTS RESET", "ip_val_cnt is 0 and a_op and b_op is 0 and op_cnt is 0", UVM_MEDIUM)
          ip_val_cnt = 0;
          a_op = 0;
          b_op = 0;
          op_cnt = 0;
        end
        
        CMD  = imon.cmd;
        MODE = imon.mode;
        err  = ERR;
        
        if(imon.mode == 1 && (imon.cmd == 9 || imon.cmd == 10))
          op_cnt++;
          
        if(imon.inp_valid == 2'b11)
          ip_val_cnt = 0;
        
        if(imon.mode && imon.cmd < 4 || imon.cmd > 7) begin
          if(a_op != b_op) begin
            ip_val_cnt++;
            $display("INP_VAL_CNT = %0d", ip_val_cnt);
          end
          else
            ip_val_cnt = 0;
        end
        if(!imon.mode && imon.cmd < 6 || imon.cmd > 11) begin
          if(a_op != b_op) begin
            ip_val_cnt++;
            $display("INP_VAL_CNT = %0d", ip_val_cnt);
          end
          else
            ip_val_cnt = 0;
        end

        if(ip_val_cnt <= 16) begin
          if(MODE) begin
            //`uvm_info("Arithmetic", " Operation is triggered", UVM_NONE)
             // res   = 0;
              cout  = 0;
              oflow = 0;
              g     = 0;
              l     = 0;
              e     = 0;
              ERR   = 0;
              
            case(imon.cmd)
            //ADD
              0: begin
              //  `uvm_info("Addition","This operation have been triggered", UVM_NONE)
                if(imon.inp_valid == 0 && a_op == 0 && b_op == 0) begin
                  OPA = 0;
                  OPB = 0;
                  ERR = 1;
                end
                else begin
                
                  if(a_op && b_op) begin
                    a_op  = 0;
                    b_op  = 0;
                    ERR   = 0;
                  end
                  
                  if(imon.inp_valid[0]) begin
                    OPA  = imon.opa;
                    a_op = 1;
                   // `uvm_info("INP_VALID", "OPA Registration is done", UVM_NONE)
                  end
                  
                  if(imon.inp_valid[1]) begin               
                    OPB  = imon.opb;
                    b_op = 1;
                   // `uvm_info("INP_VALID", "OPB Registration is done", UVM_NONE)
                  end
                  
                  if(a_op && b_op) begin
                    res   = OPA + OPB;
                    cout  = res[`dw];
                    `uvm_info("ADD", $sformatf("Addition done res = %0h | OPA = %0h | OPB = %0h", res, OPA, OPB), UVM_MEDIUM)
                  end                
                end
              end
            //SUB
              1: begin
                if(imon.inp_valid == 0 && a_op == 0 && b_op == 0) begin
                  OPA = 0;
                  OPB = 0;
                  ERR = 1;
                end
                else begin
                
                  if(a_op && b_op) begin
                    a_op  = 0;
                    b_op  = 0;
                    ERR   = 0;
                  end
                  
                  if(imon.inp_valid[0]) begin
                    OPA  = imon.opa;
                    a_op = 1;
                  end
                  
                  if(imon.inp_valid[1]) begin               
                    OPB  = imon.opb;
                    b_op = 1;
                  end
                  
                  if(a_op && b_op) begin
                    res   = OPA - OPB ;
                    oflow = res[`dw];
                  end                
                end
              end
              
            //ADD_CIN
              2: begin
                if(imon.inp_valid == 0 && a_op == 0 && b_op == 0) begin
                  OPA = 0;
                  OPB = 0;
                  ERR = 1;
                end
                else begin
                
                  if(a_op && b_op) begin
                    a_op = 0;
                    b_op = 0;
                    ERR  = 0;
                  end
                  
                  if(imon.inp_valid[0]) begin
                    OPA  = imon.opa;
                    a_op = 1;
                  end
                  
                  if(imon.inp_valid[1]) begin               
                    OPB  = imon.opb;
                    b_op = 1;
                  end
                  
                  CIN = imon.cin;
                  
                  if(a_op && b_op) begin
                    res  = OPA + OPB + CIN;
                    cout = res[`dw];
                  end
                end
              end
              
            //SUB_CIN  
              3: begin
                if(imon.inp_valid == 0 && a_op == 0 && b_op == 0) begin
                  OPA = 0;
                  OPB = 0;
                  ERR = 1;
                end
                else begin
                
                  if(a_op && b_op) begin
                    a_op  = 0;
                    b_op  = 0;
                    ERR   = 0;
                  end
                  
                  if(imon.inp_valid[0]) begin
                    OPA  = imon.opa;
                    a_op = 1;
                  end
                  
                  if(imon.inp_valid[1]) begin               
                    OPB  = imon.opb;
                    b_op = 1;
                  end
                  
                  CIN = imon.cin;
                  
                  if(a_op && b_op) begin
                    res   = OPA - OPB - CIN;
                    oflow = res[`dw];
                  end              
                end
              end
              
            //INC_A
              4: begin
                if(a_op) begin
                  a_op = 0;
                end
                if(imon.inp_valid[0]) begin
                  OPA  = imon.opa;
                  ERR  = 0;
                  a_op = 1;
                end
                else
                  ERR = 1;
                  
                if(a_op) begin
                  res  = OPA + 1;
                end
              end
              
            //DEC_A
              5: begin
                if(a_op) begin
                  a_op = 0;
                end
                if(imon.inp_valid[0]) begin
                  $display("OPA Registered!! for dec");
                  OPA  = imon.opa;
                  ERR  = 0;
                  a_op = 1;
                end
                else
                  ERR = 1;
                  
                if(a_op) begin
                  $display("decrementing");
                  res  = OPA - 1;
                end
              end
              
            //INC_B
              6: begin
                if(b_op) begin
                  b_op = 0;
                end
                if(imon.inp_valid[1]) begin
                  OPB  = imon.opb;
                  ERR  = 0;
                  b_op = 1;
                end
                else
                  ERR = 1;
                  
                if(b_op) begin
                  res  = OPB + 1;
                end
              end
              
            //DEC_B
              7: begin
                if(b_op) begin
                  b_op = 0;
                end
                if(imon.inp_valid[1]) begin
                  OPB  = imon.opb;
                  ERR  = 0;
                  b_op = 1;
                end
                else
                  ERR = 1;
                  
                if(b_op) begin
                  res  = OPB - 1;
                end
              end
              
            //CMP
              8: begin
                if(imon.inp_valid == 0 && a_op == 0 && b_op == 0) begin
                  OPA = 0;
                  OPB = 0;
                  ERR = 1;
                end
                else begin
                
                  if(a_op && b_op) begin
                    a_op = 0;
                    b_op = 0;
                    ERR  = 0;
                  end
                  
                  if(imon.inp_valid[0]) begin
                    OPA  = imon.opa;
                    a_op = 1;
                  end
                  
                  if(imon.inp_valid[1]) begin               
                    OPB  = imon.opb;
                    b_op = 1;
                  end
                  
                  if(a_op && b_op) begin                 
                    g = OPA > OPB;
                    l = OPA < OPB;
                    e = OPA == OPB;
                  end 
                              
                end
              end
              
            //MUL_INC
              9: begin
                if(imon.inp_valid == 0 && a_op == 0 && b_op == 0) begin
                  OPA = 0;
                  OPB = 0;
                  ERR = 1;
                end
                else begin
                  if(a_op && b_op && op_cnt == 2) begin
                    OPA_temp = OPA + 1;
                    OPB_temp = OPB + 1;
                    res = OPA_temp * OPB_temp;
                  end
                
                  if(a_op && b_op && op_cnt == 3) begin
                    a_op   = 0;
                    b_op   = 0;
                    op_cnt = 1;
                    ERR    = 0;
                  end
                  
                  if(imon.inp_valid[0]) begin
                    if(op_cnt == 1) begin
                      OPA  = imon.opa;
                      a_op = 1;
                       `uvm_info("REG","OPA Registered", UVM_NONE)
                    end
                  end
                  
                  if(imon.inp_valid[1]) begin               
                    if(op_cnt == 1) begin
                      OPB  = imon.opb;
                      b_op = 1;
                       `uvm_info("REG","OPB Registered", UVM_NONE)
                    end
                  end
                                
                end
              end
              
            //MUL_SHIL
              10: begin
                if(imon.inp_valid == 0 && a_op == 0 && b_op == 0) begin
                  OPA = 0;
                  OPB = 0;
                  ERR = 1;
                end
                else begin
                  if(a_op && b_op && op_cnt == 2) begin
                    OPA_temp = OPA << 1;
                    OPB_temp = OPB;
                    res = OPA_temp * OPB_temp;
                    ERR      = 0;
                    `uvm_info("Operating", $sformatf("SHift Operation on going OPA_Temp = %0h | OPB_Temp = %0h", OPA_temp, OPB_temp), UVM_MEDIUM)
                  end
                
                  if(a_op && b_op && op_cnt == 3) begin
                    a_op   = 0;
                    b_op   = 0;
                    op_cnt = 1;
                    ERR    = 0;
                    `uvm_info("Operating", $sformatf("Multiplying Operation on going RES = %0h | OPA_temp = %0h | OPB_temp = %0h",res, OPA_temp, OPB_temp), UVM_MEDIUM)
                  end
                  
                  if(imon.inp_valid[0]) begin
                    if(op_cnt == 1) begin
                      `uvm_info("REG","OPA Registered", UVM_NONE)
                      OPA  = imon.opa;
                      a_op = 1;
                    end
                  end
                  
                  if(imon.inp_valid[1]) begin               
                    if(op_cnt == 1) begin
                      `uvm_info("REG","OPB Registered", UVM_NONE)
                      OPB  = imon.opb;
                      b_op = 1;
                    end
                  end
                                
                end
              end
              
              default: begin
                res   = 0;
                cout  = 0;
                oflow = 0;
                g     = 0;
                e     = 0;
                l     = 0;
                ERR   = 1;
              end
            endcase
          end
          else begin
              //res   = 0;
              cout  = 0;
              oflow = 0;
              g     = 0;
              l     = 0;
              e     = 0;
              ERR   = 0;
            case(imon.cmd)
              //AND
              0: begin
                if(imon.inp_valid == 0 && a_op == 0 && b_op == 0) begin
                  OPA = 0;
                  OPB = 0;
                  ERR = 1;
                end
                else begin
                `uvm_info("AND INP_VALID CHECK", $sformatf("INP_VALID A and B CHECK a = %b | b = %b", a_op, b_op), UVM_MEDIUM)
                  if(a_op && b_op) begin
                    a_op = 0;
                    b_op = 0;
                    ERR  = 0;
                  end
                  
                  if(imon.inp_valid[0]) begin
                    OPA  = imon.opa;
                    a_op = 1;
                  end
                  
                  if(imon.inp_valid[1]) begin               
                    OPB  = imon.opb;
                    b_op = 1;
                  end
                  
                  if(a_op && b_op) begin
                    res = OPA & OPB;
                    res = res & {`dw{1'b1}};
                  end                
                end
              end
              
              //NAND
              1: begin
                if(imon.inp_valid == 0 && a_op == 0 && b_op == 0) begin
                  OPA = 0;
                  OPB = 0;
                  ERR = 1;
                end
                else begin
                
                  if(a_op && b_op) begin
                    a_op = 0;
                    b_op = 0;
                    ERR  = 0;
                  end
                  
                  if(imon.inp_valid[0]) begin
                    OPA  = imon.opa;
                    a_op = 1;
                  end
                  
                  if(imon.inp_valid[1]) begin               
                    OPB  = imon.opb;
                    b_op = 1;
                  end
                  
                  if(a_op && b_op) begin
                    res = ~(OPA & OPB);
                    res = res & {`dw{1'b1}};
                  end
                                  
                end
              end
              
              //OR
              2: begin
                if(imon.inp_valid == 0 && a_op == 0 && b_op == 0) begin
                  OPA = 0;
                  OPB = 0;
                  ERR = 1;
                end
                else begin
                
                  if(a_op && b_op) begin
                    a_op = 0;
                    b_op = 0;
                    ERR  = 0;
                  end
                  
                  if(imon.inp_valid[0]) begin
                    OPA  = imon.opa;
                    a_op = 1;
                  end
                  
                  if(imon.inp_valid[1]) begin               
                    OPB  = imon.opb;
                    b_op = 1;
                  end
                  
                  if(a_op && b_op) begin
                    res = OPA | OPB;
                    res = res & {`dw{1'b1}};
                  end                
                end
              end
              
              //NOR
              3: begin
                if(imon.inp_valid == 0 && a_op == 0 && b_op == 0) begin
                  OPA = 0;
                  OPB = 0;
                  ERR = 1;
                end
                else begin
                
                  if(a_op && b_op) begin
                    a_op = 0;
                    b_op = 0;
                    ERR  = 0;
                  end
                  
                  if(imon.inp_valid[0]) begin
                    OPA  = imon.opa;
                    a_op = 1;
                  end
                  
                  if(imon.inp_valid[1]) begin               
                    OPB  = imon.opb;
                    b_op = 1;
                  end
                  
                  if(a_op && b_op) begin
                    res = ~(OPA | OPB);
                    res = res & {`dw{1'b1}};
                  end                
                end
              end
              
              //XOR
              4: begin
                if(imon.inp_valid == 0 && a_op == 0 && b_op == 0) begin
                  OPA = 0;
                  OPB = 0;
                  ERR = 1;
                end
                else begin
                
                  if(a_op && b_op) begin
                    a_op = 0;
                    b_op = 0;
                    ERR  = 0;
                  end
                  
                  if(imon.inp_valid[0]) begin
                    OPA  = imon.opa;
                    a_op = 1;
                  end
                  
                  if(imon.inp_valid[1]) begin               
                    OPB  = imon.opb;
                    b_op = 1;
                  end
                  
                  if(a_op && b_op) begin
                    res = OPA ^ OPB;
                    res = res & {`dw{1'b1}};
                  end                
                end
              end
              
              //XNOR
              5: begin
                if(imon.inp_valid == 0 && a_op == 0 && b_op == 0) begin
                  OPA = 0;
                  OPB = 0;
                  ERR = 1;
                end
                else begin
                
                  if(a_op && b_op) begin
                    a_op = 0;
                    b_op = 0;
                    ERR  = 0;
                  end
                  
                  if(imon.inp_valid[0]) begin
                    OPA  = imon.opa;
                    a_op = 1;
                  end
                  
                  if(imon.inp_valid[1]) begin               
                    OPB  = imon.opb;
                    b_op = 1;
                  end
                  
                  if(a_op && b_op) begin
                    res = ~(OPA ^ OPB);
                    res = res & {`dw{1'b1}};
                  end                
                end
              end
              
              //NOT_A
              6: begin
                if(a_op) begin
                  a_op = 0;
                end
               
                if(imon.inp_valid[0]) begin
                  OPA = imon.opa;
                  ERR = 0;
                  a_op = 1;
                end
                else
                  ERR = 1;
                  
                if(a_op) begin
                  res = ~OPA;
                  res = res & {`dw{1'b1}};
                end
              end
              
              //NOT_B
              7: begin
               if(b_op) begin
                  b_op = 0;
               end
                if(imon.inp_valid[1]) begin
                  OPB  = imon.opb;
                  ERR  = 0;
                  b_op = 1;
                end
                else
                  ERR = 1;
                  
                if(b_op) begin
                  res  = ~OPB;
                  res  = res & {`dw{1'b1}};
               end
              end
              
              //SHR1_A
              8: begin
                if(a_op) begin
                  a_op = 0;
                end
                if(imon.inp_valid[0]) begin
                  OPA  = imon.opa;
                  ERR  = 0;
                  a_op = 1;
                end
                else
                  ERR = 1;
                  
                if(a_op) begin
                  res  = OPA >> 1;
                  res  = res & {`dw{1'b1}};
                end
              end
              
              //SHL1_A
              9: begin
                if(a_op) begin
                  a_op = 0;
                end
                
                if(imon.inp_valid[0]) begin
                  OPA  = imon.opa;
                  ERR  = 0;
                  a_op = 1;
                end
                else
                  ERR = 1;
                  
                if(a_op) begin
                  res  = OPA << 1;
                  res  = res & {`dw{1'b1}};
                end
              end
              
              //SHR1_B
              10: begin
                if(b_op) begin
                  b_op = 0;
                end
                if(imon.inp_valid[1]) begin
                  OPB  = imon.opb;
                  ERR  = 0;
                  b_op = 1;
                end
                else
                  ERR = 1;
                  
                if(b_op) begin
                  res  = OPB >> 1;
                  res  = res & {`dw{1'b1}};
                end
              end
              
              //SHL1_B
              11: begin
               if(b_op) begin
                  b_op = 0;
               end 
                if(imon.inp_valid[1]) begin
                  OPB  = imon.opb;
                  ERR  = 0;
                  b_op = 1;
                end
                else
                  ERR = 1;
                  
                if(b_op) begin
                  res = OPB << 1;
                  res = res & {`dw{1'b1}};
               end 
              end
              
              //ROL_A_B
              12: begin //NOt completed
             // `uvm_info("ROL RUNNING", "Triggered", UVM_NONE)
                if(imon.inp_valid == 0 && a_op == 0 && b_op == 0) begin
                  OPA = 0;
                  OPB = 0;
                  ERR = 1;
                end
                else begin
                // `uvm_info("ROL RUNNING", "Triggered internal", UVM_NONE)
                  
                 
                  //`uvm_info("ROL RUNNING", "Triggered internal else", UVM_NONE)
                  if(a_op && b_op) begin
                 // `uvm_info("ROL RUNNING", "OPERATING", UVM_NONE)
                    a_op     = 0;
                    b_op     = 0;
                  end
                 
                    
                  if(imon.inp_valid[0]) begin
                 // `uvm_info("ROL RUNNING", "OPA REGISTERED", UVM_NONE)
                    OPA  = imon.opa;
                    a_op = 1;
                  end
                  
                  if(imon.inp_valid[1]) begin 
                 // `uvm_info("ROL RUNNING", "OPB REGISTERED", UVM_NONE)              
                    OPB  = imon.opb;
                    b_op = 1;
                  end
                  
                  if(OPB[`dw - 1:4] != 0 && a_op && b_op) begin
                  //  `uvm_info("ROL RUNNING", "Triggered internal ERR", UVM_NONE)
                    ERR  = 1;
                    a_op = 0;
                    b_op = 0;
                  end
                  
                  if(a_op && b_op) begin
                   // `uvm_info("ROL RUNNING", "OPERATING", UVM_NONE)
                    res = OPA << OPB[2:0] | OPA >> (`dw - OPB[2:0]);
                    res = res & {`dw{1'b1}};
                  end               
                end
              end
              
              //ROR_A_B
              13: begin
                if(imon.inp_valid == 0 && a_op == 0 && b_op == 0) begin
                  OPA = 0;
                  OPB = 0;
                  ERR = 1;
                end
                else begin
                  
                  
                  if(a_op && b_op) begin
                    a_op = 0;
                    b_op = 0;
                  end
                  
                    
                  if(imon.inp_valid[0]) begin
                    OPA  = imon.opa;
                    a_op = 1;
                  end
                  
                  if(imon.inp_valid[1]) begin               
                    OPB  = imon.opb;
                    b_op = 1;
                  end
                  
                  if(OPB[`dw - 1:4] != 0 && a_op && b_op) begin
                    ERR = 1;
                    a_op = 0;
                    b_op = 0;
                  end
                  
                  if(a_op && b_op) begin
                    `uvm_info("ROR RUNNING", "OPERATING", UVM_NONE)
                    res = OPA >> OPB[2:0] | OPA << (`dw - OPB[2:0]);
                    res = res & {`dw{1'b1}};
                  end               
                end
              end          
              
              default: begin
                res   = 0;
                cout  = 0;
                oflow = 0;
                g     = 0;
                e     = 0;
                l     = 0;
                ERR   = 1;
              end
            endcase
          end
        end
        else begin
          $display("=======================================ERROR TRIGGERED ======================================================");
          ip_val_cnt = 0;
          a_op   = 0;
          b_op   = 0;
          ERR    = 1;
          cout   = 0;
          oflow  = 0;
          g      = 0;
          e      = 0;
          l      = 0;
          //res    = 0;
        end
      end
    end
   // `uvm_info(get_type_name, $sformatf("Reference model execution finished \n res = %0d | cout = %0d | oflow = %0d | g = %b | l = %b | e = %b | err = %b", res, cout, oflow, g, l, e, err), UVM_NONE)
  endtask
  
  function void validate_outputs();
    $display("\n =========================================== VALIDATING OUTPUTS ================================================ \n");
    if(!c_err) begin
      if(omon.res === c_res) begin
        $display("\n======================================= RES PASSED ================================== \n");
       // `uvm_info("INPUTS", $sformatf("OPA = %0h | OPB = %0h | CIN = %b | CMD = %0h | MODE = %0h | INP_VALID = %b | RESET = %b", OPA, OPB, CIN, imon.cmd, imon.mode, imon.inp_valid, imon.reset), UVM_NONE)
        `uvm_info("RES PASSED", $sformatf("RES PASSED Expected RES = %0h | ACTUAL RES = %0h", c_res, omon.res), UVM_NONE)
        
        if(omon.cout === c_cout) begin
          `uvm_info("COUT PASSED", $sformatf("COUT PASSED EXPECTED COUT = %b | ACTUAL COUT = %b", c_cout, omon.cout), UVM_NONE)
        end
        else begin
          `uvm_info("COUT FAILED", $sformatf("COUT FAILED EXPECTED COUT = %b | ACTUAL COUT = %b", c_cout, omon.cout), UVM_NONE)
        end
          
        if(omon.oflow === c_oflow) begin
          `uvm_info("OFLOW PASSED", $sformatf("OFLOW PASSED EXPECTED OFLOW = %b | ACTUAL OFLOW = %b", c_oflow, omon.oflow), UVM_NONE)
        end
        else begin
          `uvm_info("OFLOW FAILED", $sformatf("OFLOW FAILED EXPECTED OFLOW = %b | ACTUAL OFLOW = %b", c_oflow, omon.oflow), UVM_NONE)
        end
        
        if(omon.g === c_g) begin
          `uvm_info("G PASSED", $sformatf("G PASSED EXPECTED G = %b | ACTUAL G = %b", c_g, omon.g), UVM_NONE)
        end
        else begin
          `uvm_info("G FAILED", $sformatf("G FAILED EXPECTED G = %b | ACTUAL G = %b", c_g, omon.g), UVM_NONE)
        end
        
        if(omon.l === c_l) begin
          `uvm_info("L PASSED", $sformatf("L PASSED EXPECTED L = %b | ACTUAL L = %b", c_l, omon.l), UVM_NONE)
        end
        else begin
          `uvm_info("L FAILED", $sformatf("L FAILED EXPECTED L = %b | ACTUAL L = %b", c_l, omon.l), UVM_NONE)
        end
        
        if(omon.e === c_e) begin
          `uvm_info("E PASSED", $sformatf("E PASSED EXPECTED E = %b | ACTUAL E = %b", c_e, omon.e), UVM_NONE)
        end
        else begin
          `uvm_info("E FAILED", $sformatf("E FAILED EXPECTED E = %b | ACTUAL E = %b", c_e, omon.e), UVM_NONE)
        end
        
        if(omon.err === c_err) begin
          `uvm_info("ERR PASSED", $sformatf("ERR PASSED EXPECTED ERR = %b | ACTUAL ERR = %b", c_err, omon.err), UVM_NONE)
        end
        else begin
          `uvm_info("ERR FAILED", $sformatf("ERR FAILED EXPECTED ERR = %b | ACTUAL ERR = %b", c_err, omon.err), UVM_NONE)
        end
      end
      else begin
      
        $display("\n======================================= RES FAILED ================================== \n");
       // `uvm_info("INPUTS", $sformatf("OPA = %0h | OPB = %0h | CIN = %b | CMD = %0h | MODE = %0h | INP_VALID = %b | RESET = %b", OPA, OPB, CIN, imon.cmd, imon.mode, imon.inp_valid, imon.reset), UVM_NONE)
        `uvm_info("RES FAILED", $sformatf("RES FAILED Expected RES = %0h | ACTUAL RES = %0h", c_res, omon.res), UVM_NONE)
        
        if(omon.cout === c_cout) begin
          `uvm_info("COUT PASSED", $sformatf("COUT PASSED EXPECTED COUT = %b | ACTUAL COUT = %b", c_cout, omon.cout), UVM_NONE)
        end
        else begin
          `uvm_info("COUT FAILED", $sformatf("COUT FAILED EXPECTED COUT = %b | ACTUAL COUT = %b", c_cout, omon.cout), UVM_NONE)
        end
          
        if(omon.oflow === c_oflow) begin
          `uvm_info("OFLOW PASSED", $sformatf("OFLOW PASSED EXPECTED OFLOW = %b | ACTUAL OFLOW = %b", c_oflow, omon.oflow), UVM_NONE)
        end
        else begin
          `uvm_info("OFLOW FAILED", $sformatf("OFLOW FAILED EXPECTED OFLOW = %b | ACTUAL OFLOW = %b", c_oflow, omon.oflow), UVM_NONE)
        end
        
        if(omon.g === c_g) begin
          `uvm_info("G PASSED", $sformatf("G PASSED EXPECTED G = %b | ACTUAL G = %b", c_g, omon.g), UVM_NONE)
        end
        
        else begin
          `uvm_info("G FAILED", $sformatf("G FAILED EXPECTED G = %b | ACTUAL G = %b", c_g, omon.g), UVM_NONE)
        end
        
        if(omon.l === c_l) begin
          `uvm_info("L PASSED", $sformatf("L PASSED EXPECTED L = %b | ACTUAL L = %b", c_l, omon.l), UVM_NONE)
        end
        else begin
          `uvm_info("L FAILED", $sformatf("L FAILED EXPECTED L = %b | ACTUAL L = %b", c_l, omon.l), UVM_NONE)
        end
        
        if(omon.e === c_e) begin
          `uvm_info("E PASSED", $sformatf("E PASSED EXPECTED E = %b | ACTUAL E = %b", c_e, omon.e), UVM_NONE)
        end
        else begin
          `uvm_info("E FAILED", $sformatf("E FAILED EXPECTED E = %b | ACTUAL E = %b", c_e, omon.e), UVM_NONE)
        end
        
        if(omon.err === c_err) begin
          `uvm_info("ERR PASSED", $sformatf("ERR PASSED EXPECTED ERR = %b | ACTUAL ERR = %b", c_err, omon.err), UVM_NONE)
        end
        else begin
          `uvm_info("ERR FAILED", $sformatf("ERR FAILED EXPECTED ERR = %b | ACTUAL ERR = %b", c_err, omon.err), UVM_NONE)
        end
      end
    end
    else begin
      if(omon.err === c_err) begin
          $display("\n======================================= ERR PASSED ================================== \n");
        //`uvm_info("INPUTS", $sformatf("OPA = %0h | OPB = %0h | CIN = %b | CMD = %0h | MODE = %0h | INP_VALID = %b | RESET = %b", OPA, OPB, CIN, imon.cmd, imon.mode, imon.inp_valid, imon.reset), UVM_NONE)
        `uvm_info("ERR PASSED", $sformatf("ERR PASSED EXPECTED ERR = %b | ACTUAL ERR = %b", c_err, omon.err), UVM_NONE)
      end
      else begin
        $display("\n======================================= ERR FAILED ================================== \n");
        //`uvm_info("INPUTS", $sformatf("OPA = %0h | OPB = %0h | CIN = %b | CMD = %0h | MODE = %0h | INP_VALID = %b | RESET = %b", OPA, OPB, CIN, imon.cmd, imon.mode, imon.inp_valid, imon.reset), UVM_NONE)
        `uvm_info("ERR FAILED", $sformatf("ERR FAILED EXPECTED ERR = %b | ACTUAL ERR = %b", c_err, omon.err), UVM_NONE)
      end
    end
  $display("\n ========================================== CHECK DONE ================================================= \n");
  endfunction
endclass
