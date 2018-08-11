//
// Generated by Bluespec Compiler, version 2014.05.C (build 33930, 2014-05-28)
//
// On Fri May  4 03:02:51 IST 2018
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

  // register i
  reg [31 : 0] i;
  wire [31 : 0] i$D_IN;
  wire i$EN;

  // ports of submodule ifc
  wire [2 : 0] ifc$get, ifc$put_x;
  wire ifc$EN_get, ifc$EN_put;

  // submodule ifc
  mkBMVM ifc(.CLK(CLK),
	     .RST_N(RST_N),
	     .put_x(ifc$put_x),
	     .EN_get(ifc$EN_get),
	     .EN_put(ifc$EN_put),
	     .get(ifc$get),
	     .RDY_get(),
	     .RDY_put());

  // register i
  assign i$D_IN = i + 32'd1 ;
  assign i$EN = i == 32'd0 ;

  // submodule ifc
  assign ifc$put_x = 3'b100 ;
  assign ifc$EN_get = i == 32'd1 ;
  assign ifc$EN_put = i == 32'd0 ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        i <= `BSV_ASSIGNMENT_DELAY 32'd0;
      end
    else
      begin
        if (i$EN) i <= `BSV_ASSIGNMENT_DELAY i$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    i = 32'hAAAAAAAA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on

  // handling of system tasks

  // synopsys translate_off
  always@(negedge CLK)
  begin
    #0;
    if (RST_N != `BSV_RESET_VALUE)
      if (i == 32'd1) $display("Output Vector= %b", ifc$get);
    if (RST_N != `BSV_RESET_VALUE) if (i == 32'd1) $finish(32'd0);
  end
  // synopsys translate_on
endmodule  // mkTb
