class base_test extends uvm_test;
  `uvm_component_utils(base_test)
  
  alu_env en;
  
  function new(string name = "base_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    en = alu_env :: type_id :: create("en", this);
  endfunction
  
  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction
endclass



class regression_test extends base_test;
  `uvm_component_utils(regression_test)
  
  alu_sequence_arith s1;
  alu_sequence_logic s2;
  alu_sequence_inp_valid_01 s3;
  alu_sequence_inp_valid_error_01 s4;
  alu_sequence_inp_valid_10 s5;
  alu_sequence_inp_valid_error_10 s6;
  alu_sequence_inp_valid_01_arith s7;
  alu_sequence_inp_valid_error_10_arith s10;
  alu_sequence_inp_valid_10_arith s9;
  alu_sequence_inp_valid_error_01_arith s8;
  sequence_inp_valid_error_00 s11;
  sequence_ce s12;
  sequence_error s13;
  sequence_inp_valid_error_1_op s14;
  sanity_sequence_arith s15;
  sanity_sequence_logic s16;
  corner_sequence s17;
  
  function new(string name = "regression_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);    
  endfunction

  task run_phase(uvm_phase phase);
  
    super.run_phase(phase);
    
    s1  = alu_sequence_arith                     :: type_id :: create("s1");
    s2  = alu_sequence_logic                     :: type_id :: create("s2");
    s3  = alu_sequence_inp_valid_01              :: type_id :: create("s3");
    s4  = alu_sequence_inp_valid_error_01        :: type_id :: create("s4");
    s5  = alu_sequence_inp_valid_10              :: type_id :: create("s5");
    s6  = alu_sequence_inp_valid_error_10        :: type_id :: create("s6");
    s7  = alu_sequence_inp_valid_01_arith        :: type_id :: create("s7");
    s8  = alu_sequence_inp_valid_error_01_arith  :: type_id :: create("s8");
    s9  = alu_sequence_inp_valid_10_arith        :: type_id :: create("s9");
    s10 = alu_sequence_inp_valid_error_10_arith  :: type_id :: create("s10");
    s11 = sequence_inp_valid_error_00            :: type_id :: create("s11");
    s12 = sequence_ce                            :: type_id :: create("s12");
    s13 = sequence_error                         :: type_id :: create("s13");
    s14 = sequence_inp_valid_error_1_op          :: type_id :: create("s14");
    s15 = sanity_sequence_arith                  :: type_id :: create("s15");
    s16 = sanity_sequence_logic                  :: type_id :: create("s16");
    s17 = corner_sequence                        :: type_id :: create("s17");

    phase.raise_objection(this);
    
    
    s1.start(en.agi.seqr);
    s2.start(en.agi.seqr);
    s3.start(en.agi.seqr);
    s4.start(en.agi.seqr);
    s5.start(en.agi.seqr);
    s6.start(en.agi.seqr);
    s7.start(en.agi.seqr);
    s8.start(en.agi.seqr);
    s9.start(en.agi.seqr);
    s10.start(en.agi.seqr);
    s11.start(en.agi.seqr);
    s12.start(en.agi.seqr);
    s13.start(en.agi.seqr);
    s14.start(en.agi.seqr);
    s15.start(en.agi.seqr);
    s16.start(en.agi.seqr);
    s17.start(en.agi.seqr);
    
    `uvm_info(get_type_name(),"Dropping objection", UVM_NONE)
    
    phase.drop_objection(this);
    
  endtask
  
endclass 



class error_test extends base_test;
  `uvm_component_utils(error_test)
  
  alu_sequence_inp_valid_error_01 s1;
  alu_sequence_inp_valid_error_10 s2;
  sequence_inp_valid_error_00 s3;
  sequence_error s4;
  sequence_inp_valid_error_1_op s5;
  
  function new(string name = "error_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    s1 = alu_sequence_inp_valid_error_01 :: type_id :: create("s1");
    s2 = alu_sequence_inp_valid_error_10 :: type_id :: create("s2");
    s3 = sequence_inp_valid_error_00     :: type_id :: create("s3");
    s4 = sequence_error                  :: type_id :: create("s4");
    s5 = sequence_inp_valid_error_1_op   :: type_id :: create("s5");
    
    phase.raise_objection(this);
    
    s1.start(en.agi.seqr);
    s2.start(en.agi.seqr);
    s3.start(en.agi.seqr);
    s4.start(en.agi.seqr);
    s5.start(en.agi.seqr);
    
    `uvm_info(get_type_name(),"Dropping objection", UVM_NONE)
    
    phase.drop_objection(this);
  endtask
endclass

class sanity_test extends base_test;
  `uvm_component_utils(sanity_test)
  
  sanity_sequence_arith s1;
  sanity_sequence_logic s2;
  
  function new(string name = "sanity_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    s1 = sanity_sequence_arith :: type_id :: create("s1");
    s2 = sanity_sequence_logic :: type_id :: create("s2");
    
    phase.raise_objection(this);
    
    s1.start(en.agi.seqr);
    s2.start(en.agi.seqr);
    
    `uvm_info(get_type_name(),"Dropping objection", UVM_NONE)
    
    phase.drop_objection(this);
  endtask
endclass

class corner_test extends base_test;
  `uvm_component_utils(corner_test)
  
  corner_sequence s1;
  
  function new(string name = "corner_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    s1 = corner_sequence :: type_id :: create("s1");
    
    phase.raise_objection(this);
    
    s1.start(en.agi.seqr);
    
    `uvm_info(get_type_name(),"Dropping objection", UVM_NONE)
    
    phase.drop_objection(this);
  endtask
endclass
