class base_test extends uvm_test;
  `uvm_component_utils(base_test)
  axi_environment env;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = axi_environment :: type_id :: create("env", this);
  endfunction
  
  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction
  
endclass

class write_read_test extends base_test;
  `uvm_component_utils(write_read_test)
  
  dummy_vsequence vs;
  WD_WA_R_vsequence v1;
  WA_WD_R_vsequence v2;
  WA_WD_parallel_R_vsequence v3;
  WAD_non_parallel_R_vsequence v4;
  WAD_parallel_R_vsequence v5;
  WA_3_cycle_later_WD_R_vsequence v6;
  WD_3_cycle_later_WA_R_vsequence v7;
  WA_WD_R_prot_vsequence v8;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  task run_phase(uvm_phase phase);
  
    vs = dummy_vsequence                 :: type_id :: create("vs");
    v1 = WD_WA_R_vsequence               :: type_id :: create("v1");
    v2 = WA_WD_R_vsequence               :: type_id :: create("v2");
    v3 = WA_WD_parallel_R_vsequence      :: type_id :: create("v3");
    v4 = WAD_non_parallel_R_vsequence    :: type_id :: create("v4");
    v5 = WAD_parallel_R_vsequence        :: type_id :: create("v5");
    v6 = WA_3_cycle_later_WD_R_vsequence :: type_id :: create("v6");
    v7 = WD_3_cycle_later_WA_R_vsequence :: type_id :: create("v7");
    v8 = WA_WD_R_prot_vsequence          :: type_id :: create("v8");
    
    phase.raise_objection(this);
      
      vs.start(env.vseqr);
      v1.start(env.vseqr);
      v2.start(env.vseqr);
      v3.start(env.vseqr);
      v4.start(env.vseqr);
      v5.start(env.vseqr);
      v6.start(env.vseqr);
      v7.start(env.vseqr);
      v8.start(env.vseqr);
      #1000;
      
    phase.drop_objection(this);
    
  endtask
  
endclass

class read_write_test extends base_test;
  `uvm_component_utils(read_write_test)
  
  dummy_vsequence vs;
  write_only_vsequence v1;
  R_WA_WD_vsequence v2;
  R_WA_WD_same_addr_vsequence v3;
  Read_only_vsequence v4;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  task run_phase(uvm_phase phase);
  
    vs = dummy_vsequence             :: type_id :: create("vs");
    v1 = write_only_vsequence        :: type_id :: create("v1");
    v2 = R_WA_WD_vsequence           :: type_id :: create("v2");
    v3 = R_WA_WD_same_addr_vsequence :: type_id :: create("v3");
    v4 = Read_only_vsequence         :: type_id :: create("v4");
    
    phase.raise_objection(this);
      
      vs.start(env.vseqr);
      v1.start(env.vseqr);
      v2.start(env.vseqr);
      v3.start(env.vseqr);
      v4.start(env.vseqr);
      #1000;
      
    phase.drop_objection(this);
    
  endtask
  
endclass

class write_strobe_test extends base_test;
  `uvm_component_utils(write_strobe_test)
  
  dummy_vsequence vs;
  WD_WA_wstrb_R_vsequence v1;
  WA_WD_R_wstrb_vsequence v2;
  WAD_R_wstrb_vsequence v3;
  WA_WD_R_wstrb_directed_vsequence v4;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  task run_phase(uvm_phase phase);
  
    vs = dummy_vsequence                  :: type_id :: create("vs");
    v1 = WD_WA_wstrb_R_vsequence          :: type_id :: create("v1");
    v2 = WA_WD_R_wstrb_vsequence          :: type_id :: create("v2");
    v3 = WAD_R_wstrb_vsequence            :: type_id :: create("v3");
    v4 = WA_WD_R_wstrb_directed_vsequence :: type_id :: create("v4");
    
    phase.raise_objection(this);
      
      vs.start(env.vseqr);
      v1.start(env.vseqr);
      v2.start(env.vseqr);
      v3.start(env.vseqr);
      v4.start(env.vseqr);
      #1000;
      
    phase.drop_objection(this);
    
  endtask
  
endclass

class unaligned_address_test extends base_test;
  `uvm_component_utils(unaligned_address_test)
  
  dummy_vsequence vs;
  WA_WD_R_address_unaligned_vsequences v1;
  WD_WA_R_address_unaligned_vsequences v2;
  WDA_R_address_unaligned_vsequences v3;

  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  task run_phase(uvm_phase phase);
  
    vs  = dummy_vsequence                      :: type_id :: create("vs");
    v1  = WA_WD_R_address_unaligned_vsequences :: type_id :: create("v1");
    v2  = WD_WA_R_address_unaligned_vsequences :: type_id :: create("v2");
    v3  = WDA_R_address_unaligned_vsequences   :: type_id :: create("v3");

    
    phase.raise_objection(this);
      
      vs.start(env.vseqr);
      v1.start(env.vseqr);
      v2.start(env.vseqr);
      v3.start(env.vseqr);
      #1000;
      
    phase.drop_objection(this);
    
  endtask
  
endclass

class out_of_bound_address_test extends base_test;
  `uvm_component_utils(out_of_bound_address_test)
  
  dummy_vsequence vs;
  WA_WD_OF_bound_address_vsequences v1;
  WD_WA_OF_bound_address_vsequences v2;
  WDA_OF_bound_address_vsequences v3;
  WA_WD_OF_bound_address_directed_vsequences v4;

  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  task run_phase(uvm_phase phase);
  
    vs  = dummy_vsequence                            :: type_id :: create("vs");
    v1  = WA_WD_OF_bound_address_vsequences          :: type_id :: create("v1");
    v2  = WD_WA_OF_bound_address_vsequences          :: type_id :: create("v2");
    v3  = WDA_OF_bound_address_vsequences            :: type_id :: create("v3");
    v4  = WA_WD_OF_bound_address_directed_vsequences :: type_id :: create("v4");

    
    phase.raise_objection(this);
      
      vs.start(env.vseqr);
      v1.start(env.vseqr);
      v2.start(env.vseqr);
      v3.start(env.vseqr);
      v4.start(env.vseqr);
      #1000;
      
    phase.drop_objection(this);
    
  endtask
  
