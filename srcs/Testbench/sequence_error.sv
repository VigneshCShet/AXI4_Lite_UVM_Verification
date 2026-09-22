class sequence_error extends uvm_sequence #(trans);
  `uvm_object_utils(sequence_error)
  
  function new(string name = "sequence_error");
    super.new(name);
  endfunction
  
  task body();
    $display("\n\n===================================================== START OF SEQUENCE ERROR CMD ARITHMETIC ============================================== \n\n");
    repeat(5) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {mode == 1; ce == 1; cmd == 0; inp_valid == 2'b11; cin == 0;})
    end
    $display("\n=================================== STARTS HERE ================================================ \n");
    for(int i = 11; i <= 15; i++) begin
  
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {mode == 1; ce == 1; cmd == i; inp_valid == 2'b11;})
    end
    $display("\n ========================================== ERROR CMD LOGIC ================================================= \n");
    repeat(5) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {mode == 0; ce == 1; cmd == 0; inp_valid == 2'b11; cin == 0;})
    end
    $display("\n=================================== STARTS HERE ================================================ \n");
    for(int i = 13; i <= 15; i++) begin
      
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {mode == 0; ce == 1; cmd == i; inp_valid == 2'b11;})
      
    end
    
    $display("\n========================================================= ROL ERROR CASE ======================================================\n");
    req = trans :: type_id :: create("req");
    `uvm_do_with(req, {mode == 0; ce == 1; cmd == 12; inp_valid == 2'b11; opb[3:0] == 0;})
    
    req = trans :: type_id :: create("req");
    `uvm_do_with(req, {mode == 0; ce == 1; cmd == 12; inp_valid == 2'b11; opb[7:4] == 0;})
    
    repeat(40) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {mode == 0; ce == 1; cmd == 12; inp_valid == 2'b11; opb[3:0] == 0;})
    end
    
    $display("\n========================================================== ROR ERROR CASE ======================================================\n");
    req = trans :: type_id :: create("req");
    `uvm_do_with(req, {mode == 0; ce == 1; cmd == 13; inp_valid == 2'b11; opb[3:0] == 0;})
    
    req = trans :: type_id :: create("req");
    `uvm_do_with(req, {mode == 0; ce == 1; cmd == 13; inp_valid == 2'b11; opb[7:4] == 0;})
    
    repeat(40) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {mode == 0; ce == 1; cmd == 13; inp_valid == 2'b11; opb[3:0] == 0;})
    end
    $display("\n\n===================================================== END OF SEQUENCE ================================================\n\n");
  endtask
  
endclass
