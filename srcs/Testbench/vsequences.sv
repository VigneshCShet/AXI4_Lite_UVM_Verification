class vseq extends uvm_sequence #(trans);
  `uvm_object_utils(vseq)
  
  virtual_seqr vseqr;
  
  function new(string name = "vseq");
    super.new(name);
  endfunction
  
  task body;
    $cast(vseqr, m_sequencer);
  endtask
  
endclass

class dummy_vsequence extends vseq;
  `uvm_object_utils(dummy_vsequence)

  dummy_sequence s1;

  function new(string name = "dummy_vsequence");
    super.new(name);
  endfunction
  
  task body;
  
    super.body();
    s1 = dummy_sequence :: type_id :: create("s1");
    
    $display("\n===============================================      Dummy Sequence    ========================================================== \n");
    repeat(5) begin
      s1.start(vseqr.w_sqr);  // RUNS ONCE
    end
    $display("\n ==============================================  END Of Dummy Sequence ========================================================== \n");
  endtask
  
endclass

//================================================================================================================================================================

class WD_WA_R_vsequence extends vseq;
  `uvm_object_utils(WD_WA_R_vsequence)

  WD_WA_sequence s1;
  R_with_past_addr_Sequence s2;

  function new(string name = "WD_WA_R_vsequence");
    super.new(name);
  endfunction
  
  task body;
    super.body();
    
    s1 = WD_WA_sequence            :: type_id :: create("s1");
    s2 = R_with_past_addr_Sequence :: type_id :: create("s2");
    
    $display("\n============================== Write Data First and Write Address next and the Read Sequence ====================================== \n");
    repeat(`txns) begin
      s1.start(vseqr.w_sqr);  // RUNS ONCE
      s2.past_addr = s1.past_addr;
      s2.start(vseqr.r_sqr); // RUNS ONCE
    end
    $display("\n ==============================================  END Of WD WA R Sequence ========================================================== \n");
  endtask
  
endclass

//================================================================================================================================================================

class WA_WD_R_vsequence extends vseq;
  `uvm_object_utils(WA_WD_R_vsequence)
 
  WA_WD_sequence s1;
  R_with_past_addr_Sequence s2;

  function new(string name = "WA_WD_R_vsequence");
    super.new(name);
  endfunction
  
  task body;
    super.body();
    
    s1 = WA_WD_sequence            :: type_id :: create("s1");
    s2 = R_with_past_addr_Sequence :: type_id :: create("s2");
    
    $display("\n ============================== Write Address First and Write Data next and the Read Sequence ====================================== \n");
    repeat(`txns) begin
      s1.start(vseqr.w_sqr);  // RUNS ONCE
      s2.past_addr = s1.past_addr;
      s2.start(vseqr.r_sqr); // RUNS ONCE
    end
    $display("\n ==============================================  END Of WA WD R Sequence =========================================================== \n");
  endtask
  
endclass

//==============================================================================================================================================================

class WA_WD_R_prot_vsequence extends vseq;
  `uvm_object_utils(WA_WD_R_prot_vsequence)
 
  WD_WA_awprot_sequence s1;
  R_arprot_Sequence s2;

  function new(string name = "WA_WD_R_prot_vsequence");
    super.new(name);
  endfunction
  
  task body;
    super.body();
    
    s1 = WD_WA_awprot_sequence :: type_id :: create("s1");
    s2 = R_arprot_Sequence     :: type_id :: create("s2");
    
    $display("\n ============================== Write Address First and Write Data next and the Read Sequence with prot ====================================== \n");
    repeat(`txns) begin
      s1.start(vseqr.w_sqr);  // RUNS ONCE
      s2.start(vseqr.r_sqr); // RUNS ONCE
    end
    $display("\n ==============================================  END Of WA WD R prot Sequence =========================================================== \n");
  endtask
  
endclass

//================================================================================================================================================================

class write_only_vsequence extends vseq;
  `uvm_object_utils(write_only_vsequence)
 
  WA_WD_sequence s1;

  function new(string name = "write_only_vsequence");
    super.new(name);
  endfunction
  
  task body;
    super.body();
    
    s1 = WA_WD_sequence :: type_id :: create("s1");
    
    $display("\n ============================================== Write Only Sequence ====================================== \n");
    repeat(`txns) begin
      s1.start(vseqr.w_sqr);
    end
    $display("\n ============================================== END Of Write Only Sequence =========================================================== \n");
  endtask
  
endclass
//================================================================================================================================================================