endclass

class out_of_bound_and_unaligned_address_test extends base_test;
  `uvm_component_utils(out_of_bound_and_unaligned_address_test)
  
  dummy_vsequence vs;
  WA_WD_R_OF_bound_address_unaligned_vsequences v1;
  WD_WA_R_OF_bound_address_unaligned_vsequences v2;
  WDA_R_OF_bound_address_unaligned_vsequences v3;

  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  task run_phase(uvm_phase phase);
  
    vs  = dummy_vsequence                               :: type_id :: create("vs");
    v1  = WA_WD_R_OF_bound_address_unaligned_vsequences :: type_id :: create("v1");
    v2  = WD_WA_R_OF_bound_address_unaligned_vsequences :: type_id :: create("v2");
    v3  = WDA_R_OF_bound_address_unaligned_vsequences   :: type_id :: create("v3");

    
    phase.raise_objection(this);
      
      vs.start(env.vseqr);
      v1.start(env.vseqr);
      v2.start(env.vseqr);
      v3.start(env.vseqr);
      #1000;
      
    phase.drop_objection(this);
    
  endtask
  
endclass

class RO_WO_address_test extends base_test;
  `uvm_component_utils(RO_WO_address_test)
  
  dummy_vsequence vs;
  WD_WA_R_vsequence vw;
  WD_WA_in_read_only_vsequences v1;
  WA_WD_in_read_only_vsequences v2;
  WDA_in_read_only_vsequences v3;
  R_in_write_only_vsequences v4;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  task run_phase(uvm_phase phase);
  
    vs = dummy_vsequence               :: type_id :: create("vs");
    vw = WD_WA_R_vsequence             :: type_id :: create("vw");
    v1 = WD_WA_in_read_only_vsequences :: type_id :: create("v1");
    v2 = WA_WD_in_read_only_vsequences :: type_id :: create("v2");
    v3 = WDA_in_read_only_vsequences   :: type_id :: create("v3");
    v4 = R_in_write_only_vsequences    :: type_id :: create("v4");

    phase.raise_objection(this);
      
      vs.start(env.vseqr);
      vw.start(env.vseqr);
      v1.start(env.vseqr);
      v2.start(env.vseqr);
      v3.start(env.vseqr);
      v4.start(env.vseqr);
      #1000;
      
    phase.drop_objection(this);
    
  endtask
    
endclass

class WA_WD_R_drive_without_waiting_for_ready_test extends base_test;
  `uvm_component_utils(WA_WD_R_drive_without_waiting_for_ready_test)
  
  dummy_vsequence vs;
  write_only_vsequence vw;
  WA_WD_R_drive_without_waiting_for_ready_vsequences v1;
  WA_WD_R_drive_without_waiting_for_ready_parallel_vsequences v2;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  task run_phase(uvm_phase phase);
  
    vs = dummy_vsequence                                             :: type_id :: create("vs");
    vw = write_only_vsequence                                        :: type_id :: create("vw");
    v1 = WA_WD_R_drive_without_waiting_for_ready_vsequences          :: type_id :: create("v1");
    v2 = WA_WD_R_drive_without_waiting_for_ready_parallel_vsequences :: type_id :: create("v2");

    phase.raise_objection(this);
      
      vs.start(env.vseqr);
      vw.start(env.vseqr);
      v1.start(env.vseqr);
      #1000;
      
    phase.drop_objection(this);
    
  endtask
endclass

class WA_WD_R_drive_bready_and_rready_after_4_clk_cycle_test extends base_test;
  `uvm_component_utils(WA_WD_R_drive_bready_and_rready_after_4_clk_cycle_test)
  
  dummy_vsequence vs;
  write_only_vsequence vw;
  WA_WD_R_drive_bready_and_rready_after_4_clk_cycle_vsequences v1;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  task run_phase(uvm_phase phase);
  
    vs = dummy_vsequence                                              :: type_id :: create("vs");
    vw = write_only_vsequence                                         :: type_id :: create("vw");
    v1 = WA_WD_R_drive_bready_and_rready_after_4_clk_cycle_vsequences :: type_id :: create("v1");

    phase.raise_objection(this);
      
      vs.start(env.vseqr);
      vw.start(env.vseqr);
      v1.start(env.vseqr);
      #1000;
      
    phase.drop_objection(this);
    
  endtask
endclass

class WA_WD_R_drive_bready_and_rready_always_high_test extends base_test;
  `uvm_component_utils(WA_WD_R_drive_bready_and_rready_always_high_test)
  
  dummy_vsequence vs;
  write_only_vsequence vw;
  WA_WD_R_drive_bready_and_rready_always_high_vsequences v1;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  task run_phase(uvm_phase phase);
  
    vs = dummy_vsequence                                        :: type_id :: create("vs");
    vw = write_only_vsequence                                   :: type_id :: create("vw");
    v1 = WA_WD_R_drive_bready_and_rready_always_high_vsequences :: type_id :: create("v1");

    phase.raise_objection(this);
      
      vs.start(env.vseqr);
      vw.start(env.vseqr);
      v1.start(env.vseqr);
      #1000;
      
    phase.drop_objection(this);
    
  endtask
endclass
