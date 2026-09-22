class alu_sequence_inp_valid_10_arith extends uvm_sequence #(trans);
  `uvm_object_utils(alu_sequence_inp_valid_10_arith)
  
  function new(string name = "alu_sequence_inp_valid_10_arith");
    super.new(name);
  endfunction
  
  task body();
    
    $display("\n\n ==================================================== START OF SEQUENCE alu_sequence_inp_valid_10 ===================================================================== \n\n");
    $display("\n ========================= INP_VALID ERROR =========================\n");
    `uvm_info(get_type_name(),"ADD", UVM_NONE)
    req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 0; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 0; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      repeat(5) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 0; inp_valid == 2'b00; ce == 1; mode == 1; cin == 0;})
      end
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 0; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 0; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
      end
    $display("\n ========================= END OPERATION =========================\n");
    `uvm_info(get_type_name(),"SUB", UVM_NONE)

    req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 1; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 1; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      repeat(5) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 1; inp_valid == 2'b00; ce == 1; mode == 1; cin == 0;})
      end
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 1; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 1; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
    `uvm_info(get_type_name(),"ADD_CIN", UVM_NONE)
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 2; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 2; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      repeat(5) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 2; inp_valid == 2'b00; ce == 1; mode == 1; cin == 0;})
      end
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 2; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 2; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
      end
    $display("\n ========================= END OPERATION =========================\n");
   
    `uvm_info(get_type_name(),"SUB_CIN", UVM_NONE)
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 3; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 3; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      repeat(5) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 3; inp_valid == 2'b00; ce == 1; mode == 1; cin == 0;})
      end
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 3; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 3; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
      end
    $display("\n ========================= END OPERATION =========================\n");
    
    `uvm_info(get_type_name(),"CMP", UVM_NONE)
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 8; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 8; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      repeat(5) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 8; inp_valid == 2'b00; ce == 1; mode == 1; cin == 0;})
      end
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 8; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 8; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
      end
    $display("\n ========================= END OPERATION =========================\n");
    `uvm_info(get_type_name(),"MUL_INC", UVM_NONE)
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 9; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 9; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      repeat(5) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 9; inp_valid == 2'b00; ce == 1; mode == 1; cin == 0;})
      end
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 9; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 9; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
      end
    $display("\n ========================= END OPERATION =========================\n");
    
    `uvm_info(get_type_name(),"MUL_SHL", UVM_NONE)
    req = trans :: type_id :: create("req");
    `uvm_do_with(req, {cmd == 10; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 10; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      repeat(5) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 10; inp_valid == 2'b00; ce == 1; mode == 1; cin == 0;})
      end
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 10; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
    
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 10; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
      end
    $display("\n ========================= END OPERATION =========================\n");
    
    $display("\n\n ========================================================================= END OF SEQUENCE ====================================================================== \n\n");
  endtask
  
endclass

class alu_sequence_inp_valid_error_10_arith extends uvm_sequence #(trans);
  `uvm_object_utils(alu_sequence_inp_valid_error_10_arith)
  
  int count = 0;
  
  function new(string name = "alu_sequence_inp_valid_error_10_arith");
    super.new(name);
  endfunction
  
  task body();
    $display("\n\n ======================================================== START OF SEQUENCE alu_sequence_inp_valid_error_10 ========================================================== \n\n");
    $display("\n ========================= INP_VALID ERROR =========================\n");
    `uvm_info(get_type_name(),"ADD", UVM_NONE)

    req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 0; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      count++;
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 0; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      count++;
      repeat(20) begin
        count++;//$display(" count = %0d", count);
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 0; inp_valid == 2'b00; ce == 1; mode == 1; cin == 0;})
        $display(" count = %0d", count);

      end
      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 0; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
      end
    $display("\n ========================= END OPERATION =========================\n");
    `uvm_info(get_type_name(),"SUB", UVM_NONE)

    req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 1; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 1; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      repeat(20) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 1; inp_valid == 2'b00; ce == 1; mode == 1; cin == 0;})
      end
      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 1; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
      end
    $display("\n ========================= END OPERATION =========================\n");
    `uvm_info(get_type_name(),"ADD_CIN", UVM_NONE)
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 2; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 2; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      repeat(20) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 2; inp_valid == 2'b00; ce == 1; mode == 1; cin == 0;})
      end
      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 2; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
      end
    $display("\n ========================= END OPERATION =========================\n");
   
    `uvm_info(get_type_name(),"SUB_CIN", UVM_NONE)
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 3; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 3; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      repeat(20) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 3; inp_valid == 2'b00; ce == 1; mode == 1; cin == 0;})
      end
      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 3; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
      end
    $display("\n ========================= END OPERATION =========================\n");
    
    `uvm_info(get_type_name(),"CMP", UVM_NONE)
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 8; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 8; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      repeat(20) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 8; inp_valid == 2'b00; ce == 1; mode == 1; cin == 0;})
      end

      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 8; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
      end
    $display("\n ========================= END OPERATION =========================\n");
    `uvm_info(get_type_name(),"MUL_INC", UVM_NONE)
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 9; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 9; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      repeat(20) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 9; inp_valid == 2'b00; ce == 1; mode == 1; cin == 0;})
      end

      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 9; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
    
    `uvm_info(get_type_name(),"MUL_SHL", UVM_NONE)
    req = trans :: type_id :: create("req");
    `uvm_do_with(req, {cmd == 10; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 10; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      repeat(20) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 10; inp_valid == 2'b00; ce == 1; mode == 1; cin == 0;})
      end
        
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 10; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
      end
    $display("\n ========================= END OPERATION =========================\n");
    
    $display("\n\n ========================================================================= END OF SEQUENCE ====================================================================== \n\n");
  endtask
  
endclass

class alu_sequence_inp_valid_01_arith extends uvm_sequence #(trans);
  `uvm_object_utils(alu_sequence_inp_valid_01_arith)
  
  function new(string name = "alu_sequence_inp_valid_01_arith");
    super.new(name);
  endfunction
  
  task body();
    
    $display("\n\n ==================================================== START OF SEQUENCE alu_sequence_inp_valid_10 ===================================================================== \n\n");
    $display("\n ========================= INP_VALID ERROR =========================\n");
    `uvm_info(get_type_name(),"ADD", UVM_NONE)
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
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 0; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
      end
    $display("\n ========================= END OPERATION =========================\n");
    `uvm_info(get_type_name(),"SUB", UVM_NONE)

    req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 1; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 1; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      
      repeat(5) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 1; inp_valid == 2'b00; ce == 1; mode == 1; cin == 0;})
      end
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 1; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 1; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
      end
    $display("\n ========================= END OPERATION =========================\n");
    `uvm_info(get_type_name(),"ADD_CIN", UVM_NONE)
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 2; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 2; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      
      repeat(5) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 2; inp_valid == 2'b00; ce == 1; mode == 1; cin == 0;})
      end
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 2; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 2; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
   
    `uvm_info(get_type_name(),"SUB_CIN", UVM_NONE)
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 3; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 3; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      
      repeat(5) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 3; inp_valid == 2'b00; ce == 1; mode == 1; cin == 0;})
      end
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 3; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 3; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
    
    `uvm_info(get_type_name(),"CMP", UVM_NONE)
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 8; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 8; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      
      repeat(5) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 8; inp_valid == 2'b00; ce == 1; mode == 1; cin == 0;})
      end
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 8; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 8; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
    `uvm_info(get_type_name(),"MUL_INC", UVM_NONE)
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 9; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 9; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      
      repeat(5) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 9; inp_valid == 2'b00; ce == 1; mode == 1; cin == 0;})
      end
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 9; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 9; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
    
    `uvm_info(get_type_name(),"MUL_SHL", UVM_NONE)
    req = trans :: type_id :: create("req");
    `uvm_do_with(req, {cmd == 10; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 10; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      
      repeat(5) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 10; inp_valid == 2'b00; ce == 1; mode == 1; cin == 0;})
      end
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 10; inp_valid == 2'b10; ce == 1; mode == 1; cin == 0;})
    
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 10; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
    
    $display("\n\n ========================================================================= END OF SEQUENCE ====================================================================== \n\n");
  endtask
  
endclass

class alu_sequence_inp_valid_error_01_arith extends uvm_sequence #(trans);
  `uvm_object_utils(alu_sequence_inp_valid_error_01_arith)
  
  int count = 0;
  
  function new(string name = "alu_sequence_inp_valid_error_01_arith");
    super.new(name);
  endfunction
  
  task body();
    $display("\n\n ======================================================== START OF SEQUENCE alu_sequence_inp_valid_error_10 ========================================================== \n\n");
    $display("\n =========================INP_VALID ERROR =========================\n");
    `uvm_info(get_type_name(),"ADD", UVM_NONE)

    req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 0; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      count++;
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 0; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      count++;
      repeat(20) begin
        count++;//$display(" count = %0d", count);
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 0; inp_valid == 2'b00; ce == 1; mode == 1; cin == 0;})
        $display(" count = %0d", count);

      end
      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 0; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
    `uvm_info(get_type_name(),"SUB", UVM_NONE)

    req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 1; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 1; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      
      repeat(20) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 1; inp_valid == 2'b00; ce == 1; mode == 1; cin == 0;})
      end
      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 1; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
    `uvm_info(get_type_name(),"ADD_CIN", UVM_NONE)
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 2; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 2; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      
      repeat(20) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 2; inp_valid == 2'b00; ce == 1; mode == 1; cin == 0;})
      end
      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 2; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
   
    `uvm_info(get_type_name(),"SUB_CIN", UVM_NONE)
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 3; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 3; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      
      repeat(20) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 3; inp_valid == 2'b00; ce == 1; mode == 1; cin == 0;})
      end
      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 3; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
    
    `uvm_info(get_type_name(),"CMP", UVM_NONE)
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 8; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 8; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      
      repeat(20) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 8; inp_valid == 2'b00; ce == 1; mode == 1; cin == 0;})
      end

      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 8; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
    `uvm_info(get_type_name(),"MUL_INC", UVM_NONE)
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 9; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 9; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      
      repeat(20) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 9; inp_valid == 2'b00; ce == 1; mode == 1; cin == 0;})
      end

      
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 9; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
    
    `uvm_info(get_type_name(),"MUL_SHL", UVM_NONE)
    req = trans :: type_id :: create("req");
    `uvm_do_with(req, {cmd == 10; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 10; inp_valid == 2'b01; ce == 1; mode == 1; cin == 0;})
      
      repeat(20) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {cmd == 10; inp_valid == 2'b00; ce == 1; mode == 1; cin == 0;})
      end
        
      repeat(4) begin
       req = trans :: type_id :: create("req");
      `uvm_do_with(req, {cmd == 10; inp_valid == 2'b11; ce == 1; mode == 1; cin == 0;})
      end
    $display("\n =========================END OPERATION =========================\n");
    
    $display("\n\n ========================================================================= END OF SEQUENCE ====================================================================== \n\n");
  endtask
  
endclass


