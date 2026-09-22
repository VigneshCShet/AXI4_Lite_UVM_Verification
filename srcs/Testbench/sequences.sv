class dummy_sequence extends uvm_sequence #(trans);
  `uvm_object_utils(dummy_sequence)
    
  function new(string name = "dummy_sequence");
    super.new(name);
  endfunction
  
  task body;
    
      //$display("\n==============================  Dummy Write Sequence   ====================================== \n");
        `uvm_do(req)
   
  endtask
endclass

class WD_WA_sequence extends uvm_sequence #(trans);
  `uvm_object_utils(WD_WA_sequence)
  
  bit [`aw - 1 : 0] past_addr;
  
  function new(string name = "WD_WA_sequence");
    super.new(name);
  endfunction
  
  task body;
    
    `uvm_do_with(req, {wvalid == 1;})
        
    `uvm_do_with(req, {awvalid == 1;})
    past_addr = req.awaddr;
   
  endtask
endclass

//===================================================================================================================

class WD_WA_with_past_addr_sequence extends uvm_sequence #(trans);
  `uvm_object_utils(WD_WA_with_past_addr_sequence)
  
  bit [`aw - 1 : 0] past_addr;
  
  function new(string name = "WD_WA_with_past_addr_sequence");
    super.new(name);
  endfunction
  
  task body;
    
    `uvm_do_with(req, {wvalid == 1;})
        
    `uvm_do_with(req, {awaddr == past_addr; awvalid == 1;})
   
  endtask
endclass

//====================================================================================================================================================================

class WA_WD_sequence extends uvm_sequence #(trans);
  `uvm_object_utils(WA_WD_sequence)
  bit [`aw - 1 : 0] past_addr;
  function new(string name = "WA_WD_sequence");
    super.new(name);
  endfunction
  
  task body;
  
    `uvm_do_with(req, {awvalid == 1;})
    past_addr = req.awaddr;
        
    `uvm_do_with(req, {wvalid == 1;})
        
  endtask
endclass

//=================================================================================================================================================================================

class WAD_sequence extends uvm_sequence #(trans);
  `uvm_object_utils(WAD_sequence)

  function new(string name = "WAD_sequence");
    super.new(name);
  endfunction
  
  task body;
  
    `uvm_do_with(req, {awvalid == 1; wvalid == 1;})
        
  endtask
  
endclass

//=================================================================================================================================================================================