class WA_WD_parallel_R_vsequence extends vseq;
  `uvm_object_utils(WA_WD_parallel_R_vsequence)
 
  WA_WD_sequence s1;
  R_Sequence s2;

  function new(string name = "WA_WD_parallel_R_vsequence");
    super.new(name);
  endfunction
  
  task body;
    super.body();
    
    s1 = WA_WD_sequence :: type_id :: create("s1");
    s2 = R_Sequence     :: type_id :: create("s2");
    
    $display("\n============================== Write Address and Write Data sent at same time and the Read Sequence ====================================== \n");
    
    repeat(`txns) fork
      s1.start(vseqr.w_sqr);  // RUNS ONCE
      s2.start(vseqr.r_sqr); // RUNS ONCE
    join
    
    $display("\n ==============================================  END Of WAD R Sequence =========================================================== \n");
  endtask
  
endclass

//================================================================================================================================================================

class WA_3_cycle_later_WD_R_vsequence extends vseq;
  `uvm_object_utils(WA_3_cycle_later_WD_R_vsequence)
 
  WA_WD_each_delayed_3_cycle_sequences s1;
  R_Sequence s2;

  function new(string name = "WA_3_cycle_later_WD_R_vsequence");
    super.new(name);
  endfunction
  
  task body;
    super.body();
    
    s1 = WA_WD_each_delayed_3_cycle_sequences :: type_id :: create("s1");
    s2 = R_Sequence                           :: type_id :: create("s2");
    
    $display("\n============================== Write Address and Write Data sent after 3 cycles and the Read Sequence ====================================== \n");
    
    repeat(`txns) fork
      s1.start(vseqr.w_sqr);  // RUNS ONCE
      s2.start(vseqr.r_sqr); // RUNS ONCE
    join
    
    $display("\n =============================  END Of Write Address and Write Data sent after 3 cycles and the Read Sequence ============================== \n");
  endtask
  
endclass

//================================================================================================================================================================

class WD_3_cycle_later_WA_R_vsequence extends vseq;
  `uvm_object_utils(WD_3_cycle_later_WA_R_vsequence)
 
  WD_WA_each_delayed_3_cycle_sequences s1;
  R_Sequence s2;

  function new(string name = "WD_3_cycle_later_WA_R_vsequence");
    super.new(name);
  endfunction
  
  task body;
    super.body();
    
    s1 = WD_WA_each_delayed_3_cycle_sequences :: type_id :: create("s1");
    s2 = R_Sequence                           :: type_id :: create("s2");
    
    $display("\n============================== Write Data and Write Address sent after 3 cycles and the Read Sequence ====================================== \n");
    
    repeat(`txns) fork
      s1.start(vseqr.w_sqr);  // RUNS ONCE
      s2.start(vseqr.r_sqr); // RUNS ONCE
    join
    
    $display("\n =============================  END Of Write Data and Write Address sent after 3 cycles and the Read Sequence ============================== \n");
  endtask
  
endclass

//================================================================================================================================================================

