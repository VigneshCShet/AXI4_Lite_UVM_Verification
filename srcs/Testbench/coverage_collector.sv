`uvm_analysis_imp_decl(_rd)

class axi_coverage_collector extends uvm_subscriber #(trans);
  `uvm_component_utils(axi_coverage_collector)
  
  uvm_analysis_imp_rd #(trans, axi_coverage_collector) imp_r;
  
  trans imon_w, imon_r;
  
  covergroup cg_w;
    cp_rst: coverpoint imon_w.rst;
    cp_awaddr: coverpoint imon_w.awaddr{
      bins valid_addr[] = {[0:63]};
      bins invalid_addr = default;
    }
    
    cp_wdata: coverpoint imon_w.wdata{
      bins wdata_c[4] = {[0:$]};
    }   
    
    cp_wstrb: coverpoint imon_w.wstrb;
    
  endgroup
  
  covergroup cg_r;
    
    cp_araddr: coverpoint imon_r.araddr{
      bins valid_addr[] = {[0:63]};
      bins invalid_addr = default;
    }

  endgroup
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
    imp_r = new("imp_r", this);
    cg_w = new();
    cg_r = new();
  endfunction
  
  function void write(trans t);
    imon_w = t;
    cg_w.sample();
  endfunction
  
  function void write_rd(trans q);
    imon_r = q;
    cg_r.sample();
  endfunction
  
endclass

