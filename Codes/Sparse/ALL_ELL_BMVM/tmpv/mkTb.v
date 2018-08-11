//
// Generated by Bluespec Compiler, version 2014.05.C (build 33930, 2014-05-28)
//
// On Thu May  3 17:49:25 IST 2018
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

  // ports of submodule mod
  wire [31 : 0] mod$get, mod$put_x;
  wire mod$EN_get, mod$EN_put, mod$RDY_get, mod$RDY_put;

  // submodule mod
  mkEllBMVM #(.lut_num(32'd0)) mod(.CLK(CLK),
				   .RST_N(RST_N),
				   .put_x(mod$put_x),
				   .EN_get(mod$EN_get),
				   .EN_put(mod$EN_put),
				   .get(mod$get),
				   .RDY_get(mod$RDY_get),
				   .RDY_put(mod$RDY_put));

  // submodule mod
  assign mod$put_x = 32'hFFFFFFFF ;
  assign mod$EN_get = mod$RDY_get ;
  assign mod$EN_put = mod$RDY_put ;

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

