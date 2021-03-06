//
// Generated by Bluespec Compiler, version 2014.05.C (build 33930, 2014-05-28)
//
// On Fri May  4 10:48:11 IST 2018
//
//
// Ports:
// Name                         I/O  size props
// get                            O    32 reg
// RDY_get                        O     1 reg
// RDY_put                        O     1 reg
// CLK                            I     1 clock
// RST_N                          I     1 reset
// put_x                          I    32 reg
// EN_put                         I     1
// EN_get                         I     1
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

module mkCsrBMVM(CLK,
		 RST_N,

		 EN_get,
		 get,
		 RDY_get,

		 put_x,
		 EN_put,
		 RDY_put);
  parameter [31 : 0] lut_num = 32'b0;
  input  CLK;
  input  RST_N;

  // actionvalue method get
  input  EN_get;
  output [31 : 0] get;
  output RDY_get;

  // action method put
  input  [31 : 0] put_x;
  input  EN_put;
  output RDY_put;

  // signals for module outputs
  wire [31 : 0] get;
  wire RDY_get, RDY_put;

  // inlined wires
  wire [1 : 0] lut_nnz_serverAdapter_s1_1$wget,
	       lut_row_serverAdapter_s1_1$wget;
  wire lut_nnz_serverAdapter_cnt_1$whas,
       lut_nnz_serverAdapter_outData_enqData$whas,
       lut_nnz_serverAdapter_outData_outData$whas,
       lut_nnz_serverAdapter_s1_1$whas,
       lut_row_serverAdapter_cnt_1$whas,
       lut_row_serverAdapter_outData_enqData$whas,
       lut_row_serverAdapter_outData_outData$whas,
       lut_row_serverAdapter_writeWithResp$whas;

  // register in
  reg [31 : 0] in;
  wire [31 : 0] in$D_IN;
  wire in$EN;

  // register lut_nnz_serverAdapter_cnt
  reg [2 : 0] lut_nnz_serverAdapter_cnt;
  wire [2 : 0] lut_nnz_serverAdapter_cnt$D_IN;
  wire lut_nnz_serverAdapter_cnt$EN;

  // register lut_nnz_serverAdapter_s1
  reg [1 : 0] lut_nnz_serverAdapter_s1;
  wire [1 : 0] lut_nnz_serverAdapter_s1$D_IN;
  wire lut_nnz_serverAdapter_s1$EN;

  // register lut_row_serverAdapter_cnt
  reg [2 : 0] lut_row_serverAdapter_cnt;
  wire [2 : 0] lut_row_serverAdapter_cnt$D_IN;
  wire lut_row_serverAdapter_cnt$EN;

  // register lut_row_serverAdapter_s1
  reg [1 : 0] lut_row_serverAdapter_s1;
  wire [1 : 0] lut_row_serverAdapter_s1$D_IN;
  wire lut_row_serverAdapter_s1$EN;

  // register nz_num
  reg [5 : 0] nz_num;
  wire [5 : 0] nz_num$D_IN;
  wire nz_num$EN;

  // register out
  reg [31 : 0] out;
  wire [31 : 0] out$D_IN;
  wire out$EN;

  // register row_end
  reg [5 : 0] row_end;
  wire [5 : 0] row_end$D_IN;
  wire row_end$EN;

  // register row_num
  reg [4 : 0] row_num;
  reg [4 : 0] row_num$D_IN;
  wire row_num$EN;

  // register row_start
  reg [5 : 0] row_start;
  wire [5 : 0] row_start$D_IN;
  wire row_start$EN;

  // register state
  reg [1 : 0] state;
  reg [1 : 0] state$D_IN;
  wire state$EN;

  // ports of submodule in_fifo
  wire [31 : 0] in_fifo$D_IN, in_fifo$D_OUT;
  wire in_fifo$CLR, in_fifo$DEQ, in_fifo$EMPTY_N, in_fifo$ENQ, in_fifo$FULL_N;

  // ports of submodule lut_nnz_memory
  wire [5 : 0] lut_nnz_memory$ADDR;
  wire [4 : 0] lut_nnz_memory$DI, lut_nnz_memory$DO;
  wire lut_nnz_memory$EN, lut_nnz_memory$WE;

  // ports of submodule lut_nnz_serverAdapter_outDataCore
  wire [4 : 0] lut_nnz_serverAdapter_outDataCore$D_IN,
	       lut_nnz_serverAdapter_outDataCore$D_OUT;
  wire lut_nnz_serverAdapter_outDataCore$CLR,
       lut_nnz_serverAdapter_outDataCore$DEQ,
       lut_nnz_serverAdapter_outDataCore$EMPTY_N,
       lut_nnz_serverAdapter_outDataCore$ENQ,
       lut_nnz_serverAdapter_outDataCore$FULL_N;

  // ports of submodule lut_row_memory
  reg [5 : 0] lut_row_memory$DI;
  wire [5 : 0] lut_row_memory$DO;
  wire [4 : 0] lut_row_memory$ADDR;
  wire lut_row_memory$EN, lut_row_memory$WE;

  // ports of submodule lut_row_serverAdapter_outDataCore
  wire [5 : 0] lut_row_serverAdapter_outDataCore$D_IN,
	       lut_row_serverAdapter_outDataCore$D_OUT;
  wire lut_row_serverAdapter_outDataCore$CLR,
       lut_row_serverAdapter_outDataCore$DEQ,
       lut_row_serverAdapter_outDataCore$EMPTY_N,
       lut_row_serverAdapter_outDataCore$ENQ,
       lut_row_serverAdapter_outDataCore$FULL_N;

  // ports of submodule out_fifo
  wire [31 : 0] out_fifo$D_IN, out_fifo$D_OUT;
  wire out_fifo$CLR,
       out_fifo$DEQ,
       out_fifo$EMPTY_N,
       out_fifo$ENQ,
       out_fifo$FULL_N;

  // rule scheduling signals
  wire WILL_FIRE_RL_complete,
       WILL_FIRE_RL_initiateBMVM,
       WILL_FIRE_RL_initiateRow,
       WILL_FIRE_RL_lut_nnz_serverAdapter_outData_enqAndDeq,
       WILL_FIRE_RL_lut_nnz_serverAdapter_stageReadResponseAlways,
       WILL_FIRE_RL_lut_row_serverAdapter_outData_enqAndDeq,
       WILL_FIRE_RL_multiplyRow;

  // inputs to muxes for submodule ports
  wire [5 : 0] MUX_nz_num$write_1__VAL_1;
  wire [4 : 0] MUX_row_num$write_1__VAL_1;
  wire [1 : 0] MUX_lut_nnz_serverAdapter_s1_1$wset_1__VAL_1,
	       MUX_state$write_1__VAL_1;
  wire MUX_lut_nnz_memory$put_1__SEL_2,
       MUX_lut_nnz_memory$put_2__SEL_1,
       MUX_lut_nnz_serverAdapter_s1_1$wset_1__SEL_2,
       MUX_lut_row_memory$put_1__SEL_1,
       MUX_lut_row_memory$put_1__SEL_2,
       MUX_state$write_1__SEL_1;

  // remaining internal signals
  wire [31 : 0] x__h4867, y__h4939;
  wire [5 : 0] v__h3989;
  wire [4 : 0] i__h4880, v__h4383;
  wire [2 : 0] lut_nnz_serverAdapter_cnt_6_PLUS_IF_lut_nnz_se_ETC___d32,
	       lut_row_serverAdapter_cnt_5_PLUS_IF_lut_row_se_ETC___d91;
  wire [1 : 0] ab__h2012, ab__h3572;
  wire IF_nz_num_40_EQ_row_end_41_42_THEN_row_num_26__ETC___d152,
       lut_nnz_serverAdapter_cnt_6_SLT_3___d133,
       lut_nnz_serverAdapter_outDataCore_notEmpty_OR__ETC___d151,
       lut_row_serverAdapter_cnt_5_SLT_3___d120,
       lut_row_serverAdapter_outData_outData_wget__30_ETC___d132,
       lut_row_serverAdapter_outData_outData_whas__29_ETC___d135,
       nz_num_40_EQ_row_end_41___d142,
       nz_num_40_ULT_row_end_41___d147;

  // actionvalue method get
  assign get = out_fifo$D_OUT ;
  assign RDY_get = out_fifo$EMPTY_N ;

  // action method put
  assign RDY_put = in_fifo$FULL_N ;

  // submodule in_fifo
  FIFO2 #(.width(32'd32), .guarded(32'd1)) in_fifo(.RST(RST_N),
						   .CLK(CLK),
						   .D_IN(in_fifo$D_IN),
						   .ENQ(in_fifo$ENQ),
						   .DEQ(in_fifo$DEQ),
						   .CLR(in_fifo$CLR),
						   .D_OUT(in_fifo$D_OUT),
						   .FULL_N(in_fifo$FULL_N),
						   .EMPTY_N(in_fifo$EMPTY_N));

  // submodule lut_nnz_memory
  BRAM1Load #(.FILENAME("../CSR_BMVM/LUT/nnz0.mem"),
	      .PIPELINED(1'd0),
	      .ADDR_WIDTH(32'd6),
	      .DATA_WIDTH(32'd5),
	      .MEMSIZE(7'd64),
	      .BINARY(1'd1)) lut_nnz_memory(.CLK(CLK),
					    .ADDR(lut_nnz_memory$ADDR),
					    .DI(lut_nnz_memory$DI),
					    .WE(lut_nnz_memory$WE),
					    .EN(lut_nnz_memory$EN),
					    .DO(lut_nnz_memory$DO));

  // submodule lut_nnz_serverAdapter_outDataCore
  SizedFIFO #(.p1width(32'd5),
	      .p2depth(32'd3),
	      .p3cntr_width(32'd1),
	      .guarded(32'd1)) lut_nnz_serverAdapter_outDataCore(.RST(RST_N),
								 .CLK(CLK),
								 .D_IN(lut_nnz_serverAdapter_outDataCore$D_IN),
								 .ENQ(lut_nnz_serverAdapter_outDataCore$ENQ),
								 .DEQ(lut_nnz_serverAdapter_outDataCore$DEQ),
								 .CLR(lut_nnz_serverAdapter_outDataCore$CLR),
								 .D_OUT(lut_nnz_serverAdapter_outDataCore$D_OUT),
								 .FULL_N(lut_nnz_serverAdapter_outDataCore$FULL_N),
								 .EMPTY_N(lut_nnz_serverAdapter_outDataCore$EMPTY_N));

  // submodule lut_row_memory
  BRAM1Load #(.FILENAME("../CSR_BMVM/LUT/row0.mem"),
	      .PIPELINED(1'd0),
	      .ADDR_WIDTH(32'd5),
	      .DATA_WIDTH(32'd6),
	      .MEMSIZE(6'd32),
	      .BINARY(1'd1)) lut_row_memory(.CLK(CLK),
					    .ADDR(lut_row_memory$ADDR),
					    .DI(lut_row_memory$DI),
					    .WE(lut_row_memory$WE),
					    .EN(lut_row_memory$EN),
					    .DO(lut_row_memory$DO));

  // submodule lut_row_serverAdapter_outDataCore
  SizedFIFO #(.p1width(32'd6),
	      .p2depth(32'd3),
	      .p3cntr_width(32'd1),
	      .guarded(32'd1)) lut_row_serverAdapter_outDataCore(.RST(RST_N),
								 .CLK(CLK),
								 .D_IN(lut_row_serverAdapter_outDataCore$D_IN),
								 .ENQ(lut_row_serverAdapter_outDataCore$ENQ),
								 .DEQ(lut_row_serverAdapter_outDataCore$DEQ),
								 .CLR(lut_row_serverAdapter_outDataCore$CLR),
								 .D_OUT(lut_row_serverAdapter_outDataCore$D_OUT),
								 .FULL_N(lut_row_serverAdapter_outDataCore$FULL_N),
								 .EMPTY_N(lut_row_serverAdapter_outDataCore$EMPTY_N));

  // submodule out_fifo
  FIFO2 #(.width(32'd32), .guarded(32'd1)) out_fifo(.RST(RST_N),
						    .CLK(CLK),
						    .D_IN(out_fifo$D_IN),
						    .ENQ(out_fifo$ENQ),
						    .DEQ(out_fifo$DEQ),
						    .CLR(out_fifo$CLR),
						    .D_OUT(out_fifo$D_OUT),
						    .FULL_N(out_fifo$FULL_N),
						    .EMPTY_N(out_fifo$EMPTY_N));

  // rule RL_initiateBMVM
  assign WILL_FIRE_RL_initiateBMVM =
	     in_fifo$EMPTY_N && lut_row_serverAdapter_cnt_5_SLT_3___d120 &&
	     state == 2'd0 ;

  // rule RL_complete
  assign WILL_FIRE_RL_complete = out_fifo$FULL_N && state == 2'd3 ;

  // rule RL_multiplyRow
  assign WILL_FIRE_RL_multiplyRow =
	     IF_nz_num_40_EQ_row_end_41_42_THEN_row_num_26__ETC___d152 &&
	     state == 2'd2 ;

  // rule RL_lut_nnz_serverAdapter_outData_enqAndDeq
  assign WILL_FIRE_RL_lut_nnz_serverAdapter_outData_enqAndDeq =
	     lut_nnz_serverAdapter_outDataCore$EMPTY_N &&
	     lut_nnz_serverAdapter_outDataCore$FULL_N &&
	     MUX_lut_nnz_serverAdapter_s1_1$wset_1__SEL_2 &&
	     lut_nnz_serverAdapter_outData_enqData$whas &&
	     !WILL_FIRE_RL_multiplyRow ;

  // rule RL_initiateRow
  assign WILL_FIRE_RL_initiateRow =
	     (lut_row_serverAdapter_outDataCore$EMPTY_N ||
	      lut_row_serverAdapter_outData_enqData$whas) &&
	     lut_row_serverAdapter_outData_outData_whas__29_ETC___d135 &&
	     state == 2'd1 ;

  // rule RL_lut_nnz_serverAdapter_stageReadResponseAlways
  assign WILL_FIRE_RL_lut_nnz_serverAdapter_stageReadResponseAlways =
	     MUX_lut_nnz_memory$put_2__SEL_1 ||
	     MUX_lut_nnz_memory$put_1__SEL_2 ;

  // rule RL_lut_row_serverAdapter_outData_enqAndDeq
  assign WILL_FIRE_RL_lut_row_serverAdapter_outData_enqAndDeq =
	     lut_row_serverAdapter_outDataCore$EMPTY_N &&
	     lut_row_serverAdapter_outDataCore$FULL_N &&
	     WILL_FIRE_RL_initiateRow &&
	     lut_row_serverAdapter_outData_enqData$whas ;

  // inputs to muxes for submodule ports
  assign MUX_lut_nnz_memory$put_1__SEL_2 =
	     WILL_FIRE_RL_multiplyRow && !nz_num_40_EQ_row_end_41___d142 &&
	     nz_num_40_ULT_row_end_41___d147 ;
  assign MUX_lut_nnz_memory$put_2__SEL_1 =
	     WILL_FIRE_RL_initiateRow &&
	     !lut_row_serverAdapter_outData_outData_wget__30_ETC___d132 ;
  assign MUX_lut_nnz_serverAdapter_s1_1$wset_1__SEL_2 =
	     WILL_FIRE_RL_multiplyRow && !nz_num_40_EQ_row_end_41___d142 ;
  assign MUX_lut_row_memory$put_1__SEL_1 =
	     WILL_FIRE_RL_initiateRow &&
	     lut_row_serverAdapter_outData_outData_wget__30_ETC___d132 ;
  assign MUX_lut_row_memory$put_1__SEL_2 =
	     WILL_FIRE_RL_multiplyRow && nz_num_40_EQ_row_end_41___d142 &&
	     row_num != 5'd0 ;
  assign MUX_state$write_1__SEL_1 =
	     WILL_FIRE_RL_multiplyRow && nz_num_40_EQ_row_end_41___d142 ;
  assign MUX_lut_nnz_serverAdapter_s1_1$wset_1__VAL_1 =
	     { 1'd1, !ab__h2012[1] || ab__h2012[0] } ;
  assign MUX_nz_num$write_1__VAL_1 = nz_num + 6'd1 ;
  assign MUX_row_num$write_1__VAL_1 = row_num + 5'd1 ;
  assign MUX_state$write_1__VAL_1 = (row_num == 5'd0) ? 2'd3 : 2'd1 ;

  // inlined wires
  assign lut_nnz_serverAdapter_outData_enqData$whas =
	     (!lut_nnz_serverAdapter_s1[0] ||
	      lut_nnz_serverAdapter_outDataCore$FULL_N) &&
	     lut_nnz_serverAdapter_s1[1] &&
	     lut_nnz_serverAdapter_s1[0] ;
  assign lut_nnz_serverAdapter_outData_outData$whas =
	     lut_nnz_serverAdapter_outDataCore$EMPTY_N ||
	     !lut_nnz_serverAdapter_outDataCore$EMPTY_N &&
	     lut_nnz_serverAdapter_outData_enqData$whas ;
  assign lut_nnz_serverAdapter_cnt_1$whas =
	     WILL_FIRE_RL_lut_nnz_serverAdapter_stageReadResponseAlways &&
	     (!ab__h2012[1] || ab__h2012[0]) ;
  assign lut_nnz_serverAdapter_s1_1$wget =
	     WILL_FIRE_RL_lut_nnz_serverAdapter_stageReadResponseAlways ?
	       MUX_lut_nnz_serverAdapter_s1_1$wset_1__VAL_1 :
	       2'd0 ;
  assign lut_nnz_serverAdapter_s1_1$whas =
	     WILL_FIRE_RL_multiplyRow && !nz_num_40_EQ_row_end_41___d142 ||
	     WILL_FIRE_RL_lut_nnz_serverAdapter_stageReadResponseAlways ;
  assign lut_row_serverAdapter_outData_enqData$whas =
	     (!lut_row_serverAdapter_s1[0] ||
	      lut_row_serverAdapter_outDataCore$FULL_N) &&
	     lut_row_serverAdapter_s1[1] &&
	     lut_row_serverAdapter_s1[0] ;
  assign lut_row_serverAdapter_outData_outData$whas =
	     lut_row_serverAdapter_outDataCore$EMPTY_N ||
	     !lut_row_serverAdapter_outDataCore$EMPTY_N &&
	     lut_row_serverAdapter_outData_enqData$whas ;
  assign lut_row_serverAdapter_cnt_1$whas =
	     (MUX_lut_row_memory$put_1__SEL_1 ||
	      MUX_lut_row_memory$put_1__SEL_2 ||
	      WILL_FIRE_RL_initiateBMVM) &&
	     (!ab__h3572[1] || ab__h3572[0]) ;
  assign lut_row_serverAdapter_writeWithResp$whas =
	     MUX_lut_row_memory$put_1__SEL_1 ||
	     MUX_lut_row_memory$put_1__SEL_2 ||
	     WILL_FIRE_RL_initiateBMVM ;
  assign lut_row_serverAdapter_s1_1$wget =
	     { 1'd1, !ab__h3572[1] || ab__h3572[0] } ;

  // register in
  assign in$D_IN = in_fifo$D_OUT ;
  assign in$EN = WILL_FIRE_RL_initiateBMVM ;

  // register lut_nnz_serverAdapter_cnt
  assign lut_nnz_serverAdapter_cnt$D_IN =
	     MUX_lut_nnz_serverAdapter_s1_1$wset_1__SEL_2 ?
	       3'd0 :
	       lut_nnz_serverAdapter_cnt_6_PLUS_IF_lut_nnz_se_ETC___d32 ;
  assign lut_nnz_serverAdapter_cnt$EN =
	     lut_nnz_serverAdapter_cnt_1$whas ||
	     MUX_lut_nnz_serverAdapter_s1_1$wset_1__SEL_2 ||
	     MUX_lut_nnz_serverAdapter_s1_1$wset_1__SEL_2 ;

  // register lut_nnz_serverAdapter_s1
  assign lut_nnz_serverAdapter_s1$D_IN =
	     { lut_nnz_serverAdapter_s1_1$whas &&
	       lut_nnz_serverAdapter_s1_1$wget[1],
	       lut_nnz_serverAdapter_s1_1$wget[0] } ;
  assign lut_nnz_serverAdapter_s1$EN = 1'd1 ;

  // register lut_row_serverAdapter_cnt
  assign lut_row_serverAdapter_cnt$D_IN =
	     lut_row_serverAdapter_cnt_5_PLUS_IF_lut_row_se_ETC___d91 ;
  assign lut_row_serverAdapter_cnt$EN =
	     lut_row_serverAdapter_cnt_1$whas || WILL_FIRE_RL_initiateRow ;

  // register lut_row_serverAdapter_s1
  assign lut_row_serverAdapter_s1$D_IN =
	     { lut_row_serverAdapter_writeWithResp$whas &&
	       lut_row_serverAdapter_s1_1$wget[1],
	       lut_row_serverAdapter_s1_1$wget[0] } ;
  assign lut_row_serverAdapter_s1$EN = 1'd1 ;

  // register nz_num
  assign nz_num$D_IN =
	     MUX_lut_nnz_serverAdapter_s1_1$wset_1__SEL_2 ?
	       MUX_nz_num$write_1__VAL_1 :
	       6'd0 ;
  assign nz_num$EN =
	     WILL_FIRE_RL_multiplyRow && !nz_num_40_EQ_row_end_41___d142 ||
	     WILL_FIRE_RL_complete ;

  // register out
  assign out$D_IN =
	     (out[i__h4880] ^ in[v__h4383]) ?
	       out | x__h4867 :
	       out & y__h4939 ;
  assign out$EN = MUX_lut_nnz_serverAdapter_s1_1$wset_1__SEL_2 ;

  // register row_end
  assign row_end$D_IN = v__h3989 ;
  assign row_end$EN = WILL_FIRE_RL_initiateRow ;

  // register row_num
  always@(MUX_lut_row_memory$put_1__SEL_1 or
	  MUX_row_num$write_1__VAL_1 or
	  MUX_lut_row_memory$put_1__SEL_2 or
	  WILL_FIRE_RL_initiateBMVM or WILL_FIRE_RL_complete)
  begin
    case (1'b1) // synopsys parallel_case
      MUX_lut_row_memory$put_1__SEL_1:
	  row_num$D_IN = MUX_row_num$write_1__VAL_1;
      MUX_lut_row_memory$put_1__SEL_2:
	  row_num$D_IN = MUX_row_num$write_1__VAL_1;
      WILL_FIRE_RL_initiateBMVM: row_num$D_IN = MUX_row_num$write_1__VAL_1;
      WILL_FIRE_RL_complete: row_num$D_IN = 5'd0;
      default: row_num$D_IN = 5'b01010 /* unspecified value */ ;
    endcase
  end
  assign row_num$EN =
	     WILL_FIRE_RL_initiateRow &&
	     lut_row_serverAdapter_outData_outData_wget__30_ETC___d132 ||
	     WILL_FIRE_RL_multiplyRow && nz_num_40_EQ_row_end_41___d142 &&
	     row_num != 5'd0 ||
	     WILL_FIRE_RL_initiateBMVM ||
	     WILL_FIRE_RL_complete ;

  // register row_start
  assign row_start$D_IN = v__h3989 ;
  assign row_start$EN = WILL_FIRE_RL_initiateRow ;

  // register state
  always@(MUX_state$write_1__SEL_1 or
	  MUX_state$write_1__VAL_1 or
	  MUX_lut_nnz_memory$put_2__SEL_1 or
	  WILL_FIRE_RL_complete or WILL_FIRE_RL_initiateBMVM)
  begin
    case (1'b1) // synopsys parallel_case
      MUX_state$write_1__SEL_1: state$D_IN = MUX_state$write_1__VAL_1;
      MUX_lut_nnz_memory$put_2__SEL_1: state$D_IN = 2'd2;
      WILL_FIRE_RL_complete: state$D_IN = 2'd0;
      WILL_FIRE_RL_initiateBMVM: state$D_IN = 2'd1;
      default: state$D_IN = 2'b10 /* unspecified value */ ;
    endcase
  end
  assign state$EN =
	     WILL_FIRE_RL_multiplyRow && nz_num_40_EQ_row_end_41___d142 ||
	     WILL_FIRE_RL_initiateRow &&
	     !lut_row_serverAdapter_outData_outData_wget__30_ETC___d132 ||
	     WILL_FIRE_RL_complete ||
	     WILL_FIRE_RL_initiateBMVM ;

  // submodule in_fifo
  assign in_fifo$D_IN = put_x ;
  assign in_fifo$ENQ = EN_put ;
  assign in_fifo$DEQ = WILL_FIRE_RL_initiateBMVM ;
  assign in_fifo$CLR = 1'b0 ;

  // submodule lut_nnz_memory
  assign lut_nnz_memory$ADDR = nz_num ;
  assign lut_nnz_memory$DI =
	     MUX_lut_nnz_memory$put_2__SEL_1 ?
	       5'b01010 /* unspecified value */  :
	       5'b01010 /* unspecified value */  ;
  assign lut_nnz_memory$WE = 1'd0 ;
  assign lut_nnz_memory$EN =
	     WILL_FIRE_RL_initiateRow &&
	     !lut_row_serverAdapter_outData_outData_wget__30_ETC___d132 ||
	     WILL_FIRE_RL_multiplyRow && !nz_num_40_EQ_row_end_41___d142 &&
	     nz_num_40_ULT_row_end_41___d147 ;

  // submodule lut_nnz_serverAdapter_outDataCore
  assign lut_nnz_serverAdapter_outDataCore$D_IN = lut_nnz_memory$DO ;
  assign lut_nnz_serverAdapter_outDataCore$ENQ =
	     WILL_FIRE_RL_lut_nnz_serverAdapter_outData_enqAndDeq ||
	     lut_nnz_serverAdapter_outDataCore$FULL_N &&
	     !MUX_lut_nnz_serverAdapter_s1_1$wset_1__SEL_2 &&
	     lut_nnz_serverAdapter_outData_enqData$whas &&
	     !WILL_FIRE_RL_multiplyRow ;
  assign lut_nnz_serverAdapter_outDataCore$DEQ =
	     WILL_FIRE_RL_lut_nnz_serverAdapter_outData_enqAndDeq ||
	     lut_nnz_serverAdapter_outDataCore$EMPTY_N &&
	     MUX_lut_nnz_serverAdapter_s1_1$wset_1__SEL_2 &&
	     !lut_nnz_serverAdapter_outData_enqData$whas &&
	     !WILL_FIRE_RL_multiplyRow ;
  assign lut_nnz_serverAdapter_outDataCore$CLR =
	     MUX_lut_nnz_serverAdapter_s1_1$wset_1__SEL_2 ;

  // submodule lut_row_memory
  assign lut_row_memory$ADDR = row_num ;
  always@(MUX_lut_row_memory$put_1__SEL_1 or
	  MUX_lut_row_memory$put_1__SEL_2 or WILL_FIRE_RL_initiateBMVM)
  begin
    case (1'b1) // synopsys parallel_case
      MUX_lut_row_memory$put_1__SEL_1:
	  lut_row_memory$DI = 6'b101010 /* unspecified value */ ;
      MUX_lut_row_memory$put_1__SEL_2:
	  lut_row_memory$DI = 6'b101010 /* unspecified value */ ;
      WILL_FIRE_RL_initiateBMVM:
	  lut_row_memory$DI = 6'b101010 /* unspecified value */ ;
      default: lut_row_memory$DI = 6'b101010 /* unspecified value */ ;
    endcase
  end
  assign lut_row_memory$WE = 1'd0 ;
  assign lut_row_memory$EN =
	     WILL_FIRE_RL_initiateRow &&
	     lut_row_serverAdapter_outData_outData_wget__30_ETC___d132 ||
	     WILL_FIRE_RL_multiplyRow && nz_num_40_EQ_row_end_41___d142 &&
	     row_num != 5'd0 ||
	     WILL_FIRE_RL_initiateBMVM ;

  // submodule lut_row_serverAdapter_outDataCore
  assign lut_row_serverAdapter_outDataCore$D_IN = lut_row_memory$DO ;
  assign lut_row_serverAdapter_outDataCore$ENQ =
	     WILL_FIRE_RL_lut_row_serverAdapter_outData_enqAndDeq ||
	     lut_row_serverAdapter_outDataCore$FULL_N &&
	     !WILL_FIRE_RL_initiateRow &&
	     lut_row_serverAdapter_outData_enqData$whas ;
  assign lut_row_serverAdapter_outDataCore$DEQ =
	     WILL_FIRE_RL_lut_row_serverAdapter_outData_enqAndDeq ||
	     lut_row_serverAdapter_outDataCore$EMPTY_N &&
	     WILL_FIRE_RL_initiateRow &&
	     !lut_row_serverAdapter_outData_enqData$whas ;
  assign lut_row_serverAdapter_outDataCore$CLR = 1'b0 ;

  // submodule out_fifo
  assign out_fifo$D_IN = out ;
  assign out_fifo$ENQ = WILL_FIRE_RL_complete ;
  assign out_fifo$DEQ = EN_get ;
  assign out_fifo$CLR = 1'b0 ;

  // remaining internal signals
  assign IF_nz_num_40_EQ_row_end_41_42_THEN_row_num_26__ETC___d152 =
	     nz_num_40_EQ_row_end_41___d142 ?
	       row_num == 5'd0 || lut_row_serverAdapter_cnt_5_SLT_3___d120 :
	       lut_nnz_serverAdapter_outDataCore_notEmpty_OR__ETC___d151 ;
  assign ab__h2012 = 2'd0 ;
  assign ab__h3572 = 2'd0 ;
  assign i__h4880 = row_num - 5'd1 ;
  assign lut_nnz_serverAdapter_cnt_6_PLUS_IF_lut_nnz_se_ETC___d32 =
	     lut_nnz_serverAdapter_cnt +
	     (lut_nnz_serverAdapter_cnt_1$whas ? 3'd1 : 3'd0) +
	     (MUX_lut_nnz_serverAdapter_s1_1$wset_1__SEL_2 ? 3'd7 : 3'd0) ;
  assign lut_nnz_serverAdapter_cnt_6_SLT_3___d133 =
	     (lut_nnz_serverAdapter_cnt ^ 3'h4) < 3'd7 ;
  assign lut_nnz_serverAdapter_outDataCore_notEmpty_OR__ETC___d151 =
	     (lut_nnz_serverAdapter_outDataCore$EMPTY_N ||
	      lut_nnz_serverAdapter_outData_enqData$whas) &&
	     lut_nnz_serverAdapter_outData_outData$whas &&
	     (!nz_num_40_ULT_row_end_41___d147 ||
	      lut_nnz_serverAdapter_cnt_6_SLT_3___d133) ;
  assign lut_row_serverAdapter_cnt_5_PLUS_IF_lut_row_se_ETC___d91 =
	     lut_row_serverAdapter_cnt +
	     (lut_row_serverAdapter_cnt_1$whas ? 3'd1 : 3'd0) +
	     (WILL_FIRE_RL_initiateRow ? 3'd7 : 3'd0) ;
  assign lut_row_serverAdapter_cnt_5_SLT_3___d120 =
	     (lut_row_serverAdapter_cnt ^ 3'h4) < 3'd7 ;
  assign lut_row_serverAdapter_outData_outData_wget__30_ETC___d132 =
	     v__h3989 == row_start ;
  assign lut_row_serverAdapter_outData_outData_whas__29_ETC___d135 =
	     lut_row_serverAdapter_outData_outData$whas &&
	     (lut_row_serverAdapter_outData_outData_wget__30_ETC___d132 ?
		lut_row_serverAdapter_cnt_5_SLT_3___d120 :
		lut_nnz_serverAdapter_cnt_6_SLT_3___d133) ;
  assign nz_num_40_EQ_row_end_41___d142 = nz_num == row_end ;
  assign nz_num_40_ULT_row_end_41___d147 = nz_num < row_end ;
  assign v__h3989 =
	     lut_row_serverAdapter_outDataCore$EMPTY_N ?
	       lut_row_serverAdapter_outDataCore$D_OUT :
	       lut_row_memory$DO ;
  assign v__h4383 =
	     lut_nnz_serverAdapter_outDataCore$EMPTY_N ?
	       lut_nnz_serverAdapter_outDataCore$D_OUT :
	       lut_nnz_memory$DO ;
  assign x__h4867 = 32'd1 << i__h4880 ;
  assign y__h4939 = ~x__h4867 ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        in <= `BSV_ASSIGNMENT_DELAY 32'd0;
	lut_nnz_serverAdapter_cnt <= `BSV_ASSIGNMENT_DELAY 3'd0;
	lut_nnz_serverAdapter_s1 <= `BSV_ASSIGNMENT_DELAY 2'd0;
	lut_row_serverAdapter_cnt <= `BSV_ASSIGNMENT_DELAY 3'd0;
	lut_row_serverAdapter_s1 <= `BSV_ASSIGNMENT_DELAY 2'd0;
	nz_num <= `BSV_ASSIGNMENT_DELAY 6'd0;
	out <= `BSV_ASSIGNMENT_DELAY 32'd0;
	row_end <= `BSV_ASSIGNMENT_DELAY 6'd0;
	row_num <= `BSV_ASSIGNMENT_DELAY 5'd0;
	row_start <= `BSV_ASSIGNMENT_DELAY 6'd0;
	state <= `BSV_ASSIGNMENT_DELAY 2'd0;
      end
    else
      begin
        if (in$EN) in <= `BSV_ASSIGNMENT_DELAY in$D_IN;
	if (lut_nnz_serverAdapter_cnt$EN)
	  lut_nnz_serverAdapter_cnt <= `BSV_ASSIGNMENT_DELAY
	      lut_nnz_serverAdapter_cnt$D_IN;
	if (lut_nnz_serverAdapter_s1$EN)
	  lut_nnz_serverAdapter_s1 <= `BSV_ASSIGNMENT_DELAY
	      lut_nnz_serverAdapter_s1$D_IN;
	if (lut_row_serverAdapter_cnt$EN)
	  lut_row_serverAdapter_cnt <= `BSV_ASSIGNMENT_DELAY
	      lut_row_serverAdapter_cnt$D_IN;
	if (lut_row_serverAdapter_s1$EN)
	  lut_row_serverAdapter_s1 <= `BSV_ASSIGNMENT_DELAY
	      lut_row_serverAdapter_s1$D_IN;
	if (nz_num$EN) nz_num <= `BSV_ASSIGNMENT_DELAY nz_num$D_IN;
	if (out$EN) out <= `BSV_ASSIGNMENT_DELAY out$D_IN;
	if (row_end$EN) row_end <= `BSV_ASSIGNMENT_DELAY row_end$D_IN;
	if (row_num$EN) row_num <= `BSV_ASSIGNMENT_DELAY row_num$D_IN;
	if (row_start$EN) row_start <= `BSV_ASSIGNMENT_DELAY row_start$D_IN;
	if (state$EN) state <= `BSV_ASSIGNMENT_DELAY state$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    in = 32'hAAAAAAAA;
    lut_nnz_serverAdapter_cnt = 3'h2;
    lut_nnz_serverAdapter_s1 = 2'h2;
    lut_row_serverAdapter_cnt = 3'h2;
    lut_row_serverAdapter_s1 = 2'h2;
    nz_num = 6'h2A;
    out = 32'hAAAAAAAA;
    row_end = 6'h2A;
    row_num = 5'h0A;
    row_start = 6'h2A;
    state = 2'h2;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on

  // handling of system tasks

  // synopsys translate_off
  always@(negedge CLK)
  begin
    #0;
    if (RST_N != `BSV_RESET_VALUE)
      if (lut_nnz_serverAdapter_s1[1] &&
	  !lut_nnz_serverAdapter_outDataCore$FULL_N)
	$display("ERROR: %m: mkBRAMSeverAdapter overrun");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_multiplyRow && !nz_num_40_EQ_row_end_41___d142)
	$display("%0b", v__h4383);
    if (RST_N != `BSV_RESET_VALUE)
      if (lut_row_serverAdapter_s1[1] &&
	  !lut_row_serverAdapter_outDataCore$FULL_N)
	$display("ERROR: %m: mkBRAMSeverAdapter overrun");
  end
  // synopsys translate_on
endmodule  // mkCsrBMVM