class WD_WA_awprot_sequence extends uvm_sequence #(trans);
  `uvm_object_utils(WD_WA_awprot_sequence)
  
  function new(string name = "WD_WA_awprot_sequence");
    super.new(name);
  endfunction
  
  task body;
    
    `uvm_do_with(req, {wvalid == 1;})
        
    `uvm_do_with(req, {awvalid == 1; awprot != 0;})
   
  endtask
endclass
//=================================================================================================================================================================================

class WD_WA_wstrb_sequence extends uvm_sequence #(trans);
  `uvm_object_utils(WD_WA_wstrb_sequence)
  
  bit [`aw - 1 : 0] past_addr;
  
  function new(string name = "WD_WA_wstrb_sequence");
    super.new(name);
  endfunction
  
  task body;
    
    `uvm_create(req)
    req.rule3.constraint_mode(0);
    `uvm_rand_send_with(req, {wvalid == 1;})
        
    `uvm_do_with(req, {awvalid == 1;})
    past_addr = req.awaddr;
   
  endtask
endclass

//====================================================================================================================================================================

class WA_WD_wstrb_sequence extends uvm_sequence #(trans);
  `uvm_object_utils(WA_WD_wstrb_sequence)
  bit [`aw - 1 : 0] past_addr;
  function new(string name = "WA_WD_wstrb_sequence");
    super.new(name);
  endfunction
  
  task body;

    `uvm_do_with(req, {awvalid == 1;})
    past_addr = req.awaddr;
    
    `uvm_create(req)
    req.rule3.constraint_mode(0);
    `uvm_rand_send_with(req, {wvalid == 1;})
        
  endtask
endclass

//====================================================================================================================================================================

class WA_WD_directed_address_wstrb_sequence extends uvm_sequence #(trans);
  `uvm_object_utils(WA_WD_directed_address_wstrb_sequence)
  bit [`aw - 1 : 0] past_addr;
  function new(string name = "WA_WD_directed_address_wstrb_sequence");
    super.new(name);
  endfunction
  
  task body;

    `uvm_do_with(req, {awvalid == 1; awaddr == past_addr;})
    
    `uvm_create(req)
    req.rule3.constraint_mode(0);
    `uvm_rand_send_with(req, {wvalid == 1;})
        
  endtask
endclass

//====================================================================================================================================================================

class WAD_wstrb_sequence extends uvm_sequence #(trans);
  `uvm_object_utils(WAD_wstrb_sequence)

  function new(string name = "WAD_wstrb_sequence");
    super.new(name);
  endfunction
  
  task body;
    `uvm_create(req)
    req.rule3.constraint_mode(0);
    `uvm_rand_send_with(req, {awvalid == 1; wvalid == 1;})
  endtask
  
endclass

//===============================================================================================================================================================================

class WA_WD_drive_bready_after_4_clk_cycle_sequences extends uvm_sequence #(trans);
  `uvm_object_utils(WA_WD_drive_bready_after_4_clk_cycle_sequences)

  function new(string name = "WA_WD_drive_bready_after_4_clk_cycle_sequences");
    super.new(name);
  endfunction
  
  task body;
    `uvm_do_with(req, {awvalid == 1; dr == 2;})
    `uvm_do_with(req, {wvalid == 1; dr == 2;})
  endtask
  
endclass

//===============================================================================================================================================================================

class WA_WD_drive_bready_always_high_sequences extends uvm_sequence #(trans);
  `uvm_object_utils(WA_WD_drive_bready_always_high_sequences)

  function new(string name = "WA_WD_drive_bready_always_high_sequences");
    super.new(name);
  endfunction
  
  task body;
    `uvm_do_with(req, {awvalid == 1; dr == 3;})
    `uvm_do_with(req, {wvalid == 1; dr == 3;})
  endtask
  
endclass

//===============================================================================================================================================================================

class WD_WA_drive_bready_always_high_sequences extends uvm_sequence #(trans);
  `uvm_object_utils(WD_WA_drive_bready_always_high_sequences)

  function new(string name = "WD_WA_drive_bready_always_high_sequences");
    super.new(name);
  endfunction
  
  task body;
    `uvm_do_with(req, {wvalid == 1; dr == 3;})
    `uvm_do_with(req, {awvalid == 1; dr == 3;})
  endtask
  
endclass

//===============================================================================================================================================================================

class WA_WD_drive_without_waiting_for_ready_sequences extends uvm_sequence #(trans);
  `uvm_object_utils(WA_WD_drive_without_waiting_for_ready_sequences)

  function new(string name = "WA_WD_drive_without_waiting_for_ready_sequences");
    super.new(name);
  endfunction
  
  task body;
    `uvm_do_with(req, {awvalid == 1; dr == 1;})
    `uvm_do_with(req, {wvalid == 1; dr == 1;})
  endtask
  
endclass

//===============================================================================================================================================================================

class WA_WD_each_delayed_3_cycle_sequences extends uvm_sequence #(trans);
  `uvm_object_utils(WA_WD_each_delayed_3_cycle_sequences)

  function new(string name = "WA_WD_each_delayed_3_cycle_sequences");
    super.new(name);
  endfunction
  
  task body;
    `uvm_do_with(req, {awvalid == 1;})
    `uvm_do_with(req, {awvalid == 0;})
    `uvm_do_with(req, {awvalid == 0;})
    `uvm_do_with(req, {awvalid == 0;})
    `uvm_do_with(req, {wvalid == 1;})
  endtask
  
endclass

//===============================================================================================================================================================================

class WD_WA_each_delayed_3_cycle_sequences extends uvm_sequence #(trans);
  `uvm_object_utils(WD_WA_each_delayed_3_cycle_sequences)

  function new(string name = "WD_WA_each_delayed_3_cycle_sequences");
    super.new(name);
  endfunction
  
  task body;
    `uvm_do_with(req, {wvalid == 1;})
    `uvm_do_with(req, {wvalid == 0;})
    `uvm_do_with(req, {wvalid == 0;})
    `uvm_do_with(req, {wvalid == 0;})
    `uvm_do_with(req, {awvalid == 1;})
  endtask
  
endclass

//=============================================================================== ERROR SEQUENCESS ================================================================================

class WA_WD_OF_bound_address_unaligned_sequences extends uvm_sequence #(trans);
  `uvm_object_utils(WA_WD_OF_bound_address_unaligned_sequences)
  
  function new(string name = "WA_WD_OF_bound_address_unaligned_sequences");
    super.new(name);
  endfunction
  
  task body();
 
    `uvm_do_with(req, {awaddr[1:0] != 0; awaddr > 63; awvalid == 1;})
  
    `uvm_do_with(req, {wvalid == 1;})   
    
  endtask
  
endclass

//=================================================================================================================================================================

class WD_WA_OF_bound_address_unaligned_sequences extends uvm_sequence #(trans);
  `uvm_object_utils(WD_WA_OF_bound_address_unaligned_sequences)
  
  function new(string name = "WD_WA_OF_bound_address_unaligned_sequences");
    super.new(name);
  endfunction
  
  task body();
 
    `uvm_do_with(req, {wvalid == 1;})
    
    `uvm_do_with(req, {awaddr[1:0] != 0; awaddr > 63; awvalid == 1;})  

  endtask
  
endclass

//=================================================================================================================================================================

class WDA_OF_bound_address_unaligned_sequences extends uvm_sequence #(trans);
  `uvm_object_utils(WDA_OF_bound_address_unaligned_sequences)
  
  function new(string name = "WDA_OF_bound_address_unaligned_sequences");
    super.new(name);
  endfunction
  
  task body();
    
    `uvm_do_with(req, {awaddr[1:0] != 0; wvalid == 1; awvalid == 1; awaddr > 63;})
    
  endtask
  
endclass

//================================================================================================================================================================

class WA_WD_address_unaligned_sequences extends uvm_sequence #(trans);
  `uvm_object_utils(WA_WD_address_unaligned_sequences)
  
  function new(string name = "WA_WD_address_unaligned_sequences");
    super.new(name);
  endfunction
  
  task body();
 
    `uvm_do_with(req, {awaddr[1:0] != 0; awvalid == 1;})
  
    `uvm_do_with(req, {wvalid == 1;})   
    
  endtask
  
endclass

//================================================================================================================================================================

class WD_WA_address_unaligned_sequences extends uvm_sequence #(trans);
  `uvm_object_utils(WD_WA_address_unaligned_sequences)
  
  function new(string name = "WD_WA_address_unaligned_sequences");
    super.new(name);
  endfunction
  
  task body();
 
    `uvm_do_with(req, {wvalid == 1;})
    
    `uvm_do_with(req, {awaddr[1:0] != 0; awvalid == 1;})  

  endtask
  
endclass

//================================================================================================================================================================

class WDA_address_unaligned_sequences extends uvm_sequence #(trans);
  `uvm_object_utils(WDA_address_unaligned_sequences)
  
  function new(string name = "WDA_address_unaligned_sequences");
    super.new(name);
  endfunction
  
  task body();
    
    `uvm_do_with(req, {awaddr[1:0] != 0; wvalid == 1; awvalid == 1;})
    
  endtask
  
endclass

//===============================================================================================================================================================

class WA_WD_OF_bound_address_sequences extends uvm_sequence #(trans);
  `uvm_object_utils(WA_WD_OF_bound_address_sequences)
  
  function new(string name = "WA_WD_OF_bound_address_sequences");
    super.new(name);
  endfunction
  
  task body();
 
    `uvm_do_with(req, {awaddr > 63; awvalid == 1;})
  
    `uvm_do_with(req, {wvalid == 1;})   
    
  endtask
  
endclass

//=================================================================================================================================================================

class WA_WD_OF_bound_address_directed_sequences extends uvm_sequence #(trans);
  `uvm_object_utils(WA_WD_OF_bound_address_directed_sequences)
  
  bit [`aw - 1 : 0] past_addr;
  
  function new(string name = "WA_WD_OF_bound_address_directed_sequences");
    super.new(name);
  endfunction
  
  task body();
 
    `uvm_do_with(req, {awaddr == past_addr; awvalid == 1;})
  
    `uvm_do_with(req, {wvalid == 1;})   
    
  endtask
  
