class corner_sequence extends uvm_sequence #(trans);
  `uvm_object_utils(corner_sequence)
  
  function new(string name = "corner_sequence");
    super.new(name);
  endfunction
  
  task body();
    $display("\n\n ======================================================= START OF SEQUENCE corner_sequence ================================================================\n\n");
    `uvm_info(get_type_name(),"Addition", UVM_NONE)
    for(int i = 0; i <= 5; i++) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 0; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
    end
    $display("\n =========================END OPERATION =========================\n");
    
    `uvm_info(get_type_name(),"AND", UVM_NONE)
    for(int i = 0; i <= 5; i++) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 0; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0;})
    end
    $display("\n =========================END OPERATION =========================\n");
    
    `uvm_info(get_type_name(),"DEC_A_wrap", UVM_NONE)
    for(int i = 0; i <= 5; i++) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 5; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0; opa == 0;})
    end
    $display("\n =========================END OPERATION =========================\n");
    
    `uvm_info(get_type_name(),"MUL_INC_CMD_CHANGE_MUL_SHIFT", UVM_NONE)
    
    req = trans :: type_id :: create("req");
    `uvm_do_with(req, {cmd == 9; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
    
    req = trans :: type_id :: create("req");
    `uvm_do_with(req, {cmd == 10; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
    
    for(int i = 0; i <= 2; i++) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 10; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
    end
    $display("\n =========================END OPERATION =========================\n");
    
    
    `uvm_info(get_type_name(),"MUL_INC_CMD_CHANGE_MUL_SHIFT", UVM_NONE)
    
    req = trans :: type_id :: create("req");
    `uvm_do_with(req, {cmd == 10; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
    
    req = trans :: type_id :: create("req");
    `uvm_do_with(req, {cmd == 9; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
    
    for(int i = 0; i <= 2; i++) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 9; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
    end
    $display("\n =========================END OPERATION =========================\n");
    
    
    `uvm_info(get_type_name(),"MUL_INC_INPS_AFTER_CMD_CHANGE", UVM_NONE)
    req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 9; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 10; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      
      repeat(5) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 10; inp_valid == 2'b00; ce == 1; mode == 1; cin == 0;})
      end
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 10; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      $display("\n =========================END OPERATION =========================\n");
      
      
      `uvm_info(get_type_name(),"MUL_INC_INPS_AFTER_CMD_CHANGE", UVM_NONE)
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 9; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 9; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      
      repeat(5) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 10; inp_valid == 2'b00; ce == 1; mode == 1; cin == 0;})
      end
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 10; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 10; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      $display("\n =========================END OPERATION =========================\n");
      
      `uvm_info(get_type_name(),"MUL_SHIFT_INPS_AFTER_CMD_CHANGE", UVM_NONE)
    req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 10; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 9; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      
      repeat(5) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 9; inp_valid == 2'b00; ce == 1; mode == 1; cin == 0;})
      end
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 9; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      $display("\n =========================END OPERATION =========================\n");
      
      
      `uvm_info(get_type_name(),"MUL_SHIFT_INPS_AFTER_CMD_CHANGE", UVM_NONE)
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 10; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 10; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      repeat(5) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 9; inp_valid == 2'b00; ce == 1; mode == 1; cin == 0;})
      end
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 9; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 9; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      $display("\n =========================END OPERATION =========================\n");
      
      `uvm_info(get_type_name(),"MUL_INC_INPS_AFTER_CMD_CHANGE", UVM_NONE)
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 9; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 9; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      repeat(5) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 10; inp_valid == 2'b00; ce == 1; mode == 1; cin == 0;})
      end
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 10; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 10; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      $display("\n =========================END OPERATION =========================\n");
      
      `uvm_info(get_type_name(),"MUL_SHIFT_INPS_AFTER_CMD_CHANGE", UVM_NONE)
    req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 10; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 9; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      repeat(5) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 9; inp_valid == 2'b00; ce == 1; mode == 1; cin == 0;})
      end
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 9; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      $display("\n =========================END OPERATION =========================\n");
      
      
      `uvm_info(get_type_name(),"MUL_SHIFT_INPS_AFTER_CMD_CHANGE", UVM_NONE)
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 10; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 10; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      
      repeat(5) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 9; inp_valid == 2'b00; ce == 1; mode == 1; cin == 0;})
      end
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 9; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 9; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      $display("\n =========================END OPERATION =========================\n");
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 0; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
      end
      
      `uvm_info(get_type_name(),"MUL_INC_INPS_AFTER_MODE_CHANGE", UVM_NONE)
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 9; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 9; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      
      repeat(5) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 10; inp_valid == 2'b00; ce == 1; mode == 1; cin == 0;})
      end
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 10; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 10; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      $display("\n =========================END OPERATION =========================\n");
    $display("\n\n ========================================================================= END OF SEQUENCE ====================================================================== \n\n");
    
    #50;
  endtask
  
endclass
