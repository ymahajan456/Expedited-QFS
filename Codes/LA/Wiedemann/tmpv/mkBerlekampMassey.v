//
// Generated by Bluespec Compiler, version 2014.05.C (build 33930, 2014-05-28)
//
// On Fri May  4 10:07:22 IST 2018
//
//
// Ports:
// Name                         I/O  size props
// RDY_start                      O     1 const
// RDY_polynomial__write          O     1 reg
// polynomial__read               O     3 reg
// RDY_polynomial__read           O     1 reg
// RDY_poly_length__write         O     1 reg
// poly_length__read              O    32 reg
// RDY_poly_length__read          O     1 reg
// outputValid                    O    32 reg
// RDY_outputValid                O     1 const
// CLK                            I     1 clock
// RST_N                          I     1 reset
// start_s_in                     I     3 reg
// polynomial__write_1            I     3
// poly_length__write_1           I    32
// EN_start                       I     1
// EN_polynomial__write           I     1
// EN_poly_length__write          I     1
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

module mkBerlekampMassey(CLK,
			 RST_N,

			 start_s_in,
			 EN_start,
			 RDY_start,

			 polynomial__write_1,
			 EN_polynomial__write,
			 RDY_polynomial__write,

			 polynomial__read,
			 RDY_polynomial__read,

			 poly_length__write_1,
			 EN_poly_length__write,
			 RDY_poly_length__write,

			 poly_length__read,
			 RDY_poly_length__read,

			 outputValid,
			 RDY_outputValid);
  input  CLK;
  input  RST_N;

  // action method start
  input  [2 : 0] start_s_in;
  input  EN_start;
  output RDY_start;

  // action method polynomial__write
  input  [2 : 0] polynomial__write_1;
  input  EN_polynomial__write;
  output RDY_polynomial__write;

  // value method polynomial__read
  output [2 : 0] polynomial__read;
  output RDY_polynomial__read;

  // action method poly_length__write
  input  [31 : 0] poly_length__write_1;
  input  EN_poly_length__write;
  output RDY_poly_length__write;

  // value method poly_length__read
  output [31 : 0] poly_length__read;
  output RDY_poly_length__read;

  // value method outputValid
  output [31 : 0] outputValid;
  output RDY_outputValid;

  // signals for module outputs
  wire [31 : 0] outputValid, poly_length__read;
  wire [2 : 0] polynomial__read;
  wire RDY_outputValid,
       RDY_poly_length__read,
       RDY_poly_length__write,
       RDY_polynomial__read,
       RDY_polynomial__write,
       RDY_start;

  // register b
  reg [2 : 0] b;
  wire [2 : 0] b$D_IN;
  wire b$EN;

  // register c
  reg [2 : 0] c;
  reg [2 : 0] c$D_IN;
  wire c$EN;

  // register l
  reg [31 : 0] l;
  reg [31 : 0] l$D_IN;
  wire l$EN;

  // register m
  reg [31 : 0] m;
  wire [31 : 0] m$D_IN;
  wire m$EN;

  // register out_en
  reg out_en;
  wire out_en$D_IN, out_en$EN;

  // register outputDone
  reg [31 : 0] outputDone;
  wire [31 : 0] outputDone$D_IN;
  wire outputDone$EN;

  // register s
  reg [2 : 0] s;
  wire [2 : 0] s$D_IN;
  wire s$EN;

  // register state
  reg [1 : 0] state;
  reg [1 : 0] state$D_IN;
  wire state$EN;

  // register x
  reg [31 : 0] x;
  wire [31 : 0] x$D_IN;
  wire x$EN;

  // inputs to muxes for submodule ports
  wire [31 : 0] MUX_l$write_1__VAL_3, MUX_x$write_1__VAL_2;
  wire [2 : 0] MUX_c$write_1__VAL_3;
  wire MUX_c$write_1__SEL_3, MUX_l$write_1__SEL_3, MUX_state$write_1__SEL_3;

  // remaining internal signals
  wire [31 : 0] l_PLUS_1___d4,
		m_PLUS_1___d28,
		x_0_MINUS_1___d34,
		x_0_PLUS_1___d31,
		x__h1046,
		x__h1159,
		x__h1273,
		x__h738,
		x__h821;
  wire [2 : 0] IF_x_0_MINUS_1_4_BIT_31_7_THEN_c_1_BITS_2_TO_1_ETC___d46,
	       IF_x_0_MINUS_1_4_SLT_1_6_THEN_IF_x_0_MINUS_1_4_ETC___d55,
	       result__h911,
	       result__h933,
	       result__h955;
  wire IF_l_PLUS_1_SLE_1_THEN_s_BIT_m_BITS_1_TO_0_0_E_ETC___d18,
       IF_l_PLUS_1_SLE_2_THEN_IF_l_PLUS_1_SLE_1_THEN__ETC___d25,
       discrepancy__h579,
       discrepancy__h599,
       l_BITS_30_TO_0_6_CONCAT_0_7_SLT_m_PLUS_1_8___d29,
       x__h613,
       y__h594,
       y__h614,
       y__h650,
       y__h742;

  // action method start
  assign RDY_start = 1'd1 ;

  // action method polynomial__write
  assign RDY_polynomial__write = out_en ;

  // value method polynomial__read
  assign polynomial__read = c ;
  assign RDY_polynomial__read = out_en ;

  // action method poly_length__write
  assign RDY_poly_length__write = out_en ;

  // value method poly_length__read
  assign poly_length__read = l ;
  assign RDY_poly_length__read = out_en ;

  // value method outputValid
  assign outputValid = outputDone ;
  assign RDY_outputValid = 1'd1 ;

  // inputs to muxes for submodule ports
  assign MUX_c$write_1__SEL_3 =
	     state == 2'd1 &&
	     IF_l_PLUS_1_SLE_2_THEN_IF_l_PLUS_1_SLE_1_THEN__ETC___d25 ;
  assign MUX_l$write_1__SEL_3 =
	     state == 2'd1 &&
	     IF_l_PLUS_1_SLE_2_THEN_IF_l_PLUS_1_SLE_1_THEN__ETC___d25 &&
	     l_BITS_30_TO_0_6_CONCAT_0_7_SLT_m_PLUS_1_8___d29 ;
  assign MUX_state$write_1__SEL_3 = state == 2'd1 && m == 32'd2 ;
  assign MUX_c$write_1__VAL_3 =
	     ((x_0_MINUS_1___d34 ^ 32'h80000000) < 32'h80000002) ?
	       result__h911 :
	       IF_x_0_MINUS_1_4_SLT_1_6_THEN_IF_x_0_MINUS_1_4_ETC___d55 ;
  assign MUX_l$write_1__VAL_3 = m_PLUS_1___d28 - l ;
  assign MUX_x$write_1__VAL_2 =
	     IF_l_PLUS_1_SLE_2_THEN_IF_l_PLUS_1_SLE_1_THEN__ETC___d25 ?
	       (l_BITS_30_TO_0_6_CONCAT_0_7_SLT_m_PLUS_1_8___d29 ?
		  32'd1 :
		  x_0_PLUS_1___d31) :
	       x_0_PLUS_1___d31 ;

  // register b
  assign b$D_IN = c ;
  assign b$EN = MUX_l$write_1__SEL_3 ;

  // register c
  always@(EN_start or
	  EN_polynomial__write or
	  polynomial__write_1 or MUX_c$write_1__SEL_3 or MUX_c$write_1__VAL_3)
  case (1'b1)
    EN_start: c$D_IN = 3'd1;
    EN_polynomial__write: c$D_IN = polynomial__write_1;
    MUX_c$write_1__SEL_3: c$D_IN = MUX_c$write_1__VAL_3;
    default: c$D_IN = 3'b010 /* unspecified value */ ;
  endcase
  assign c$EN =
	     state == 2'd1 &&
	     IF_l_PLUS_1_SLE_2_THEN_IF_l_PLUS_1_SLE_1_THEN__ETC___d25 ||
	     EN_polynomial__write ||
	     EN_start ;

  // register l
  always@(EN_start or
	  EN_poly_length__write or
	  poly_length__write_1 or
	  MUX_l$write_1__SEL_3 or MUX_l$write_1__VAL_3)
  case (1'b1)
    EN_start: l$D_IN = 32'd0;
    EN_poly_length__write: l$D_IN = poly_length__write_1;
    MUX_l$write_1__SEL_3: l$D_IN = MUX_l$write_1__VAL_3;
    default: l$D_IN = 32'hAAAAAAAA /* unspecified value */ ;
  endcase
  assign l$EN =
	     state == 2'd1 &&
	     IF_l_PLUS_1_SLE_2_THEN_IF_l_PLUS_1_SLE_1_THEN__ETC___d25 &&
	     l_BITS_30_TO_0_6_CONCAT_0_7_SLT_m_PLUS_1_8___d29 ||
	     EN_poly_length__write ||
	     EN_start ;

  // register m
  assign m$D_IN = (EN_start || state == 2'd2) ? 32'd0 : m_PLUS_1___d28 ;
  assign m$EN = state == 2'd1 || state == 2'd2 || EN_start ;

  // register out_en
  assign out_en$D_IN = 1'd1 ;
  assign out_en$EN = state == 2'd2 ;

  // register outputDone
  assign outputDone$D_IN = 32'd1 ;
  assign outputDone$EN = state == 2'd2 ;

  // register s
  assign s$D_IN = start_s_in ;
  assign s$EN = EN_start ;

  // register state
  always@(EN_start or state or MUX_state$write_1__SEL_3)
  case (1'b1)
    EN_start: state$D_IN = 2'd1;
    state == 2'd2: state$D_IN = 2'd0;
    MUX_state$write_1__SEL_3: state$D_IN = 2'd2;
    default: state$D_IN = 2'b10 /* unspecified value */ ;
  endcase
  assign state$EN = state == 2'd1 && m == 32'd2 || state == 2'd2 || EN_start ;

  // register x
  assign x$D_IN = EN_start ? 32'd1 : MUX_x$write_1__VAL_2 ;
  assign x$EN = state == 2'd1 || EN_start ;

  // remaining internal signals
  assign IF_l_PLUS_1_SLE_1_THEN_s_BIT_m_BITS_1_TO_0_0_E_ETC___d18 =
	     ((l_PLUS_1___d4 ^ 32'h80000000) <= 32'h80000001) ?
	       x__h613 :
	       discrepancy__h599 ;
  assign IF_l_PLUS_1_SLE_2_THEN_IF_l_PLUS_1_SLE_1_THEN__ETC___d25 =
	     ((l_PLUS_1___d4 ^ 32'h80000000) <= 32'h80000002) ?
	       IF_l_PLUS_1_SLE_1_THEN_s_BIT_m_BITS_1_TO_0_0_E_ETC___d18 :
	       discrepancy__h579 ;
  assign IF_x_0_MINUS_1_4_BIT_31_7_THEN_c_1_BITS_2_TO_1_ETC___d46 =
	     x_0_MINUS_1___d34[31] ? result__h955 : c ;
  assign IF_x_0_MINUS_1_4_SLT_1_6_THEN_IF_x_0_MINUS_1_4_ETC___d55 =
	     ((x_0_MINUS_1___d34 ^ 32'h80000000) < 32'h80000001) ?
	       result__h933 :
	       IF_x_0_MINUS_1_4_BIT_31_7_THEN_c_1_BITS_2_TO_1_ETC___d46 ;
  assign discrepancy__h579 =
	     IF_l_PLUS_1_SLE_1_THEN_s_BIT_m_BITS_1_TO_0_0_E_ETC___d18 ^
	     y__h594 ;
  assign discrepancy__h599 = x__h613 ^ y__h614 ;
  assign l_BITS_30_TO_0_6_CONCAT_0_7_SLT_m_PLUS_1_8___d29 =
	     ({ l[30:0], 1'd0 } ^ 32'h80000000) <
	     (m_PLUS_1___d28 ^ 32'h80000000) ;
  assign l_PLUS_1___d4 = l + 32'd1 ;
  assign m_PLUS_1___d28 = m + 32'd1 ;
  assign result__h911 =
	     { IF_x_0_MINUS_1_4_SLT_1_6_THEN_IF_x_0_MINUS_1_4_ETC___d55[2] ^
	       b[x__h1273[1:0]],
	       IF_x_0_MINUS_1_4_SLT_1_6_THEN_IF_x_0_MINUS_1_4_ETC___d55[1:0] } ;
  assign result__h933 =
	     { IF_x_0_MINUS_1_4_BIT_31_7_THEN_c_1_BITS_2_TO_1_ETC___d46[2],
	       IF_x_0_MINUS_1_4_BIT_31_7_THEN_c_1_BITS_2_TO_1_ETC___d46[1] ^
	       b[x__h1159[1:0]],
	       IF_x_0_MINUS_1_4_BIT_31_7_THEN_c_1_BITS_2_TO_1_ETC___d46[0] } ;
  assign result__h955 = { c[2:1], c[0] ^ b[x__h1046[1:0]] } ;
  assign x_0_MINUS_1___d34 = x - 32'd1 ;
  assign x_0_PLUS_1___d31 = x + 32'd1 ;
  assign x__h1046 = 32'd0 - x ;
  assign x__h1159 = 32'd1 - x ;
  assign x__h1273 = 32'd2 - x ;
  assign x__h613 = s[m[1:0]] ;
  assign x__h738 = m - 32'd1 ;
  assign x__h821 = m - 32'd2 ;
  assign y__h594 = c[2] & y__h742 ;
  assign y__h614 = c[1] & y__h650 ;
  assign y__h650 = s[x__h738[1:0]] ;
  assign y__h742 = s[x__h821[1:0]] ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        b <= `BSV_ASSIGNMENT_DELAY 3'd1;
	c <= `BSV_ASSIGNMENT_DELAY 3'd1;
	l <= `BSV_ASSIGNMENT_DELAY 32'd0;
	m <= `BSV_ASSIGNMENT_DELAY 32'd0;
	out_en <= `BSV_ASSIGNMENT_DELAY 1'd0;
	s <= `BSV_ASSIGNMENT_DELAY 3'd0;
	state <= `BSV_ASSIGNMENT_DELAY 2'd0;
	x <= `BSV_ASSIGNMENT_DELAY 32'd1;
      end
    else
      begin
        if (b$EN) b <= `BSV_ASSIGNMENT_DELAY b$D_IN;
	if (c$EN) c <= `BSV_ASSIGNMENT_DELAY c$D_IN;
	if (l$EN) l <= `BSV_ASSIGNMENT_DELAY l$D_IN;
	if (m$EN) m <= `BSV_ASSIGNMENT_DELAY m$D_IN;
	if (out_en$EN) out_en <= `BSV_ASSIGNMENT_DELAY out_en$D_IN;
	if (s$EN) s <= `BSV_ASSIGNMENT_DELAY s$D_IN;
	if (state$EN) state <= `BSV_ASSIGNMENT_DELAY state$D_IN;
	if (x$EN) x <= `BSV_ASSIGNMENT_DELAY x$D_IN;
      end
    if (outputDone$EN) outputDone <= `BSV_ASSIGNMENT_DELAY outputDone$D_IN;
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    b = 3'h2;
    c = 3'h2;
    l = 32'hAAAAAAAA;
    m = 32'hAAAAAAAA;
    out_en = 1'h0;
    outputDone = 32'hAAAAAAAA;
    s = 3'h2;
    state = 2'h2;
    x = 32'hAAAAAAAA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkBerlekampMassey

