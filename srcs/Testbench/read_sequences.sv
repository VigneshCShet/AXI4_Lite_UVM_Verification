class R_with_past_addr_Sequence extends uvm_sequence #(trans);
  `uvm_object_utils(R_with_past_addr_Sequence)
  bit [`aw - 1 : 0] past_addr;
  function new(string name = "R_with_past_addr_Sequence");
    super.new(name);
  endfunction 
  
  task body;
       
    `uvm_do_with(req, {araddr == past_addr; arvalid == 1;}) 
        
  endtask
  
endclass

//==========================================================================================================================================

class R_past_addr_str_Sequence extends uvm_sequence #(trans);
  `uvm_object_utils(R_past_addr_str_Sequence)
  
  bit [`aw - 1 : 0] past_addr;
  
  function new(string name = "R_past_addr_str_Sequence");
    super.new(name);
  endfunction 
  
  task body;
       
    `uvm_do_with(req, {arvalid == 1;}) 
    past_addr = req.araddr;    
  endtask
  
endclass

//====================================================================================================================================================================

class R_drive_without_waiting_for_ready_sequences extends uvm_sequence #(trans);
  `uvm_object_utils(R_drive_without_waiting_for_ready_sequences)

  function new(string name = "R_drive_without_waiting_for_ready_sequences");
    super.new(name);
  endfunction
  
  task body;
    `uvm_do_with(req, {arvalid == 1; dr == 1;})
  endtask
  
endclass


//====================================================================================================================================================================

class R_Sequence extends uvm_sequence #(trans);
  `uvm_object_utils(R_Sequence)

  function new(string name = "R_Sequence");
    super.new(name);
  endfunction 
  
  task body;
       
    `uvm_do_with(req, {arvalid == 1;}) 
        
  endtask
  
endclass

//====================================================================================================================================================================

class R_directed_address_Sequence extends uvm_sequence #(trans);
  `uvm_object_utils(R_directed_address_Sequence)
  
  bit [`aw - 1 : 0] past_addr;
  
  function new(string name = "R_directed_address_Sequence");
    super.new(name);
  endfunction 
  
  task body;
    
    `uvm_do_with(req, {arvalid == 1; araddr == past_addr;}) 
        
  endtask
  
endclass

//====================================================================================================================================================================

class R_arprot_Sequence extends uvm_sequence #(trans);
  `uvm_object_utils(R_arprot_Sequence)

  function new(string name = "R_arprot_Sequence");
    super.new(name);
  endfunction 
  
  task body;
       
    `uvm_do_with(req, {arvalid == 1; arprot != 0;}) 
        
  endtask
  
endclass

//====================================================================================================================================================================

class R_drive_rready_after_4_clk_cycle_sequences extends uvm_sequence #(trans);
  `uvm_object_utils(R_drive_rready_after_4_clk_cycle_sequences)

  function new(string name = "R_drive_rready_after_4_clk_cycle_sequences");
    super.new(name);
  endfunction
  
  task body;
    `uvm_do_with(req, {arvalid == 1; dr == 2;})
  endtask
  
endclass

//====================================================================================================================================================================

class R_drive_rready_always_high_sequences extends uvm_sequence #(trans);
  `uvm_object_utils(R_drive_rready_always_high_sequences)

  function new(string name = "R_drive_rready_always_high_sequences");
    super.new(name);
  endfunction
  
  task body;
    `uvm_do_with(req, {arvalid == 1; dr == 3;})
  endtask
  
endclass

//=============================================================================== ERROR SEQUENCESS ================================================================================

class R_OF_bound_address_unaligned_sequences extends uvm_sequence #(trans);
  `uvm_object_utils(R_OF_bound_address_unaligned_sequences)
  
  function new(string name = "R_OF_bound_address_unaligned_sequences");
    super.new(name);
  endfunction
  
  task body();
 
    `uvm_do_with(req, {araddr[1:0] != 0; araddr > 63; arvalid == 1;})
      
  endtask
  
endclass

//================================================================================================================================================================

class R_address_unaligned_sequences extends uvm_sequence #(trans);
  `uvm_object_utils(R_address_unaligned_sequences)
  
  function new(string name = "R_address_unaligned_sequences");
    super.new(name);
  endfunction
  
  task body();
 
    `uvm_do_with(req, {araddr[1:0] != 0; arvalid == 1;})

  endtask
  
endclass

//================================================================================================================================================================

class R_OF_bound_address_sequences extends uvm_sequence #(trans);
  `uvm_object_utils(R_OF_bound_address_sequences)
  
  function new(string name = "R_OF_bound_address_sequences");
    super.new(name);
  endfunction
  
  task body();
 
    `uvm_do_with(req, {araddr > 63; arvalid == 1;})
      
  endtask
  
endclass

//=================================================================================================================================================================

class R_in_write_only_sequences extends uvm_sequence #(trans);
  `uvm_object_utils(R_in_write_only_sequences)
  
  function new(string name = "R_in_write_only_sequences");
    super.new(name);
  endfunction
  
  task body();
    
    `uvm_create(req)
    req.rule9.constraint_mode(0);
    req.rule1.constraint_mode(0);
    `uvm_info(get_type_name, "Sending Sequences", UVM_MEDIUM)
    `uvm_rand_send_with(req, {araddr inside {[52:56]}; arvalid == 1;})
    
  endtask
  
endclass

//=================================================================================================================================================================