endclass

//=================================================================================================================================================================

class WD_WA_OF_bound_address_sequences extends uvm_sequence #(trans);
  `uvm_object_utils(WD_WA_OF_bound_address_sequences)
  
  function new(string name = "WD_WA_OF_bound_address_sequences");
    super.new(name);
  endfunction
  
  task body();
 
    `uvm_do_with(req, {wvalid == 1;})
    
    `uvm_do_with(req, {awaddr > 63; awvalid == 1;})  

  endtask
  
endclass

//=================================================================================================================================================================

class WDA_OF_bound_address_sequences extends uvm_sequence #(trans);
  `uvm_object_utils(WDA_OF_bound_address_sequences)
  
  function new(string name = "WDA_OF_bound_address_sequences");
    super.new(name);
  endfunction
  
  task body();
    
    `uvm_do_with(req, {wvalid == 1; awvalid == 1; awaddr > 63;})
    
  endtask
  
endclass

//=================================================================================================================================================================

class WA_WD_in_read_only_sequences extends uvm_sequence #(trans);
  `uvm_object_utils(WA_WD_in_read_only_sequences)
  
  function new(string name = "WA_WD_in_read_only_sequences");
    super.new(name);
  endfunction
  
  task body();
  
    `uvm_create(req)
    req.rule9.constraint_mode(0);
    req.rule2.constraint_mode(0);
    `uvm_rand_send_with(req, {awaddr inside {[40:48]}; awvalid == 1;})
  
    `uvm_do_with(req, {wvalid == 1;})   
    
  endtask
  
endclass

//=================================================================================================================================================================

class WD_WA_in_read_only_sequences extends uvm_sequence #(trans);
  `uvm_object_utils(WD_WA_in_read_only_sequences)
  
  function new(string name = "WD_WA_in_read_only_sequences");
    super.new(name);
  endfunction
  
  task body();
 
    `uvm_do_with(req, {wvalid == 1;})
    
    `uvm_create(req)
    req.rule9.constraint_mode(0);
    req.rule2.constraint_mode(0);
    `uvm_rand_send_with(req, {awaddr inside {[40:48]}; awvalid == 1;})

  endtask
  
endclass

//=================================================================================================================================================================

class WDA_in_read_only_sequences extends uvm_sequence #(trans);
  `uvm_object_utils(WDA_in_read_only_sequences)
  
  function new(string name = "WDA_in_read_only_sequences");
    super.new(name);
  endfunction
  
  task body();
    
    `uvm_create(req)
    req.rule9.constraint_mode(0);
    req.rule2.constraint_mode(0);
    `uvm_rand_send_with(req, {awaddr inside {[40:48]}; awvalid == 1; wvalid == 1;})
    
  endtask
  
endclass

//=================================================================================================================================================================