class WAD_non_parallel_R_vsequence extends vseq;
  `uvm_object_utils(WAD_non_parallel_R_vsequence)
 
  WAD_sequence s1;
  R_Sequence s2;

  function new(string name = "WAD_non_parallel_R_vsequence");
    super.new(name);
  endfunction
  
  task body;
    super.body();
    
    s1 = WAD_sequence :: type_id :: create("s1");
    s2 = R_Sequence     :: type_id :: create("s2");
    
    $display("\n============================== Write Address and Write Data sent at same time and the Read Sequence ====================================== \n");
    
    repeat(`txns) begin
      s1.start(vseqr.w_sqr);  // RUNS ONCE
    end
    
    repeat(`txns) begin
      s2.start(vseqr.r_sqr);
    end
    
    $display("\n ==============================================  END Of WAD R Sequence =========================================================== \n");
  endtask
  
endclass

//=====================================================================================================================

class WAD_parallel_R_vsequence extends vseq;
  `uvm_object_utils(WAD_parallel_R_vsequence)
 
  WAD_sequence s1;
  R_Sequence s2;

  function new(string name = "WAD_parallel_R_vsequence");
    super.new(name);
  endfunction
  
  task body;
    super.body();
    
    s1 = WAD_sequence :: type_id :: create("s1");
    s2 = R_Sequence     :: type_id :: create("s2");
    
    $display("\n============================== Write Address and Write Data sent at same time and the Read Sequence ====================================== \n");
    
    repeat(`txns) fork
      s1.start(vseqr.w_sqr);  
      s2.start(vseqr.r_sqr);
    join
    
    $display("\n ==============================================  END Of WAD R Sequence =========================================================== \n");
  endtask
  
endclass

//=================================================================================================================================================================================

class Read_only_vsequence extends vseq;
  `uvm_object_utils(Read_only_vsequence)
 
  R_Sequence s2;

  function new(string name = "Read_only_vsequence");
    super.new(name);
  endfunction
  
  task body;
    super.body();
 
    s2 = R_Sequence     :: type_id :: create("s2");
    
    $display("\n============================== Read only Sequence ====================================== \n");
    
    repeat(`txns) fork
      s2.start(vseqr.r_sqr);
    join
    
    $display("\n ==============================================  END Of R only Sequence =========================================================== \n");
  endtask
  
endclass

//=================================================================================================================================================================================

class WD_WA_wstrb_R_vsequence extends vseq;
  `uvm_object_utils(WD_WA_wstrb_R_vsequence)

  WD_WA_wstrb_sequence s1;
  R_with_past_addr_Sequence s2;

  function new(string name = "WD_WA_wstrb_R_vsequence");
    super.new(name);
  endfunction
  
  task body;
    super.body();
    
    s1 = WD_WA_wstrb_sequence      :: type_id :: create("s1");
    s2 = R_with_past_addr_Sequence :: type_id :: create("s2");
    
    $display("\n============================== Write Data with WSTRB First and Write Address next and the Read Sequence ====================================== \n");
    repeat(`txns) begin
      s1.start(vseqr.w_sqr);  // RUNS ONCE
      s2.past_addr = s1.past_addr;
      s2.start(vseqr.r_sqr); // RUNS ONCE
    end
    $display("\n ==============================================  END Of WD with WSTRB WA R Sequence ========================================================== \n");
  endtask
  
endclass

//================================================================================================================================================================

class WA_WD_R_wstrb_vsequence extends vseq;
  `uvm_object_utils(WA_WD_R_wstrb_vsequence)
 
  WA_WD_wstrb_sequence s1;
  R_with_past_addr_Sequence s2;

  function new(string name = "WA_WD_R_wstrb_vsequence");
    super.new(name);
  endfunction
  
  task body;
    super.body();
    
    s1 = WA_WD_wstrb_sequence      :: type_id :: create("s1");
    s2 = R_with_past_addr_Sequence :: type_id :: create("s2");
    
    $display("\n ============================== Write Address First and Write Data with WSTRB next and the Read Sequence ====================================== \n");
    repeat(`txns) begin
      s1.start(vseqr.w_sqr);  // RUNS ONCE
      s2.past_addr = s1.past_addr;
      s2.start(vseqr.r_sqr); // RUNS ONCE
    end
    $display("\n ==============================================  END Of WA WD with WSTRB R Sequence =========================================================== \n");
  endtask
  
endclass

//================================================================================================================================================================

class WA_WD_R_wstrb_directed_vsequence extends vseq;
  `uvm_object_utils(WA_WD_R_wstrb_directed_vsequence)
 
  WA_WD_directed_address_wstrb_sequence s1;
  R_directed_address_Sequence s2;

  function new(string name = "WA_WD_R_wstrb_directed_vsequence");
    super.new(name);
  endfunction
  
  task body;
    super.body();
    
    s1 = WA_WD_directed_address_wstrb_sequence :: type_id :: create("s1");
    s2 = R_directed_address_Sequence           :: type_id :: create("s2");
    
    $display("\n ============================== Write Address First and Write Data with WSTRB next and the Read Sequence on address 4'd12 ====================================== \n");
    s1.past_addr = 0;
    s2.past_addr = 0;
    
    repeat(`txns) begin
      s1.start(vseqr.w_sqr);  // RUNS ONCE
      s2.start(vseqr.r_sqr); // RUNS ONCE
    end
    `uvm_info(get_type_name, "Addr = 'h14", UVM_MEDIUM)
    s1.past_addr = 20;
    s2.past_addr = 20;
    
    repeat(`txns) begin
      s1.start(vseqr.w_sqr);  // RUNS ONCE
      s2.start(vseqr.r_sqr); // RUNS ONCE
    end
    
    `uvm_info(get_type_name, "Addr = 'h3c", UVM_MEDIUM)
    s1.past_addr = 60;
    s2.past_addr = 60;
    
    repeat(`txns) begin
      s1.start(vseqr.w_sqr);  // RUNS ONCE
      s2.start(vseqr.r_sqr); // RUNS ONCE
    end
    
    $display("\n ==============================================  END Of WA WD with WSTRB R Sequence =========================================================== \n");
  endtask
  
endclass

//================================================================================================================================================================

class WAD_R_wstrb_vsequence extends vseq;
  `uvm_object_utils(WAD_R_wstrb_vsequence)
 
  WA_WD_wstrb_sequence s1;
  R_Sequence s2;

  function new(string name = "WAD_R_wstrb_vsequence");
    super.new(name);
  endfunction
  
  task body;
    super.body();
    
    s1 = WA_WD_wstrb_sequence :: type_id :: create("s1");
    s2 = R_Sequence           :: type_id :: create("s2");
    
    $display("\n============================== Write Address and Write Data with WSTRB sent at same time and the Read Sequence ====================================== \n");
    
    repeat(`txns) fork
      s1.start(vseqr.w_sqr);  // RUNS ONCE
      s2.start(vseqr.r_sqr); // RUNS ONCE
    join
    
    $display("\n ==============================================  END Of WAD with WSTRB R Sequence =========================================================== \n");
  endtask
  
endclass

//=================================================================================================================================================================================

class R_WA_WD_vsequence extends vseq;
  `uvm_object_utils(R_WA_WD_vsequence)
 
  WA_WD_sequence s1;
  R_Sequence s2;

  function new(string name = "WA_WD_parallel_R_vsequence");
    super.new(name);
  endfunction
  
  task body;
    super.body();
    
    s1 = WA_WD_sequence :: type_id :: create("s1");
    s2 = R_Sequence     :: type_id :: create("s2");
    
    $display("\n============================== Read Sequence and the Write Address and Write Data sent ====================================== \n");
    
    repeat(`txns) begin
      s2.start(vseqr.r_sqr);
      s1.start(vseqr.w_sqr);  // RUNS ONCE
    end
    
    $display("\n ==============================================  END Of R WAD Sequence =========================================================== \n");
  endtask
  
endclass

//============================================================================================================================================================

class R_WA_WD_same_addr_vsequence extends vseq;
  `uvm_object_utils(R_WA_WD_same_addr_vsequence)
 
  R_past_addr_str_Sequence s1;
  WD_WA_with_past_addr_sequence s2;
  R_with_past_addr_Sequence s3;

  function new(string name = "R_WA_WD_same_addr_vsequence");
    super.new(name);
  endfunction
  
  task body;
    super.body();
    
    s1 = R_past_addr_str_Sequence      :: type_id :: create("s1");
    s2 = WD_WA_with_past_addr_sequence :: type_id :: create("s2");
    s3 = R_with_past_addr_Sequence     :: type_id :: create("s3");
    
    $display("\n============================== Read Sequence andd Written into same address and again read through same address ====================================== \n");
    
    repeat(`txns) begin
      s1.start(vseqr.r_sqr);
      s2.past_addr = s1.past_addr;
      s3.past_addr = s1.past_addr;
      s2.start(vseqr.w_sqr);
      s3.start(vseqr.r_sqr); 
    end
    
    $display("\n ==============================================  END Of R WAD R Sequence =========================================================== \n");
  endtask
  
endclass

//=======================================================================================================================================
class WA_WD_R_drive_bready_and_rready_after_4_clk_cycle_vsequences extends vseq;
  `uvm_object_utils(WA_WD_R_drive_bready_and_rready_after_4_clk_cycle_vsequences)
  
  WA_WD_drive_bready_after_4_clk_cycle_sequences s1;
  R_drive_rready_after_4_clk_cycle_sequences s2;

  function new(string name = "WA_WD_R_drive_bready_and_rready_after_4_clk_cycle_vsequences");
    super.new(name);
  endfunction
  
  task body;
    super.body();
    
    s1 = WA_WD_drive_bready_after_4_clk_cycle_sequences :: type_id :: create("s1");
    s2 = R_drive_rready_after_4_clk_cycle_sequences     :: type_id :: create("s2");
    
    $display("\n===================================================== Drive bready and rready after 4 clk cycle ================================================================= \n");
    
    repeat(`txns) begin
      s1.start(vseqr.w_sqr);  // RUNS ONCE
      s2.start(vseqr.r_sqr); // RUNS ONCE
    end
    
    $display("\n ================================================ END Of Drive bready and rready after 4 clk cycle ============================================================= \n");
    
  endtask
endclass

//==============================================================================================================================================================================

class WA_WD_R_drive_bready_and_rready_always_high_vsequences extends vseq;
  `uvm_object_utils(WA_WD_R_drive_bready_and_rready_always_high_vsequences)
  
  R_drive_rready_always_high_sequences s1;
  WA_WD_drive_bready_always_high_sequences s2;

  function new(string name = "WA_WD_R_drive_bready_and_rready_always_high_vsequences");
    super.new(name);
  endfunction
  
  task body;
    super.body();
    
    s1 = R_drive_rready_always_high_sequences     :: type_id :: create("s1");
    s2 = WA_WD_drive_bready_always_high_sequences :: type_id :: create("s2");
    
    $display("\n===================================================== Drive bready and rready always high ================================================================= \n");
    
    repeat(`txns) fork
      s2.start(vseqr.w_sqr);  // RUNS ONCE
      s1.start(vseqr.r_sqr); // RUNS ONCE
    join
    
    $display("\n ================================================ END Of Drive bready and rready always high ============================================================= \n");
    
  endtask
endclass

//==============================================================================================================================================================================

class WD_WA_R_drive_bready_and_rready_always_high_vsequences extends vseq;
  `uvm_object_utils(WD_WA_R_drive_bready_and_rready_always_high_vsequences)
  
  R_drive_rready_always_high_sequences s1;
  WD_WA_drive_bready_always_high_sequences s2;

  function new(string name = "WD_WA_R_drive_bready_and_rready_always_high_vsequences");
    super.new(name);
  endfunction
  
  task body;
    super.body();
    
    s1 = R_drive_rready_always_high_sequences     :: type_id :: create("s1");
    s2 = WD_WA_drive_bready_always_high_sequences :: type_id :: create("s2");
    
    $display("\n===================================================== Drive bready and rready always high ================================================================= \n");
    
    repeat(`txns) fork
      s2.start(vseqr.w_sqr);  // RUNS ONCE
      s1.start(vseqr.r_sqr); // RUNS ONCE
    join
    
    $display("\n ================================================ END Of Drive bready and rready always high ============================================================= \n");
    
  endtask
endclass

//=========================================================================================================================================================================================

class WA_WD_R_drive_without_waiting_for_ready_vsequences extends vseq;
  `uvm_object_utils(WA_WD_R_drive_without_waiting_for_ready_vsequences)
  
  WA_WD_drive_without_waiting_for_ready_sequences s1;
  R_drive_without_waiting_for_ready_sequences s2;

  function new(string name = "WA_WD_R_drive_without_waiting_for_ready_vsequences");
    super.new(name);
  endfunction
  
  task body;
    super.body();
    
    s1 = WA_WD_drive_without_waiting_for_ready_sequences :: type_id :: create("s1");
    s2 = R_drive_without_waiting_for_ready_sequences     :: type_id :: create("s2");
    
    $display("\n============================== Write Address and Write Data and the Read Sequence driven without ready ====================================== \n");
    
    repeat(`txns) begin
      s1.start(vseqr.w_sqr);  // RUNS ONCE
      s2.start(vseqr.r_sqr); // RUNS ONCE
    end
    
    $display("\n ==============================================  END Of Write Address and Write Data and the Read Sequence driven without ready =========================================================== \n");
  endtask
endclass

class WA_WD_R_drive_without_waiting_for_ready_parallel_vsequences extends vseq;
  `uvm_object_utils(WA_WD_R_drive_without_waiting_for_ready_parallel_vsequences)
  WA_WD_drive_without_waiting_for_ready_sequences s1;
  R_drive_without_waiting_for_ready_sequences s2;

  function new(string name = "WA_WD_R_drive_without_waiting_for_ready_parallel_vsequences");
    super.new(name);
  endfunction
  
  task body;
    super.body();
    
    s1 = WA_WD_drive_without_waiting_for_ready_sequences :: type_id :: create("s1");
    s2 = R_drive_without_waiting_for_ready_sequences     :: type_id :: create("s2");
    
    $display("\n====================================== Write Address and Write Data and the Read Sequence driven without ready parallely ====================================== \n");
    
    repeat(`txns) fork
      s1.start(vseqr.w_sqr);  // RUNS ONCE
      s2.start(vseqr.r_sqr); // RUNS ONCE
    join
    
    $display("\n ==================================== END Of Write Address and Write Data and the Read Sequence driven without ready parallely =================================================== \n");
  endtask
endclass

//=============================================================================== ERROR SEQUENCESS ================================================================================

class WA_WD_R_OF_bound_address_unaligned_vsequences extends vseq;
  `uvm_object_utils(WA_WD_R_OF_bound_address_unaligned_vsequences)
 
  WA_WD_OF_bound_address_unaligned_sequences s1;
  R_OF_bound_address_unaligned_sequences s2;

  function new(string name = "WA_WD_R_OF_bound_address_unaligned_vsequences");
    super.new(name);
  endfunction
  
  task body;
    super.body();
    
    s1 = WA_WD_OF_bound_address_unaligned_sequences :: type_id :: create("s1");
    s2 = R_OF_bound_address_unaligned_sequences     :: type_id :: create("s2");
    
    $display("\n ============================== Write Address First and Write Data next OF_bound_address_unaligned_sequences ====================================== \n");
    repeat(`txns) fork
      s1.start(vseqr.w_sqr);  // RUNS ONCE
      s2.start(vseqr.r_sqr); // RUNS ONCE
    join
    $display("\n =========================== END Of Write Address First and Write Data next OF_bound_address_unaligned_sequences ================================== \n");
  
  endtask
  
endclass

//=================================================================================================================================================================

class WD_WA_R_OF_bound_address_unaligned_vsequences extends vseq;
  `uvm_object_utils(WD_WA_R_OF_bound_address_unaligned_vsequences)
  
  WD_WA_OF_bound_address_unaligned_sequences s1;
  R_OF_bound_address_unaligned_sequences s2;
  
  function new(string name = "WD_WA_R_OF_bound_address_unaligned_vsequences");
    super.new(name);
  endfunction
  
  task body();
    super.body();
    
    s1 = WD_WA_OF_bound_address_unaligned_sequences :: type_id :: create("s1");
    s2 = R_OF_bound_address_unaligned_sequences     :: type_id :: create("s2");
    
    $display("\n ============================== Write Data First and Write Address next OF_bound_address_unaligned_sequences ====================================== \n");
    repeat(`txns) fork
      s1.start(vseqr.w_sqr);  // RUNS ONCE
      s2.start(vseqr.r_sqr); // RUNS ONCE
    join
    $display("\n =========================== END Of Write Address First and Write Data next OF_bound_address_unaligned_sequences ================================== \n");
  
    
  endtask
  
endclass

//=================================================================================================================================================================

class WDA_R_OF_bound_address_unaligned_vsequences extends vseq;
  `uvm_object_utils(WDA_R_OF_bound_address_unaligned_vsequences)
  
  WDA_OF_bound_address_unaligned_sequences s1;
  R_OF_bound_address_unaligned_sequences s2;
  
  function new(string name = "WDA_R_OF_bound_address_unaligned_vsequences");
    super.new(name);
  endfunction
  
  task body();
    super.body();
    
    s1 = WDA_OF_bound_address_unaligned_sequences :: type_id :: create("s1");
    s2 = R_OF_bound_address_unaligned_sequences   :: type_id :: create("s2");
    
    $display("\n ============================== Write Data and Write Address Out of bound address unaligned sequences ====================================== \n");
    repeat(`txns) fork
      s1.start(vseqr.w_sqr);  // RUNS ONCE
      s2.start(vseqr.r_sqr); // RUNS ONCE
    join
    $display("\n =========================== END Of Write Data and Write Address Out of bound address unaligned sequences ================================== \n");
    
  endtask
  
endclass

//=================================================================================================================================================================

class WA_WD_R_address_unaligned_vsequences extends vseq;
  `uvm_object_utils(WA_WD_R_address_unaligned_vsequences)
 
  WA_WD_address_unaligned_sequences s1;
  R_address_unaligned_sequences s2;

  function new(string name = "WA_WD_R_address_unaligned_vsequences");
    super.new(name);
  endfunction
  
  task body;
    super.body();
    
    s1 = WA_WD_address_unaligned_sequences :: type_id :: create("s1");
    s2 = R_address_unaligned_sequences     :: type_id :: create("s2");
    
    $display("\n ============================== Write Address First and Write Data next address unaligned sequences ====================================== \n");
    repeat(`txns) fork
      s1.start(vseqr.w_sqr);  // RUNS ONCE
      s2.start(vseqr.r_sqr); // RUNS ONCE
    join
    $display("\n ==========================  END Of Write Address First and Write Data next address unaligned sequences ================================== \n");
  
  endtask
  
endclass

//=================================================================================================================================================================

class WD_WA_R_address_unaligned_vsequences extends vseq;
  `uvm_object_utils(WD_WA_R_address_unaligned_vsequences)
  
  WD_WA_address_unaligned_sequences s1;
  R_address_unaligned_sequences s2;
  
  function new(string name = "WD_WA_R_address_unaligned_vsequences");
    super.new(name);
  endfunction
  
  task body();
    super.body();
    
    s1 = WD_WA_address_unaligned_sequences :: type_id :: create("s1");
    s2 = R_address_unaligned_sequences     :: type_id :: create("s2");
    
    $display("\n ============================== Write Data First and Write Address next address unaligned sequences ====================================== \n");
    repeat(`txns) fork
      s1.start(vseqr.w_sqr);  // RUNS ONCE
      s2.start(vseqr.r_sqr); // RUNS ONCE
    join
    $display("\n ==========================  END Of Write Data First and Write Address next address unaligned sequences ================================== \n");
    
  endtask
  
endclass

//=================================================================================================================================================================

class WDA_R_address_unaligned_vsequences extends vseq;
  `uvm_object_utils(WDA_R_address_unaligned_vsequences)
  
  WDA_address_unaligned_sequences s1;
  R_address_unaligned_sequences s2;
  
  function new(string name = "WDA_R_address_unaligned_vsequences");
    super.new(name);
  endfunction
  
  task body();
    super.body();
    
    s1 = WDA_address_unaligned_sequences :: type_id :: create("s1");
    s2 = R_address_unaligned_sequences   :: type_id :: create("s2");
    
    $display("\n ============================== Write Data and Write Address with address unaligned sequences ====================================== \n");
    repeat(`txns) fork
      s1.start(vseqr.w_sqr);  // RUNS ONCE
      s2.start(vseqr.r_sqr); // RUNS ONCE
    join
    $display("\n ==========================  END Of Write Data and Write Address with address unaligned sequences ================================== \n");
    
  endtask
  
endclass

//=================================================================================================================================================================

class WA_WD_OF_bound_address_vsequences extends vseq;
  `uvm_object_utils(WA_WD_OF_bound_address_vsequences)
 
  WA_WD_OF_bound_address_sequences s1;
  R_OF_bound_address_sequences s2;

  function new(string name = "WA_WD_OF_bound_address_vsequences");
    super.new(name);
  endfunction
  
  task body;
    super.body();
    
    s1 = WA_WD_OF_bound_address_sequences :: type_id :: create("s1");
    s2 = R_OF_bound_address_sequences     :: type_id :: create("s2");
    
    $display("\n ============================== Write Address First and Write Data next Out of bound address sequences ====================================== \n");
    repeat(`txns) fork
      s1.start(vseqr.w_sqr);  // RUNS ONCE
      s2.start(vseqr.r_sqr); // RUNS ONCE
    join
    $display("\n ==========================  END Of Write Address First and Write Data next Out of bound address sequences ================================== \n");
  
  endtask
  
endclass

class WA_WD_OF_bound_address_directed_vsequences extends vseq;
  `uvm_object_utils(WA_WD_OF_bound_address_directed_vsequences)
 
  WA_WD_OF_bound_address_directed_sequences s1;

  function new(string name = "WA_WD_OF_bound_address_directed_vsequences");
    super.new(name);
  endfunction
  
  task body;
    super.body();
    
    s1 = WA_WD_OF_bound_address_directed_sequences :: type_id :: create("s1");
    
    $display("\n ============================== Write Address First and Write Data next Out of bound address Directed sequences ====================================== \n");
    s1.past_addr = 4000;
    
    repeat(`txns) begin
      s1.start(vseqr.w_sqr);
    end
    `uvm_info(get_type_name, "Addr = 1000", UVM_MEDIUM)
    
    s1.past_addr = 1000;
    
    repeat(`txns) begin
      s1.start(vseqr.w_sqr);
    end
    
    s1.past_addr = 64;
    
    `uvm_info(get_type_name, "Addr = 64", UVM_MEDIUM)
    
    repeat(`txns) begin
      s1.start(vseqr.w_sqr);
    end
    
    s1.past_addr = 32'hFFFFFF;
    
    `uvm_info(get_type_name, "Addr = FFFFFF", UVM_MEDIUM)
    
    repeat(`txns) begin
      s1.start(vseqr.w_sqr);
    end
    $display("\n ==========================  END Of Write Address First and Write Data next Out of bound address Directed sequences ================================== \n");
  
  endtask
  
endclass

//=================================================================================================================================================================

class WD_WA_OF_bound_address_vsequences extends vseq;
  `uvm_object_utils(WD_WA_OF_bound_address_vsequences)
  
  WD_WA_OF_bound_address_sequences s1;
  R_OF_bound_address_sequences s2;
  
  function new(string name = "WD_WA_OF_bound_address_vsequences");
    super.new(name);
  endfunction
  
  task body();
    super.body();
    
    s1 = WD_WA_OF_bound_address_sequences :: type_id :: create("s1");
    s2 = R_OF_bound_address_sequences     :: type_id :: create("s2");
    
    $display("\n ============================== Write Data First and Write Address next Out of bound address sequences ====================================== \n");
    repeat(`txns) fork
      s1.start(vseqr.w_sqr);  // RUNS ONCE
      s2.start(vseqr.r_sqr); // RUNS ONCE
    join
    $display("\n ==========================  END Of Write Data First and Write Address next Out of bound address sequences ================================== \n");
  endtask
  
endclass

//=================================================================================================================================================================

class WDA_OF_bound_address_vsequences extends vseq;
  `uvm_object_utils(WDA_OF_bound_address_vsequences)
  
  WDA_OF_bound_address_sequences s1;
  R_OF_bound_address_sequences s2;
  
  function new(string name = "WDA_OF_bound_address_vsequences");
    super.new(name);
  endfunction
  
  task body();
    super.body();
    
    s1 = WDA_OF_bound_address_sequences :: type_id :: create("s1");
    s2 = R_OF_bound_address_sequences   :: type_id :: create("s2");
    
    $display("\n ============================== Write Data and Write Address Out of bound address sequences ====================================== \n");
    repeat(`txns) fork
      s1.start(vseqr.w_sqr);  // RUNS ONCE
      s2.start(vseqr.r_sqr); // RUNS ONCE
    join
    $display("\n ==========================  END Of Write Data and Write Address Out of bound address sequences ================================== \n");
    
  endtask
  
endclass

//=================================================================================================================================================================

class WD_WA_in_read_only_vsequences extends vseq;
  `uvm_object_utils(WD_WA_in_read_only_vsequences)
  
  WD_WA_in_read_only_sequences s1;
  
  function new(string name = "WD_WA_in_read_only_vsequences");
    super.new(name);
  endfunction
  
  task body();
    super.body();
    
    s1 = WD_WA_in_read_only_sequences :: type_id :: create("s1");
    
    $display("\n ============================== Write Data first and Write Address next in read only sequences ====================================== \n");
    repeat(`txns) begin
      s1.start(vseqr.w_sqr);  // RUNS ONCE
    end
    $display("\n ==========================  END Of Write Data first and Write Address next in read only sequences ================================== \n");
    
  endtask
  
endclass

//=================================================================================================================================================================

class WA_WD_in_read_only_vsequences extends vseq;
  `uvm_object_utils(WA_WD_in_read_only_vsequences)
  
  WA_WD_in_read_only_sequences s1;
  
  function new(string name = "WA_WD_in_read_only_vsequences");
    super.new(name);
  endfunction
  
  task body();
    super.body();
    
    s1 = WA_WD_in_read_only_sequences :: type_id :: create("s1");
    
    $display("\n ============================== Write Address first and Write Data next in read only sequences ====================================== \n");
    repeat(`txns) begin
      s1.start(vseqr.w_sqr);  // RUNS ONCE
    end
    $display("\n ==========================  END Of Write Address first and Write Data next in read only sequences ================================== \n");
  
  endtask
  
endclass

//=================================================================================================================================================================

class WDA_in_read_only_vsequences extends vseq;
  `uvm_object_utils(WDA_in_read_only_vsequences)
  
  WDA_in_read_only_sequences s1;
  
  function new(string name = "WDA_in_read_only_vsequences");
    super.new(name);
  endfunction
  
  task body();
    super.body();
    
    s1 = WDA_in_read_only_sequences :: type_id :: create("s1");
    
    $display("\n ============================== Write Data and Write Address in read only sequences ====================================== \n");
    repeat(`txns) begin
      s1.start(vseqr.w_sqr);
    end
    $display("\n ==========================  END Of Write Data and Write Address in read only sequences ================================== \n");
     
  endtask
  
endclass

//=================================================================================================================================================================

class R_in_write_only_vsequences extends vseq;
  `uvm_object_utils(R_in_write_only_vsequences)
  
  R_in_write_only_sequences s1;
  
  function new(string name = "R_in_write_only_vsequences");
    super.new(name);
  endfunction
  
  task body();
    super.body();
    
    s1 = R_in_write_only_sequences :: type_id :: create("s1");
    
    $display("\n ============================== t = %0t Read in write only sequences ====================================== \n", $time);
    
    repeat(`txns) begin
      s1.start(vseqr.r_sqr);
    end
    
    $display("\n ========================== t = %0t END Of Read in write only sequences ================================== \n", $time);
     
  endtask
  
endclass

//=================================================================================================================================================================
