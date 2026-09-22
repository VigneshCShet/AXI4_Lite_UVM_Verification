interface alu_assertion(
  input bit clk,
  input bit [`dw - 1 : 0] opb, 
  input bit [`dw * 2 - 1 : 0]res,
  input bit [`cw -1 : 0] cmd, 
  input bit [1:0] inp_valid,
  input bit g, l, e, err, oflow, cout, ce, mode, reset 
);

  property ch_rst;
    @(posedge reset) 
    $rose(reset) |-> (res == 0) && (g == 0) && (l == 0) && (e == 0) && (err == 0) && (oflow == 0) && (cout == 0);
  endproperty

  property ch_inp_valid;
    int exp = 0;
    @(posedge clk) disable iff (reset)
    ((inp_valid == 2'b01 || inp_valid == 2'b10), exp = (inp_valid == 2'b01) ? 2'b10 : 2'b01) |-> first_match(##[1:16] (exp == inp_valid)) or (exp != inp_valid)[*16] ##1 $rose(err) ;
  endproperty

  property ch_ROL;
    @(posedge clk) disable iff (reset)
    ((mode == 0) && (ce == 1)) && ((cmd == 12) && (opb[`dw - 1 : 4] != 0)) |=> $rose(err);
  endproperty
  

  property ch_ROR;
    @(posedge clk)disable iff (reset)
    (mode == 0) && (ce == 1) && (cmd == 13) && (opb[`dw - 1 : 4] != 0) |=> $rose(err);
  endproperty

  property ch_inc_dec_a;
    @(posedge clk) disable iff (reset)
    (mode == 1) && (ce == 1) && (cmd == 4 || cmd == 5) && (inp_valid[0] != 1) |=> $rose(err);
  endproperty

  property ch_inc_dec_b;
    @(posedge clk) disable iff (reset)
    (mode == 1) && (ce == 1) && (cmd == 6 || cmd == 7) && (inp_valid[1] != 1) |=> $rose(err);
  endproperty

  property ch_ce;
    @(posedge clk) disable iff (reset)
    $fell(ce) |=> $stable(res) && $stable(cout) && $stable(oflow) && $stable(g) && $stable(l) && $stable(e) && $stable(err);
  endproperty
  
  property ch_arith_invalid_cmd;
    @(posedge clk) disable iff (reset)
    mode == 1 && cmd >10 && ce == 1 |=> $rose(err);
  endproperty
  
  property ch_logic_invalid_cmd;
    @(posedge clk) disable iff (reset)
    mode == 0 && cmd >13 && ce == 1 |=> $rose(err);
  endproperty
  
  
  assert property(ch_rst)
    $info("ch_rst ASSERTION PASSED SUCCESSFULLY");
  else
    $error("ch_rst Assertion failed");
    
  assert property(ch_inp_valid)
    $info("ch_inp_valid ASSERTION PASSED SUCCESSFULLY");
  else
    $error("ch_inp_valid Assertion failed");
  
  
  assert property(ch_ROL)
    $info("ch_ROL ASSERTION PASSED SUCCESSFULLY");
  else
    $error("ch_ROL Assertion failed");
    
  assert property(ch_ROR)
    $info("ch_ROR ASSERTION PASSED SUCCESSFULLY");
  else
    $error("ch_ROR Assertion failed");
    
  assert property(ch_inc_dec_a)
    $info("ch_in_dec_a ASSERTION PASSED SUCCESSFULLY");
  else
    $error("ch_in_dec_a Assertion failed");
    
  assert property(ch_inc_dec_b)
    $info("ch_inc_dec_b ASSERTION PASSED SUCCESSFULLY");
  else
    $error("ch_in_dec_b Assertion failed");
    
  assert property(ch_ce)
    $info("CE ASSERTION PASSED SUCCESSFULLY");
  else
    $error("CE Assertion failed");
    
  assert property (ch_arith_invalid_cmd)
    $info("ch_arith_invalid_cmd ASSERTION PASSED SUCCESSFULLY");
  else
    $error("ch_arith_invalid_cmd Assertion failed");
    
  assert property (ch_logic_invalid_cmd)
    $info("ch_logic_invalid_cmd ASSERTION PASSED SUCCESSFULLY");
  else
    $error("ch_logic_invalid_cmd Assertion failed");
  
endinterface
