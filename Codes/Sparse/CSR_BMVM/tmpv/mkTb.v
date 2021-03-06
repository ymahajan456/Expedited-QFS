//
// Generated by Bluespec Compiler, version 2014.05.C (build 33930, 2014-05-28)
//
// On Fri May  4 10:48:11 IST 2018
//
//
// Ports:
// Name                         I/O  size props
// CLK                            I     1 clock
// RST_N                          I     1 reset
//
// No combinational paths from inputs to outputs
//
//

`ifdef BSV_ASSIGNMENT_DELAY
`else
  `define BSV_ASSIGNMENT_DELAY
`endif

`ifdef BSV_POSITIVE_RESET
  `define BSV_RESET_VALUE 1'b1
  `define BSV_RESET_EDGE posedge
`else
  `define BSV_RESET_VALUE 1'b0
  `define BSV_RESET_EDGE negedge
`endif

module mkTb(CLK,
	    RST_N);
  input  CLK;
  input  RST_N;

  // register sent
  reg sent;
  wire sent$D_IN, sent$EN;

  // ports of submodule mod
  wire [31 : 0] mod$get, mod$put_x;
  wire mod$EN_get, mod$EN_put, mod$RDY_get, mod$RDY_put;

  // submodule mod
  mkCsrBMVM #(.lut_num(32'd0)) mod(.CLK(CLK),
				   .RST_N(RST_N),
				   .put_x(mod$put_x),
				   .EN_get(mod$EN_get),
				   .EN_put(mod$EN_put),
				   .get(mod$get),
				   .RDY_get(mod$RDY_get),
				   .RDY_put(mod$RDY_put));

  // register sent
  assign sent$D_IN = 1'd1 ;
  assign sent$EN = mod$RDY_put && !sent ;

  // submodule mod
  assign mod$put_x = 32'hFFFFFFFF ;
  assign mod$EN_get = mod$RDY_get ;
  assign mod$EN_put = mod$RDY_put && !sent ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        sent <= `BSV_ASSIGNMENT_DELAY 1'd0;
      end
    else
      begin
        if (sent$EN) sent <= `BSV_ASSIGNMENT_DELAY sent$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    sent = 1'h0;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on

  // handling of system tasks

  // synopsys translate_off
  always@(negedge CLK)
  begin
    #0;
    if (RST_N != `BSV_RESET_VALUE)
      if (mod$RDY_get) $display("Value: %0b", mod$get);
    if (RST_N != `BSV_RESET_VALUE) if (mod$RDY_get) $finish(32'd0);
  end
  // synopsys translate_on
endmodule  // mkTb

