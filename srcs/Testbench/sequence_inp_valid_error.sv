class sequence_inp_valid_error_00 extends uvm_sequence #(trans);
  `uvm_object_utils(sequence_inp_valid_error_00)
  
  function new(string name = "sequence_inp_valid_error_00");
    super.new(name);
  endfunction
  
  task body();
    $display("\n\n===================================================== START OF SEQUENCE INP_VALID 00 ARITHMETIC ============================================== \n\n");
    repeat(5) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {mode == 1; ce == 1; cmd == 0; inp_valid == 2'b11; cin == 0;})
    end
    $display("\n=================================== STARTS HERE ================================================ \n");
    for(int i = 0; i <= 10; i++) begin
      repeat(50) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {mode == 1; ce == 1; cmd == i; inp_valid == 2'b00;})
      end
    end
    $display("\n ========================================== INP_VALID 00 LOGIC ================================================= \n");
    repeat(5) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {mode == 0; ce == 1; cmd == 0; inp_valid == 2'b11; cin == 0;})
    end
    $display("\n=================================== STARTS HERE ================================================ \n");
    for(int i = 0; i <= 13; i++) begin
      repeat(50) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {mode == 0; ce == 1; cmd == i; inp_valid == 2'b00;})
      end    
    end
    
    $display("\n\n===================================================== END OF SEQUENCE ================================================\n\n");
  endtask
  
endclass

class sequence_inp_valid_error_1_op extends uvm_sequence #(trans);
  `uvm_object_utils(sequence_inp_valid_error_1_op)
  
  function new(string name = "sequence_inp_valid_error_1_op");
    super.new(name);
  endfunction
  
  task body();
    $display("\n\n===================================================== START OF SEQUENCE INP_VALID 1 OPERAND ARITHMETIC ============================================== \n\n");
  
    for(int i = 4; i <= 7; i++) begin
      repeat(10) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {mode == 1; ce == 1; cmd == i; (cmd == 4 || cmd == 5) -> inp_valid == 2'b10; (cmd == 6 || cmd == 7) -> inp_valid == 2'b01;})
      end
    end
    $display("\n\n===================================================== START OF SEQUENCE INP_VALID 1 OPERAND LOGIC ============================================== \n\n");
    for(int i = 6; i <= 11; i++) begin
      repeat(10) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {mode == 0; ce == 1; cmd == i; (cmd == 6 || cmd == 8 || cmd == 9) -> inp_valid == 2'b10; (cmd == 7 || cmd == 10 || cmd == 11) -> inp_valid == 2'b01;})
      end
    end
  endtask
endclass
