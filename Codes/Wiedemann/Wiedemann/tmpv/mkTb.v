//
// Generated by Bluespec Compiler, version 2014.05.C (build 33930, 2014-05-28)
//
// On Tue May  8 03:46:14 IST 2018
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
  wire [223 : 0] ifc$polynomial__write_1, ifc$start_s_in;
  wire [31 : 0] ifc$poly_length__write_1;
  wire ifc$EN_poly_length__write, ifc$EN_polynomial__write, ifc$EN_start;

  // ports of submodule ifc2
  wire [223 : 0] ifc2$wiedemann_out__read, ifc2$wiedemann_out__write_1;
  wire [31 : 0] ifc2$wiedemann_out_degree__read,
		ifc2$wiedemann_out_degree__write_1;
  wire ifc2$EN_wiedemann_in,
       ifc2$EN_wiedemann_out__write,
       ifc2$EN_wiedemann_out_degree__write,
       ifc2$RDY_wiedemann_out__read,
       ifc2$RDY_wiedemann_out_degree__read;

  // rule scheduling signals
  wire WILL_FIRE_RL_theUltimateAnswer;

  // submodule ifc
  mkBerlekampMassey ifc(.CLK(CLK),
			.RST_N(RST_N),
			.poly_length__write_1(ifc$poly_length__write_1),
			.polynomial__write_1(ifc$polynomial__write_1),
			.start_s_in(ifc$start_s_in),
			.EN_start(ifc$EN_start),
			.EN_polynomial__write(ifc$EN_polynomial__write),
			.EN_poly_length__write(ifc$EN_poly_length__write),
			.RDY_start(),
			.RDY_polynomial__write(),
			.polynomial__read(),
			.RDY_polynomial__read(),
			.RDY_poly_length__write(),
			.poly_length__read(),
			.RDY_poly_length__read(),
			.outputValid(),
			.RDY_outputValid());

  // submodule ifc2
  mkWiedemann ifc2(.CLK(CLK),
		   .RST_N(RST_N),
		   .wiedemann_out__write_1(ifc2$wiedemann_out__write_1),
		   .wiedemann_out_degree__write_1(ifc2$wiedemann_out_degree__write_1),
		   .EN_wiedemann_in(ifc2$EN_wiedemann_in),
		   .EN_wiedemann_out__write(ifc2$EN_wiedemann_out__write),
		   .EN_wiedemann_out_degree__write(ifc2$EN_wiedemann_out_degree__write),
		   .RDY_wiedemann_in(),
		   .RDY_wiedemann_out__write(),
		   .wiedemann_out__read(ifc2$wiedemann_out__read),
		   .RDY_wiedemann_out__read(ifc2$RDY_wiedemann_out__read),
		   .RDY_wiedemann_out_degree__write(),
		   .wiedemann_out_degree__read(ifc2$wiedemann_out_degree__read),
		   .RDY_wiedemann_out_degree__read(ifc2$RDY_wiedemann_out_degree__read));

  // rule RL_theUltimateAnswer
  assign WILL_FIRE_RL_theUltimateAnswer =
	     ifc2$RDY_wiedemann_out_degree__read &&
	     ifc2$RDY_wiedemann_out__read &&
	     i == 32'd1 ;

  // register i
  assign i$D_IN = 32'd1 ;
  assign i$EN = i == 32'd0 ;

  // submodule ifc
  assign ifc$poly_length__write_1 = 32'h0 ;
  assign ifc$polynomial__write_1 = 224'h0 ;
  assign ifc$start_s_in = 224'h0 ;
  assign ifc$EN_start = 1'b0 ;
  assign ifc$EN_polynomial__write = 1'b0 ;
  assign ifc$EN_poly_length__write = 1'b0 ;

  // submodule ifc2
  assign ifc2$wiedemann_out__write_1 = 224'h0 ;
  assign ifc2$wiedemann_out_degree__write_1 = 32'h0 ;
  assign ifc2$EN_wiedemann_in = i == 32'd0 ;
  assign ifc2$EN_wiedemann_out__write = 1'b0 ;
  assign ifc2$EN_wiedemann_out_degree__write = 1'b0 ;

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
      if (WILL_FIRE_RL_theUltimateAnswer)
	$display("Polynolmial= %b", ifc2$wiedemann_out__read);
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_theUltimateAnswer)
	$display("degree= %d", $signed(ifc2$wiedemann_out_degree__read));
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_theUltimateAnswer) $finish(32'd0);
  end
  // synopsys translate_on
endmodule  // mkTb

