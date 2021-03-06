//
// Generated by Bluespec Compiler, version 2014.05.C (build 33930, 2014-05-28)
//
// On Fri May  4 00:42:29 IST 2018
//
//
// Ports:
// Name                         I/O  size props
// RDY_start                      O     1 const
// RDY_polynomial__write          O     1 reg
// polynomial__read               O    12 reg
// RDY_polynomial__read           O     1 reg
// RDY_poly_length__write         O     1 reg
// poly_length__read              O    32 reg
// RDY_poly_length__read          O     1 reg
// outputValid                    O    32 reg
// RDY_outputValid                O     1 const
// CLK                            I     1 clock
// RST_N                          I     1 reset
// start_s_in                     I    12 reg
// polynomial__write_1            I    12
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
  input  [11 : 0] start_s_in;
  input  EN_start;
  output RDY_start;

  // action method polynomial__write
  input  [11 : 0] polynomial__write_1;
  input  EN_polynomial__write;
  output RDY_polynomial__write;

  // value method polynomial__read
  output [11 : 0] polynomial__read;
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
  wire [11 : 0] polynomial__read;
  wire RDY_outputValid,
       RDY_poly_length__read,
       RDY_poly_length__write,
       RDY_polynomial__read,
       RDY_polynomial__write,
       RDY_start;

  // register b
  reg [11 : 0] b;
  wire [11 : 0] b$D_IN;
  wire b$EN;

  // register c
  reg [11 : 0] c;
  reg [11 : 0] c$D_IN;
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
  reg [11 : 0] s;
  wire [11 : 0] s$D_IN;
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
  wire [11 : 0] MUX_c$write_1__VAL_3;
  wire MUX_c$write_1__SEL_3, MUX_l$write_1__SEL_3, MUX_state$write_1__SEL_3;

  // remaining internal signals
  wire [31 : 0] l_PLUS_1___d4,
		m_7_PLUS_1___d100,
		x_02_MINUS_1___d106,
		x_02_PLUS_1___d103,
		x__h1064,
		x__h1147,
		x__h1230,
		x__h1313,
		x__h1396,
		x__h1479,
		x__h1562,
		x__h1645,
		x__h1728,
		x__h1811,
		x__h2297,
		x__h2410,
		x__h2524,
		x__h2638,
		x__h2752,
		x__h2866,
		x__h2980,
		x__h3094,
		x__h3208,
		x__h3322,
		x__h3436,
		x__h3550,
		x__h981;
  wire [11 : 0] IF_x_02_MINUS_1_06_BIT_31_18_THEN_c_0_BITS_11__ETC___d127,
		IF_x_02_MINUS_1_06_SLT_10_08_THEN_IF_x_02_MINU_ETC___d217,
		IF_x_02_MINUS_1_06_SLT_1_17_THEN_IF_x_02_MINUS_ETC___d136,
		IF_x_02_MINUS_1_06_SLT_2_16_THEN_IF_x_02_MINUS_ETC___d145,
		IF_x_02_MINUS_1_06_SLT_3_15_THEN_IF_x_02_MINUS_ETC___d154,
		IF_x_02_MINUS_1_06_SLT_4_14_THEN_IF_x_02_MINUS_ETC___d163,
		IF_x_02_MINUS_1_06_SLT_5_13_THEN_IF_x_02_MINUS_ETC___d172,
		IF_x_02_MINUS_1_06_SLT_6_12_THEN_IF_x_02_MINUS_ETC___d181,
		IF_x_02_MINUS_1_06_SLT_7_11_THEN_IF_x_02_MINUS_ETC___d190,
		IF_x_02_MINUS_1_06_SLT_8_10_THEN_IF_x_02_MINUS_ETC___d199,
		IF_x_02_MINUS_1_06_SLT_9_09_THEN_IF_x_02_MINUS_ETC___d208,
		result__h1964,
		result__h1986,
		result__h2008,
		result__h2030,
		result__h2052,
		result__h2074,
		result__h2096,
		result__h2118,
		result__h2140,
		result__h2162,
		result__h2184,
		result__h2206;
  wire IF_l_PLUS_1_SLE_10_THEN_IF_l_PLUS_1_SLE_9_THEN_ETC___d90,
       IF_l_PLUS_1_SLE_11_THEN_IF_l_PLUS_1_SLE_10_THE_ETC___d97,
       IF_l_PLUS_1_SLE_1_5_THEN_s_6_BIT_m_7_BITS_3_TO_ETC___d27,
       IF_l_PLUS_1_SLE_2_4_THEN_IF_l_PLUS_1_SLE_1_5_T_ETC___d34,
       IF_l_PLUS_1_SLE_3_3_THEN_IF_l_PLUS_1_SLE_2_4_T_ETC___d41,
       IF_l_PLUS_1_SLE_4_2_THEN_IF_l_PLUS_1_SLE_3_3_T_ETC___d48,
       IF_l_PLUS_1_SLE_5_1_THEN_IF_l_PLUS_1_SLE_4_2_T_ETC___d55,
       IF_l_PLUS_1_SLE_6_0_THEN_IF_l_PLUS_1_SLE_5_1_T_ETC___d62,
       IF_l_PLUS_1_SLE_7_THEN_IF_l_PLUS_1_SLE_6_0_THE_ETC___d69,
       IF_l_PLUS_1_SLE_8_THEN_IF_l_PLUS_1_SLE_7_THEN__ETC___d76,
       IF_l_PLUS_1_SLE_9_THEN_IF_l_PLUS_1_SLE_8_THEN__ETC___d83,
       discrepancy__h642,
       discrepancy__h662,
       discrepancy__h682,
       discrepancy__h702,
       discrepancy__h722,
       discrepancy__h742,
       discrepancy__h762,
       discrepancy__h782,
       discrepancy__h802,
       discrepancy__h822,
       discrepancy__h842,
       l_BITS_30_TO_0_8_CONCAT_0_9_SLT_m_7_PLUS_1_00___d101,
       x__h856,
       y__h1068,
       y__h1151,
       y__h1234,
       y__h1317,
       y__h1400,
       y__h1483,
       y__h1566,
       y__h1649,
       y__h1732,
       y__h657,
       y__h677,
       y__h697,
       y__h717,
       y__h737,
       y__h757,
       y__h777,
       y__h797,
       y__h817,
       y__h837,
       y__h857,
       y__h893,
       y__h985;

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
	     IF_l_PLUS_1_SLE_11_THEN_IF_l_PLUS_1_SLE_10_THE_ETC___d97 ;
  assign MUX_l$write_1__SEL_3 =
	     state == 2'd1 &&
	     IF_l_PLUS_1_SLE_11_THEN_IF_l_PLUS_1_SLE_10_THE_ETC___d97 &&
	     l_BITS_30_TO_0_8_CONCAT_0_9_SLT_m_7_PLUS_1_00___d101 ;
  assign MUX_state$write_1__SEL_3 = state == 2'd1 && m == 32'd11 ;
  assign MUX_c$write_1__VAL_3 =
	     ((x_02_MINUS_1___d106 ^ 32'h80000000) < 32'h8000000B) ?
	       result__h1964 :
	       IF_x_02_MINUS_1_06_SLT_10_08_THEN_IF_x_02_MINU_ETC___d217 ;
  assign MUX_l$write_1__VAL_3 = m_7_PLUS_1___d100 - l ;
  assign MUX_x$write_1__VAL_2 =
	     IF_l_PLUS_1_SLE_11_THEN_IF_l_PLUS_1_SLE_10_THE_ETC___d97 ?
	       (l_BITS_30_TO_0_8_CONCAT_0_9_SLT_m_7_PLUS_1_00___d101 ?
		  32'd1 :
		  x_02_PLUS_1___d103) :
	       x_02_PLUS_1___d103 ;

  // register b
  assign b$D_IN = c ;
  assign b$EN = MUX_l$write_1__SEL_3 ;

  // register c
  always@(EN_start or
	  EN_polynomial__write or
	  polynomial__write_1 or MUX_c$write_1__SEL_3 or MUX_c$write_1__VAL_3)
  case (1'b1)
    EN_start: c$D_IN = 12'd1;
    EN_polynomial__write: c$D_IN = polynomial__write_1;
    MUX_c$write_1__SEL_3: c$D_IN = MUX_c$write_1__VAL_3;
    default: c$D_IN = 12'b101010101010 /* unspecified value */ ;
  endcase
  assign c$EN =
	     state == 2'd1 &&
	     IF_l_PLUS_1_SLE_11_THEN_IF_l_PLUS_1_SLE_10_THE_ETC___d97 ||
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
	     IF_l_PLUS_1_SLE_11_THEN_IF_l_PLUS_1_SLE_10_THE_ETC___d97 &&
	     l_BITS_30_TO_0_8_CONCAT_0_9_SLT_m_7_PLUS_1_00___d101 ||
	     EN_poly_length__write ||
	     EN_start ;

  // register m
  assign m$D_IN = (EN_start || state == 2'd2) ? 32'd0 : m_7_PLUS_1___d100 ;
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
  assign state$EN =
	     state == 2'd1 && m == 32'd11 || state == 2'd2 || EN_start ;

  // register x
  assign x$D_IN = EN_start ? 32'd1 : MUX_x$write_1__VAL_2 ;
  assign x$EN = state == 2'd1 || EN_start ;

  // remaining internal signals
  assign IF_l_PLUS_1_SLE_10_THEN_IF_l_PLUS_1_SLE_9_THEN_ETC___d90 =
	     ((l_PLUS_1___d4 ^ 32'h80000000) <= 32'h8000000A) ?
	       IF_l_PLUS_1_SLE_9_THEN_IF_l_PLUS_1_SLE_8_THEN__ETC___d83 :
	       discrepancy__h662 ;
  assign IF_l_PLUS_1_SLE_11_THEN_IF_l_PLUS_1_SLE_10_THE_ETC___d97 =
	     ((l_PLUS_1___d4 ^ 32'h80000000) <= 32'h8000000B) ?
	       IF_l_PLUS_1_SLE_10_THEN_IF_l_PLUS_1_SLE_9_THEN_ETC___d90 :
	       discrepancy__h642 ;
  assign IF_l_PLUS_1_SLE_1_5_THEN_s_6_BIT_m_7_BITS_3_TO_ETC___d27 =
	     ((l_PLUS_1___d4 ^ 32'h80000000) <= 32'h80000001) ?
	       x__h856 :
	       discrepancy__h842 ;
  assign IF_l_PLUS_1_SLE_2_4_THEN_IF_l_PLUS_1_SLE_1_5_T_ETC___d34 =
	     ((l_PLUS_1___d4 ^ 32'h80000000) <= 32'h80000002) ?
	       IF_l_PLUS_1_SLE_1_5_THEN_s_6_BIT_m_7_BITS_3_TO_ETC___d27 :
	       discrepancy__h822 ;
  assign IF_l_PLUS_1_SLE_3_3_THEN_IF_l_PLUS_1_SLE_2_4_T_ETC___d41 =
	     ((l_PLUS_1___d4 ^ 32'h80000000) <= 32'h80000003) ?
	       IF_l_PLUS_1_SLE_2_4_THEN_IF_l_PLUS_1_SLE_1_5_T_ETC___d34 :
	       discrepancy__h802 ;
  assign IF_l_PLUS_1_SLE_4_2_THEN_IF_l_PLUS_1_SLE_3_3_T_ETC___d48 =
	     ((l_PLUS_1___d4 ^ 32'h80000000) <= 32'h80000004) ?
	       IF_l_PLUS_1_SLE_3_3_THEN_IF_l_PLUS_1_SLE_2_4_T_ETC___d41 :
	       discrepancy__h782 ;
  assign IF_l_PLUS_1_SLE_5_1_THEN_IF_l_PLUS_1_SLE_4_2_T_ETC___d55 =
	     ((l_PLUS_1___d4 ^ 32'h80000000) <= 32'h80000005) ?
	       IF_l_PLUS_1_SLE_4_2_THEN_IF_l_PLUS_1_SLE_3_3_T_ETC___d48 :
	       discrepancy__h762 ;
  assign IF_l_PLUS_1_SLE_6_0_THEN_IF_l_PLUS_1_SLE_5_1_T_ETC___d62 =
	     ((l_PLUS_1___d4 ^ 32'h80000000) <= 32'h80000006) ?
	       IF_l_PLUS_1_SLE_5_1_THEN_IF_l_PLUS_1_SLE_4_2_T_ETC___d55 :
	       discrepancy__h742 ;
  assign IF_l_PLUS_1_SLE_7_THEN_IF_l_PLUS_1_SLE_6_0_THE_ETC___d69 =
	     ((l_PLUS_1___d4 ^ 32'h80000000) <= 32'h80000007) ?
	       IF_l_PLUS_1_SLE_6_0_THEN_IF_l_PLUS_1_SLE_5_1_T_ETC___d62 :
	       discrepancy__h722 ;
  assign IF_l_PLUS_1_SLE_8_THEN_IF_l_PLUS_1_SLE_7_THEN__ETC___d76 =
	     ((l_PLUS_1___d4 ^ 32'h80000000) <= 32'h80000008) ?
	       IF_l_PLUS_1_SLE_7_THEN_IF_l_PLUS_1_SLE_6_0_THE_ETC___d69 :
	       discrepancy__h702 ;
  assign IF_l_PLUS_1_SLE_9_THEN_IF_l_PLUS_1_SLE_8_THEN__ETC___d83 =
	     ((l_PLUS_1___d4 ^ 32'h80000000) <= 32'h80000009) ?
	       IF_l_PLUS_1_SLE_8_THEN_IF_l_PLUS_1_SLE_7_THEN__ETC___d76 :
	       discrepancy__h682 ;
  assign IF_x_02_MINUS_1_06_BIT_31_18_THEN_c_0_BITS_11__ETC___d127 =
	     x_02_MINUS_1___d106[31] ? result__h2206 : c ;
  assign IF_x_02_MINUS_1_06_SLT_10_08_THEN_IF_x_02_MINU_ETC___d217 =
	     ((x_02_MINUS_1___d106 ^ 32'h80000000) < 32'h8000000A) ?
	       result__h1986 :
	       IF_x_02_MINUS_1_06_SLT_9_09_THEN_IF_x_02_MINUS_ETC___d208 ;
  assign IF_x_02_MINUS_1_06_SLT_1_17_THEN_IF_x_02_MINUS_ETC___d136 =
	     ((x_02_MINUS_1___d106 ^ 32'h80000000) < 32'h80000001) ?
	       result__h2184 :
	       IF_x_02_MINUS_1_06_BIT_31_18_THEN_c_0_BITS_11__ETC___d127 ;
  assign IF_x_02_MINUS_1_06_SLT_2_16_THEN_IF_x_02_MINUS_ETC___d145 =
	     ((x_02_MINUS_1___d106 ^ 32'h80000000) < 32'h80000002) ?
	       result__h2162 :
	       IF_x_02_MINUS_1_06_SLT_1_17_THEN_IF_x_02_MINUS_ETC___d136 ;
  assign IF_x_02_MINUS_1_06_SLT_3_15_THEN_IF_x_02_MINUS_ETC___d154 =
	     ((x_02_MINUS_1___d106 ^ 32'h80000000) < 32'h80000003) ?
	       result__h2140 :
	       IF_x_02_MINUS_1_06_SLT_2_16_THEN_IF_x_02_MINUS_ETC___d145 ;
  assign IF_x_02_MINUS_1_06_SLT_4_14_THEN_IF_x_02_MINUS_ETC___d163 =
	     ((x_02_MINUS_1___d106 ^ 32'h80000000) < 32'h80000004) ?
	       result__h2118 :
	       IF_x_02_MINUS_1_06_SLT_3_15_THEN_IF_x_02_MINUS_ETC___d154 ;
  assign IF_x_02_MINUS_1_06_SLT_5_13_THEN_IF_x_02_MINUS_ETC___d172 =
	     ((x_02_MINUS_1___d106 ^ 32'h80000000) < 32'h80000005) ?
	       result__h2096 :
	       IF_x_02_MINUS_1_06_SLT_4_14_THEN_IF_x_02_MINUS_ETC___d163 ;
  assign IF_x_02_MINUS_1_06_SLT_6_12_THEN_IF_x_02_MINUS_ETC___d181 =
	     ((x_02_MINUS_1___d106 ^ 32'h80000000) < 32'h80000006) ?
	       result__h2074 :
	       IF_x_02_MINUS_1_06_SLT_5_13_THEN_IF_x_02_MINUS_ETC___d172 ;
  assign IF_x_02_MINUS_1_06_SLT_7_11_THEN_IF_x_02_MINUS_ETC___d190 =
	     ((x_02_MINUS_1___d106 ^ 32'h80000000) < 32'h80000007) ?
	       result__h2052 :
	       IF_x_02_MINUS_1_06_SLT_6_12_THEN_IF_x_02_MINUS_ETC___d181 ;
  assign IF_x_02_MINUS_1_06_SLT_8_10_THEN_IF_x_02_MINUS_ETC___d199 =
	     ((x_02_MINUS_1___d106 ^ 32'h80000000) < 32'h80000008) ?
	       result__h2030 :
	       IF_x_02_MINUS_1_06_SLT_7_11_THEN_IF_x_02_MINUS_ETC___d190 ;
  assign IF_x_02_MINUS_1_06_SLT_9_09_THEN_IF_x_02_MINUS_ETC___d208 =
	     ((x_02_MINUS_1___d106 ^ 32'h80000000) < 32'h80000009) ?
	       result__h2008 :
	       IF_x_02_MINUS_1_06_SLT_8_10_THEN_IF_x_02_MINUS_ETC___d199 ;
  assign discrepancy__h642 =
	     IF_l_PLUS_1_SLE_10_THEN_IF_l_PLUS_1_SLE_9_THEN_ETC___d90 ^
	     y__h657 ;
  assign discrepancy__h662 =
	     IF_l_PLUS_1_SLE_9_THEN_IF_l_PLUS_1_SLE_8_THEN__ETC___d83 ^
	     y__h677 ;
  assign discrepancy__h682 =
	     IF_l_PLUS_1_SLE_8_THEN_IF_l_PLUS_1_SLE_7_THEN__ETC___d76 ^
	     y__h697 ;
  assign discrepancy__h702 =
	     IF_l_PLUS_1_SLE_7_THEN_IF_l_PLUS_1_SLE_6_0_THE_ETC___d69 ^
	     y__h717 ;
  assign discrepancy__h722 =
	     IF_l_PLUS_1_SLE_6_0_THEN_IF_l_PLUS_1_SLE_5_1_T_ETC___d62 ^
	     y__h737 ;
  assign discrepancy__h742 =
	     IF_l_PLUS_1_SLE_5_1_THEN_IF_l_PLUS_1_SLE_4_2_T_ETC___d55 ^
	     y__h757 ;
  assign discrepancy__h762 =
	     IF_l_PLUS_1_SLE_4_2_THEN_IF_l_PLUS_1_SLE_3_3_T_ETC___d48 ^
	     y__h777 ;
  assign discrepancy__h782 =
	     IF_l_PLUS_1_SLE_3_3_THEN_IF_l_PLUS_1_SLE_2_4_T_ETC___d41 ^
	     y__h797 ;
  assign discrepancy__h802 =
	     IF_l_PLUS_1_SLE_2_4_THEN_IF_l_PLUS_1_SLE_1_5_T_ETC___d34 ^
	     y__h817 ;
  assign discrepancy__h822 =
	     IF_l_PLUS_1_SLE_1_5_THEN_s_6_BIT_m_7_BITS_3_TO_ETC___d27 ^
	     y__h837 ;
  assign discrepancy__h842 = x__h856 ^ y__h857 ;
  assign l_BITS_30_TO_0_8_CONCAT_0_9_SLT_m_7_PLUS_1_00___d101 =
	     ({ l[30:0], 1'd0 } ^ 32'h80000000) <
	     (m_7_PLUS_1___d100 ^ 32'h80000000) ;
  assign l_PLUS_1___d4 = l + 32'd1 ;
  assign m_7_PLUS_1___d100 = m + 32'd1 ;
  assign result__h1964 =
	     { IF_x_02_MINUS_1_06_SLT_10_08_THEN_IF_x_02_MINU_ETC___d217[11] ^
	       b[x__h3550[3:0]],
	       IF_x_02_MINUS_1_06_SLT_10_08_THEN_IF_x_02_MINU_ETC___d217[10:0] } ;
  assign result__h1986 =
	     { IF_x_02_MINUS_1_06_SLT_9_09_THEN_IF_x_02_MINUS_ETC___d208[11],
	       IF_x_02_MINUS_1_06_SLT_9_09_THEN_IF_x_02_MINUS_ETC___d208[10] ^
	       b[x__h3436[3:0]],
	       IF_x_02_MINUS_1_06_SLT_9_09_THEN_IF_x_02_MINUS_ETC___d208[9:0] } ;
  assign result__h2008 =
	     { IF_x_02_MINUS_1_06_SLT_8_10_THEN_IF_x_02_MINUS_ETC___d199[11:10],
	       IF_x_02_MINUS_1_06_SLT_8_10_THEN_IF_x_02_MINUS_ETC___d199[9] ^
	       b[x__h3322[3:0]],
	       IF_x_02_MINUS_1_06_SLT_8_10_THEN_IF_x_02_MINUS_ETC___d199[8:0] } ;
  assign result__h2030 =
	     { IF_x_02_MINUS_1_06_SLT_7_11_THEN_IF_x_02_MINUS_ETC___d190[11:9],
	       IF_x_02_MINUS_1_06_SLT_7_11_THEN_IF_x_02_MINUS_ETC___d190[8] ^
	       b[x__h3208[3:0]],
	       IF_x_02_MINUS_1_06_SLT_7_11_THEN_IF_x_02_MINUS_ETC___d190[7:0] } ;
  assign result__h2052 =
	     { IF_x_02_MINUS_1_06_SLT_6_12_THEN_IF_x_02_MINUS_ETC___d181[11:8],
	       IF_x_02_MINUS_1_06_SLT_6_12_THEN_IF_x_02_MINUS_ETC___d181[7] ^
	       b[x__h3094[3:0]],
	       IF_x_02_MINUS_1_06_SLT_6_12_THEN_IF_x_02_MINUS_ETC___d181[6:0] } ;
  assign result__h2074 =
	     { IF_x_02_MINUS_1_06_SLT_5_13_THEN_IF_x_02_MINUS_ETC___d172[11:7],
	       IF_x_02_MINUS_1_06_SLT_5_13_THEN_IF_x_02_MINUS_ETC___d172[6] ^
	       b[x__h2980[3:0]],
	       IF_x_02_MINUS_1_06_SLT_5_13_THEN_IF_x_02_MINUS_ETC___d172[5:0] } ;
  assign result__h2096 =
	     { IF_x_02_MINUS_1_06_SLT_4_14_THEN_IF_x_02_MINUS_ETC___d163[11:6],
	       IF_x_02_MINUS_1_06_SLT_4_14_THEN_IF_x_02_MINUS_ETC___d163[5] ^
	       b[x__h2866[3:0]],
	       IF_x_02_MINUS_1_06_SLT_4_14_THEN_IF_x_02_MINUS_ETC___d163[4:0] } ;
  assign result__h2118 =
	     { IF_x_02_MINUS_1_06_SLT_3_15_THEN_IF_x_02_MINUS_ETC___d154[11:5],
	       IF_x_02_MINUS_1_06_SLT_3_15_THEN_IF_x_02_MINUS_ETC___d154[4] ^
	       b[x__h2752[3:0]],
	       IF_x_02_MINUS_1_06_SLT_3_15_THEN_IF_x_02_MINUS_ETC___d154[3:0] } ;
  assign result__h2140 =
	     { IF_x_02_MINUS_1_06_SLT_2_16_THEN_IF_x_02_MINUS_ETC___d145[11:4],
	       IF_x_02_MINUS_1_06_SLT_2_16_THEN_IF_x_02_MINUS_ETC___d145[3] ^
	       b[x__h2638[3:0]],
	       IF_x_02_MINUS_1_06_SLT_2_16_THEN_IF_x_02_MINUS_ETC___d145[2:0] } ;
  assign result__h2162 =
	     { IF_x_02_MINUS_1_06_SLT_1_17_THEN_IF_x_02_MINUS_ETC___d136[11:3],
	       IF_x_02_MINUS_1_06_SLT_1_17_THEN_IF_x_02_MINUS_ETC___d136[2] ^
	       b[x__h2524[3:0]],
	       IF_x_02_MINUS_1_06_SLT_1_17_THEN_IF_x_02_MINUS_ETC___d136[1:0] } ;
  assign result__h2184 =
	     { IF_x_02_MINUS_1_06_BIT_31_18_THEN_c_0_BITS_11__ETC___d127[11:2],
	       IF_x_02_MINUS_1_06_BIT_31_18_THEN_c_0_BITS_11__ETC___d127[1] ^
	       b[x__h2410[3:0]],
	       IF_x_02_MINUS_1_06_BIT_31_18_THEN_c_0_BITS_11__ETC___d127[0] } ;
  assign result__h2206 = { c[11:1], c[0] ^ b[x__h2297[3:0]] } ;
  assign x_02_MINUS_1___d106 = x - 32'd1 ;
  assign x_02_PLUS_1___d103 = x + 32'd1 ;
  assign x__h1064 = m - 32'd2 ;
  assign x__h1147 = m - 32'd3 ;
  assign x__h1230 = m - 32'd4 ;
  assign x__h1313 = m - 32'd5 ;
  assign x__h1396 = m - 32'd6 ;
  assign x__h1479 = m - 32'd7 ;
  assign x__h1562 = m - 32'd8 ;
  assign x__h1645 = m - 32'd9 ;
  assign x__h1728 = m - 32'd10 ;
  assign x__h1811 = m - 32'd11 ;
  assign x__h2297 = 32'd0 - x ;
  assign x__h2410 = 32'd1 - x ;
  assign x__h2524 = 32'd2 - x ;
  assign x__h2638 = 32'd3 - x ;
  assign x__h2752 = 32'd4 - x ;
  assign x__h2866 = 32'd5 - x ;
  assign x__h2980 = 32'd6 - x ;
  assign x__h3094 = 32'd7 - x ;
  assign x__h3208 = 32'd8 - x ;
  assign x__h3322 = 32'd9 - x ;
  assign x__h3436 = 32'd10 - x ;
  assign x__h3550 = 32'd11 - x ;
  assign x__h856 = s[m[3:0]] ;
  assign x__h981 = m - 32'd1 ;
  assign y__h1068 = s[x__h1147[3:0]] ;
  assign y__h1151 = s[x__h1230[3:0]] ;
  assign y__h1234 = s[x__h1313[3:0]] ;
  assign y__h1317 = s[x__h1396[3:0]] ;
  assign y__h1400 = s[x__h1479[3:0]] ;
  assign y__h1483 = s[x__h1562[3:0]] ;
  assign y__h1566 = s[x__h1645[3:0]] ;
  assign y__h1649 = s[x__h1728[3:0]] ;
  assign y__h1732 = s[x__h1811[3:0]] ;
  assign y__h657 = c[11] & y__h1732 ;
  assign y__h677 = c[10] & y__h1649 ;
  assign y__h697 = c[9] & y__h1566 ;
  assign y__h717 = c[8] & y__h1483 ;
  assign y__h737 = c[7] & y__h1400 ;
  assign y__h757 = c[6] & y__h1317 ;
  assign y__h777 = c[5] & y__h1234 ;
  assign y__h797 = c[4] & y__h1151 ;
  assign y__h817 = c[3] & y__h1068 ;
  assign y__h837 = c[2] & y__h985 ;
  assign y__h857 = c[1] & y__h893 ;
  assign y__h893 = s[x__h981[3:0]] ;
  assign y__h985 = s[x__h1064[3:0]] ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        b <= `BSV_ASSIGNMENT_DELAY 12'd1;
	c <= `BSV_ASSIGNMENT_DELAY 12'd1;
	l <= `BSV_ASSIGNMENT_DELAY 32'd0;
	m <= `BSV_ASSIGNMENT_DELAY 32'd0;
	out_en <= `BSV_ASSIGNMENT_DELAY 1'd0;
	s <= `BSV_ASSIGNMENT_DELAY 12'd0;
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
    b = 12'hAAA;
    c = 12'hAAA;
    l = 32'hAAAAAAAA;
    m = 32'hAAAAAAAA;
    out_en = 1'h0;
    outputDone = 32'hAAAAAAAA;
    s = 12'hAAA;
    state = 2'h2;
    x = 32'hAAAAAAAA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkBerlekampMassey

