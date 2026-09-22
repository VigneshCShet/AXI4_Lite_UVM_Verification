class sequence_ce extends uvm_sequence #(trans);
  `uvm_object_utils(sequence_ce)
  
  function new(string name = "sequence_ce");
    super.new(name);
  endfunction
  
  task body();
    $display("\n\n===================================================== START OF SEQUENCE CE ============================================== \n\n");
    repeat(5) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {mode == 1; ce == 1; cmd == 0; inp_valid == 2'b11; cin == 0;})
    end
    
    for(int i = 0; i <= 13; i++) begin
      repeat(50) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {mode == 1; ce == 0; cmd == i; inp_valid == 2'b11;})
      end
    end
    $display("\n ========================================== NOW CE IS 1 ================================================= \n");
    repeat(5) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {mode == 0; ce == 1; cmd == 0; inp_valid == 2'b11; cin == 0;})
    end
    
    for(int i = 0; i <= 13; i++) begin
      repeat(50) begin
        req = trans :: type_id :: create("req");
        `uvm_do_with(req, {mode == 0; ce == 0; cmd == i; inp_valid == 2'b11;})
      end    
    end
    repeat(5) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {mode == 1; ce == 1; cmd == 0; inp_valid == 2'b11; cin == 0;})
    end
    
    $display("================ CE MULTIPLICATION INC CHECK ==============");
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {mode == 1; ce == 1; cmd == 9; inp_valid == 2'b11; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {mode == 1; ce == 0; cmd == 9; inp_valid == 2'b11; cin == 0;})
     
     repeat(5) begin 
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {mode == 1; ce == 1; cmd == 9; inp_valid == 2'b11; cin == 0;})
     end 
     $display("================ CE MULTIPLICATION SHL CHECK ==============");
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {mode == 1; ce == 1; cmd == 10; inp_valid == 2'b11; cin == 0;})
      
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {mode == 1; ce == 0; cmd == 10; inp_valid == 2'b11; cin == 0;})
     
     repeat(5) begin 
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {mode == 1; ce == 1; cmd == 10; inp_valid == 2'b11; cin == 0;})
     end
    $display("\n\n===================================================== END OF SEQUENCE ================================================\n\n");
  endtask
endclass
