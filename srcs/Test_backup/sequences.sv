class sanity_sequence extends uvm_sequence #(trans);
  `uvm_object_utils(sanity_sequence)
  
  function new(string name = "sanity_sequence");
    super.new(name);
  endfunction
  
  task body;
    repeat(`txns) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {awvalid == 1; wvalid == 1;})
    end
    
    repeat(`txns) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {arvalid == 1;})
    end
  endtask
endclass

class error_sequences extends uvm_sequence #(trans);
  `uvm_object_utils(error_sequences)
  
  function new(string name = "error_sequences");
    super.new(name);
  endfunction
  
  task body();
    repeat(`txns) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {awaddr[1:0] != 0; araddr[1:0] != 0;})
    end
    
    repeat(`txns) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {awaddr > 63; araddr > 63;})
    end
    
    repeat(`txns) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {awaddr[1:0] != 0; araddr[1:0] != 0; awaddr > 63; araddr > 63;})
    end
    
    /*repeat(`txns) begin
      req = trans :: type_id :: create("req");
      `uvm_do_with(req, {})
    end*/
  endtask
endclass
