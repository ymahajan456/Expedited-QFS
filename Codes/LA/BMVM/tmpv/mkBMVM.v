//
// Generated by Bluespec Compiler, version 2014.05.C (build 33930, 2014-05-28)
//
// On Fri May  4 03:02:51 IST 2018
//
//
// Ports:
// Name                         I/O  size props
// get                            O     3
// RDY_get                        O     1 const
// RDY_put                        O     1 const
// CLK                            I     1 clock
// RST_N                          I     1 reset
// put_x                          I     3 reg
// EN_put                         I     1
// EN_get                         I     1 unused
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

module mkBMVM(CLK,
	      RST_N,

	      EN_get,
	      get,
	      RDY_get,

	      put_x,
	      EN_put,
	      RDY_put);
  input  CLK;
  input  RST_N;

  // actionvalue method get
  input  EN_get;
  output [2 : 0] get;
  output RDY_get;

  // action method put
  input  [2 : 0] put_x;
  input  EN_put;
  output RDY_put;

  // signals for module outputs
  wire [2 : 0] get;
  wire RDY_get, RDY_put;

  // register start_bit
  reg start_bit;
  wire start_bit$D_IN, start_bit$EN;

  // register x_in
  reg [2 : 0] x_in;
  wire [2 : 0] x_in$D_IN;
  wire x_in$EN;

  // remaining internal signals
  wire [2 : 0] IF_x_in_BIT_1_THEN_1_ELSE_0___d3;
  wire x__h2158;

  // actionvalue method get
  assign get =
	     { x__h2158 ^ x_in[2],
	       IF_x_in_BIT_1_THEN_1_ELSE_0___d3[1] ^ x_in[1],
	       IF_x_in_BIT_1_THEN_1_ELSE_0___d3[0] ^ x_in[2] } ;
  assign RDY_get = 1'd1 ;

  // action method put
  assign RDY_put = 1'd1 ;

  // register start_bit
  assign start_bit$D_IN = 1'b0 ;
  assign start_bit$EN = 1'b0 ;

  // register x_in
  assign x_in$D_IN = put_x ;
  assign x_in$EN = EN_put ;

  // remaining internal signals
  assign IF_x_in_BIT_1_THEN_1_ELSE_0___d3 = x_in[1] ? 3'd1 : 3'd0 ;
  assign x__h2158 = IF_x_in_BIT_1_THEN_1_ELSE_0___d3[2] ^ x_in[0] ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        start_bit <= `BSV_ASSIGNMENT_DELAY 1'd0;
	x_in <= `BSV_ASSIGNMENT_DELAY 3'd0;
      end
    else
      begin
        if (start_bit$EN) start_bit <= `BSV_ASSIGNMENT_DELAY start_bit$D_IN;
	if (x_in$EN) x_in <= `BSV_ASSIGNMENT_DELAY x_in$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    start_bit = 1'h0;
    x_in = 3'h2;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkBMVM

