class alu_sequence_arith extends uvm_sequence #(trans);
  `uvm_object_utils(alu_sequence_arith)
  
  function new(string name = "alu_sequence_arith");
    super.new(name);
  endfunction
  
  task body();
    $display("\n\n ======================================================= START OF SEQUENCE alu_sequence_arith ===================================================================\n\n");
    `uvm_info(get_type_name(),"Addition", UVM_NONE)
    for(int i = 0; i <= `trn; i++) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 0; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
    end
    $display("\n =========================END OPERATION =========================\n");
    `uvm_info(get_type_name(),"SUBTRACTION", UVM_NONE)
    for(int i = 0; i <= `trn; i++) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 1; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
    end
    $display("\n =========================END OPERATION =========================\n");
    `uvm_info(get_type_name(),"ADDITION_CIN WITH CIN == 0", UVM_NONE)
    for(int i = 0; i <= `trn; i++) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 2; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
    end
    $display("\n =========================END OPERATION =========================\n");
    `uvm_info(get_type_name(),"ADDITION_CIN WITH CIN == 1", UVM_NONE)
    for(int i = 0; i <= `trn; i++) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 2; inp_valid == 2'b11; ce == 1; mode == 1; cin == 1;})
    end
    $display("\n =========================END OPERATION =========================\n");
    `uvm_info(get_type_name(),"SUBTRACTION_CIN WITH CIN = 0", UVM_NONE)
    for(int i = 0; i <= `trn; i++) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 3; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
    end
    $display("\n =========================END OPERATION =========================\n");
    `uvm_info(get_type_name(),"SUBTRACTION_CIN_WITH CIN = 1", UVM_NONE)
    for(int i = 0; i <= `trn; i++) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 3; inp_valid == 2'b11; ce == 1; mode == 1; cin == 1;})
    end
    $display("\n =========================END OPERATION =========================\n");
    `uvm_info(get_type_name(),"INCREMENT A", UVM_NONE)
    for(int i = 0; i <= `trn; i++) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 4; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
    end
    $display("\n =========================END OPERATION =========================\n");
    `uvm_info(get_type_name(),"DECREMENT A", UVM_NONE)
    for(int i = 0; i <= `trn; i++) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 5; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
    end
    $display("\n =========================END OPERATION =========================\n");
    `uvm_info(get_type_name(),"INCREMENT B", UVM_NONE)
    for(int i = 0; i <= `trn; i++) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 6; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
    end
    $display("\n =========================END OPERATION =========================\n");
    `uvm_info(get_type_name(),"DECREMENT B", UVM_NONE)
    for(int i = 0; i <= `trn; i++) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 7; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
    end
    $display("\n =========================END OPERATION =========================\n");
    `uvm_info(get_type_name(),"COMPARE A > B", UVM_NONE)
    for(int i = 0; i <= `trn; i++) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 8; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0; opa > opb;})
    end
    $display("\n =========================END OPERATION =========================\n");
    `uvm_info(get_type_name(),"COMPARE A < B", UVM_NONE)
    for(int i = 0; i <= `trn; i++) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 8; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0; opa < opb;})
    end
    $display("\n =========================END OPERATION =========================\n");
    `uvm_info(get_type_name(),"COMPARE A == B", UVM_NONE)
    for(int i = 0; i <= `trn; i++) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 8; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0; opa == opb;})
    end
    $display("\n =========================END OPERATION =========================\n");
    `uvm_info(get_type_name(),"MUL_INC", UVM_NONE)
    for(int i = 0; i <= `trn; i++) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 9; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
    end
    $display("\n =========================END OPERATION =========================\n");
    `uvm_info(get_type_name(),"MUL_SHL", UVM_NONE)
    for(int i = 0; i <= `trn; i++) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 10; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
    end
    $display("\n =========================END OPERATION =========================\n");
    
    $display("\n\n ========================================================================= END OF SEQUENCE ====================================================================== \n\n");
  endtask
  
endclass

class alu_sequence_logic extends uvm_sequence #(trans);
  `uvm_object_utils(alu_sequence_logic)
  
  function new(string name = "alu_sequence_logic");
    super.new(name);
  endfunction
  
  task body();
  
    $display("\n\n ========================================================== START OF SEQUENCE alu_sequence_logic ===================================================================== \n\n");
    `uvm_info(get_type_name(),"AND", UVM_NONE)
    for(int i = 0; i <= `trn; i++) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 0; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0;})
    end
    $display("\n =========================END OPERATION =========================\n");
    `uvm_info(get_type_name(),"NAND", UVM_NONE)
    for(int i = 0; i <= `trn; i++) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 1; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0;})
    end
    $display("\n =========================END OPERATION =========================\n");
    `uvm_info(get_type_name(),"OR", UVM_NONE)
    for(int i = 0; i <= `trn; i++) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 2; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0;})
    end
    $display("\n =========================END OPERATION =========================\n");
   
    `uvm_info(get_type_name(),"NOR", UVM_NONE)
    for(int i = 0; i <= `trn; i++) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 3; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0;})
    end
    $display("\n =========================END OPERATION =========================\n");
    
    `uvm_info(get_type_name(),"XOR", UVM_NONE)
    for(int i = 0; i <= `trn; i++) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 4; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0;})
    end
    $display("\n =========================END OPERATION =========================\n");
    `uvm_info(get_type_name(),"XNOR", UVM_NONE)
    for(int i = 0; i <= `trn; i++) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 5; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0;})
    end
    $display("\n =========================END OPERATION =========================\n");
    `uvm_info(get_type_name(),"NOT A", UVM_NONE)
    for(int i = 0; i <= `trn; i++) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 6; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
    end
    $display("\n =========================END OPERATION =========================\n");
    `uvm_info(get_type_name(),"NOT B", UVM_NONE)
    for(int i = 0; i <= `trn; i++) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 7; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
    end
    $display("\n =========================END OPERATION =========================\n");
    `uvm_info(get_type_name(),"SHR1_A", UVM_NONE)
    for(int i = 0; i <= `trn; i++) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 8; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
    end
    $display("\n =========================END OPERATION =========================\n");

    `uvm_info(get_type_name(),"SHL1_A", UVM_NONE)
    for(int i = 0; i <= `trn; i++) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 9; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
    end
    $display("\n =========================END OPERATION =========================\n");
    
    `uvm_info(get_type_name(),"SHR1_B", UVM_NONE)
    for(int i = 0; i <= `trn; i++) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 10; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
    end
    $display("\n =========================END OPERATION =========================\n");
    
    `uvm_info(get_type_name(),"SHL1_B", UVM_NONE)
    for(int i = 0; i <= `trn; i++) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 11; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
    end
    $display("\n =========================END OPERATION =========================\n");
    
    `uvm_info(get_type_name(),"ROL_A_B", UVM_NONE)
    for(int i = 0; i <= `trn; i++) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 12; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0; opb[7:4] == 0;})
    end
    $display("\n =========================END OPERATION =========================\n");
    
    `uvm_info(get_type_name(),"ROR_A_B", UVM_NONE)
    for(int i = 0; i <= `trn; i++) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 13; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0; opb[7:4] == 0;})
    end
    $display("\n =========================END OPERATION =========================\n");
    
    $display("\n =========================INP_VALID CHECK =========================\n");
    
    //for(int i = 0; i <= `trn; i++) begin
    req = trans :: type_id :: create("req");
    `uvm_do_with(req, {cmd == 0; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
    
    req = trans :: type_id :: create("req");
    `uvm_do_with(req, {cmd == 0; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
    
    repeat(5) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 0; inp_valid == 2'b00; ce == 1; mode == 1; cin == 0;})
    end
    
    req = trans :: type_id :: create("req");
    `uvm_do_with(req, {cmd == 0; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
  //end
    repeat(4) begin
     req = trans :: type_id :: create("req");
    `uvm_do_with(req, {cmd == 0; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
    end
    $display("\n\n ========================================================================= END OF SEQUENCE ====================================================================== \n\n");
    
  endtask
  
endclass

class alu_sequence_inp_valid_01 extends uvm_sequence #(trans);
  `uvm_object_utils(alu_sequence_inp_valid_01)
  
  function new(string name = "alu_sequence_inp_valid_01");
    super.new(name);
  endfunction
  
  task body();
    $display("\n\n ========================================================== START OF SEQUENCE alu_sequence_inp_valid_01 ============================================================== \n\n");
    $display("\n =========================INP_VALID ERROR =========================\n");
    `uvm_info(get_type_name(),"AND", UVM_NONE)
    req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 0; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 0; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
      
      repeat(5) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 0; inp_valid == 2'b00; ce == 1; mode == 0; cin == 0;})
      end
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 0; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 0; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0;})
      end
    $display("\n ========================= END OPERATION =========================\n");
    
    `uvm_info(get_type_name(),"NAND", UVM_NONE)

    req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 1; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 1; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
      
      repeat(5) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 1; inp_valid == 2'b00; ce == 1; mode == 0; cin == 0;})
      end
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 1; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 1; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
    
    `uvm_info(get_type_name(),"OR", UVM_NONE)
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 2; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 2; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
      
      repeat(5) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 2; inp_valid == 2'b00; ce == 1; mode == 0; cin == 0;})
      end
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 2; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 2; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
   
    `uvm_info(get_type_name(),"NOR", UVM_NONE)
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 3; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 3; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
      
      repeat(5) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 3; inp_valid == 2'b00; ce == 1; mode == 0; cin == 0;})
      end
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 3; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 3; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
    
    `uvm_info(get_type_name(),"XOR", UVM_NONE)
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 4; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 4; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
      
      repeat(5) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 4; inp_valid == 2'b00; ce == 1; mode == 0; cin == 0;})
      end
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 4; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 4; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
    
    `uvm_info(get_type_name(),"XNOR", UVM_NONE)
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 5; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 5; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
      
      repeat(5) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 5; inp_valid == 2'b00; ce == 1; mode == 0; cin == 0;})
      end
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 5; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 5; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
    
    `uvm_info(get_type_name(),"ROL_A_B", UVM_NONE)
    req = trans :: type_id :: create("req");
    `uvm_do_with(req, {cmd == 12; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 12; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
      
      repeat(5) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 12; inp_valid == 2'b00; ce == 1; mode == 0; cin == 0;})
      end
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 12; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 12; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
    
    `uvm_info(get_type_name(),"ROR_A_B", UVM_NONE)
    req = trans :: type_id :: create("req");
    `uvm_do_with(req, {cmd == 13; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 13; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
      
      repeat(5) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 13; inp_valid == 2'b00; ce == 1; mode == 0; cin == 0;})
      end
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 13; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 13; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
    
    $display("\n\n ========================================================================= END OF SEQUENCE ====================================================================== \n\n");
  endtask
  
endclass

class alu_sequence_inp_valid_error_01 extends uvm_sequence #(trans);
  `uvm_object_utils(alu_sequence_inp_valid_error_01)

  
  function new(string name = "alu_sequence_inp_valid_error_01");
    super.new(name);
  endfunction
  
  task body();
  
    $display("\n\n ===================================================== START OF SEQUENCE alu_sequence_inp_valid_error_01 =============================================================== \n\n");
    $display("\n =========================INP_VALID ERROR =========================\n");
    `uvm_info(get_type_name(),"AND", UVM_NONE)
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 0; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})

      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 0; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})

      repeat(16) begin

        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 0; inp_valid == 2'b00; ce == 1; mode == 0; cin == 0;})

      end
      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 0; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
    `uvm_info(get_type_name(),"NAND", UVM_NONE)

    req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 1; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 1; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
      
      repeat(16) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 1; inp_valid == 2'b00; ce == 1; mode == 0; cin == 0;})
      end
      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 1; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
    `uvm_info(get_type_name(),"OR", UVM_NONE)
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 2; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 2; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
      
      repeat(16) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 2; inp_valid == 2'b00; ce == 1; mode == 0; cin == 0;})
      end
      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 2; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
   
    `uvm_info(get_type_name(),"NOR", UVM_NONE)
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 3; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 3; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
      
      repeat(16) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 3; inp_valid == 2'b00; ce == 1; mode == 0; cin == 0;})
      end
      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 3; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
    
    `uvm_info(get_type_name(),"XOR", UVM_NONE)
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 4; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 4; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
      
      repeat(16) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 4; inp_valid == 2'b00; ce == 1; mode == 0; cin == 0;})
      end

      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 4; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
    `uvm_info(get_type_name(),"XNOR", UVM_NONE)
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 5; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 5; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
      
      repeat(16) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 5; inp_valid == 2'b00; ce == 1; mode == 0; cin == 0;})
      end

      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 5; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
    
    `uvm_info(get_type_name(),"ROL_A_B", UVM_NONE)
    req = trans :: type_id :: create("req");
    `uvm_do_with(req, {cmd == 12; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 12; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
      
      repeat(16) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 12; inp_valid == 2'b00; ce == 1; mode == 0; cin == 0;})
      end
        
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 12; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
    
    `uvm_info(get_type_name(),"ROR_A_B", UVM_NONE)
     req = trans :: type_id :: create("req");
    `uvm_do_with(req, {cmd == 13; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
      
     req = trans :: type_id :: create("req");
     `uvm_do_with(req, {cmd == 13; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
      
      repeat(16) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 13; inp_valid == 2'b00; ce == 1; mode == 0; cin == 0;})
      end
      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 13; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
    $display("\n\n ========================================================================= END OF SEQUENCE ====================================================================== \n\n");
  endtask
  
endclass

class alu_sequence_inp_valid_10 extends uvm_sequence #(trans);
  `uvm_object_utils(alu_sequence_inp_valid_10)
  
  function new(string name = "alu_sequence_inp_valid_10");
    super.new(name);
  endfunction
  
  task body();
    
    $display("\n\n ==================================================== START OF SEQUENCE alu_sequence_inp_valid_10 ===================================================================== \n\n");
    $display("\n =========================INP_VALID ERROR =========================\n");
    `uvm_info(get_type_name(),"AND", UVM_NONE)
    req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 0; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 0; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
      
      repeat(5) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 0; inp_valid == 2'b00; ce == 1; mode == 0; cin == 0;})
      end
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 0; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 0; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
    `uvm_info(get_type_name(),"NAND", UVM_NONE)

    req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 1; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 1; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
      
      repeat(5) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 1; inp_valid == 2'b00; ce == 1; mode == 0; cin == 0;})
      end
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 1; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 1; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
    `uvm_info(get_type_name(),"OR", UVM_NONE)
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 2; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 2; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
      
      repeat(5) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 2; inp_valid == 2'b00; ce == 1; mode == 0; cin == 0;})
      end
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 2; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 2; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
   
    `uvm_info(get_type_name(),"NOR", UVM_NONE)
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 3; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 3; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
      
      repeat(5) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 3; inp_valid == 2'b00; ce == 1; mode == 0; cin == 0;})
      end
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 3; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 3; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
    
    `uvm_info(get_type_name(),"XOR", UVM_NONE)
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 4; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 4; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
      
      repeat(5) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 4; inp_valid == 2'b00; ce == 1; mode == 0; cin == 0;})
      end
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 4; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 4; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
    `uvm_info(get_type_name(),"XNOR", UVM_NONE)
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 5; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 5; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
      
      repeat(5) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 5; inp_valid == 2'b00; ce == 1; mode == 0; cin == 0;})
      end
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 5; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 5; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
    
    `uvm_info(get_type_name(),"ROL_A_B", UVM_NONE)
    req = trans :: type_id :: create("req");
    `uvm_do_with(req, {cmd == 12; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 12; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
      
      repeat(5) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 12; inp_valid == 2'b00; ce == 1; mode == 0; cin == 0;})
      end
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 12; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 12; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
    
    `uvm_info(get_type_name(),"ROR_A_B", UVM_NONE)
    req = trans :: type_id :: create("req");
    `uvm_do_with(req, {cmd == 13; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 13; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
      
      repeat(5) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 13; inp_valid == 2'b00; ce == 1; mode == 0; cin == 0;})
      end
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 13; inp_valid == 2'b01; ce == 1; mode == 0; cin == 0;})
      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 13; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
    $display("\n\n ========================================================================= END OF SEQUENCE ====================================================================== \n\n");
  endtask
  
endclass

class alu_sequence_inp_valid_error_10 extends uvm_sequence #(trans);
  `uvm_object_utils(alu_sequence_inp_valid_error_10)
  
  function new(string name = "alu_sequence_inp_valid_error_10");
    super.new(name);
  endfunction
  
  task body();
    $display("\n\n ======================================================== START OF SEQUENCE alu_sequence_inp_valid_error_10 ========================================================== \n\n");
    $display("\n =========================INP_VALID ERROR =========================\n");
    `uvm_info(get_type_name(),"AND", UVM_NONE)

    req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 0; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
  
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 0; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
    
      repeat(16) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 0; inp_valid == 2'b00; ce == 1; mode == 0; cin == 0;})

      end
      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 0; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
    `uvm_info(get_type_name(),"NAND", UVM_NONE)

    req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 1; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 1; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
      
      repeat(16) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 1; inp_valid == 2'b00; ce == 1; mode == 0; cin == 0;})
      end
      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 1; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
    `uvm_info(get_type_name(),"OR", UVM_NONE)
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 2; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 2; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
      
      repeat(16) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 2; inp_valid == 2'b00; ce == 1; mode == 0; cin == 0;})
      end
      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 2; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
   
    `uvm_info(get_type_name(),"NOR", UVM_NONE)
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 3; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 3; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
      
      repeat(16) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 3; inp_valid == 2'b00; ce == 1; mode == 0; cin == 0;})
      end
      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 3; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
    
    `uvm_info(get_type_name(),"XOR", UVM_NONE)
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 4; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 4; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
      
      repeat(16) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 4; inp_valid == 2'b00; ce == 1; mode == 0; cin == 0;})
      end

      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 4; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
    `uvm_info(get_type_name(),"XNOR", UVM_NONE)
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 5; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 5; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
      
      repeat(16) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 5; inp_valid == 2'b00; ce == 1; mode == 0; cin == 0;})
      end

      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 5; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
    
    `uvm_info(get_type_name(),"ROL_A_B", UVM_NONE)
    req = trans :: type_id :: create("req");
    `uvm_do_with(req, {cmd == 12; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 12; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
      
      repeat(16) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 12; inp_valid == 2'b00; ce == 1; mode == 0; cin == 0;})
      end
        
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 12; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
    
    `uvm_info(get_type_name(),"ROR_A_B", UVM_NONE)

     req = trans :: type_id :: create("req");
    `uvm_do_with(req, {cmd == 13; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
  

     req = trans :: type_id :: create("req");
     `uvm_do_with(req, {cmd == 13; inp_valid == 2'b10; ce == 1; mode == 0; cin == 0;})
      
      repeat(16) begin
    
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 13; inp_valid == 2'b00; ce == 1; mode == 0; cin == 0;})
      end
      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 13; inp_valid == 2'b11; ce == 1; mode == 0; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
    $display("\n\n ========================================================================= END OF SEQUENCE ====================================================================== \n\n");
  endtask
  
endclass
