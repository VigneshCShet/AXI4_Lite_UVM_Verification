class coverage_col extends uvm_subscriber#(trans);
  `uvm_component_utils(coverage_col)
  //uvm_analysis_imp #(trans, coverage_col) ap;
  trans imon;
  
  
  covergroup cg;
    cp_opa: coverpoint imon.opa{
      bins b_opa[2] = {[0:255]};
    }
    
    cp_opb: coverpoint imon.opb{
      bins b_opb[2] = {[0:255]};
    }
    
    cp_rst: coverpoint imon.reset;
    
    cp_ce:  coverpoint imon.ce;
    
    cp_cin: coverpoint imon.cin;
    
    cp_cmd: coverpoint imon.cmd{
      bins b_cmd[] = {[0:10]};
      bins l_cmd[] = {[11:13]};
      ignore_bins ig_cmd = {[14:15]};
    }
    
    cp_mode: coverpoint imon.mode;
    
    cp_inp_valid: coverpoint imon.inp_valid;
    
    cx_ip_v_CMD_MODE: cross cp_inp_valid, cp_cmd, cp_mode{
    
      ignore_bins ig_bin = binsof(cp_mode) intersect {1} && binsof(cp_cmd) intersect {[11:13]} && binsof(cp_inp_valid);
    }
    
    cx_cin_cmd: cross cp_cin, cp_cmd;
    
    cx_cmd_ce: cross cp_cmd, cp_ce;
    
    cx_mode_cmd: cross cp_mode, cp_cmd;
    
  endgroup
  
  function new(string name = "coverage_col", uvm_component parent = null);
    super.new(name, parent);
    cg = new();
  endfunction
  
  function void write(trans t);
    imon = t;
    cg.sample();
  endfunction
endclass
