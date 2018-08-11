package BerlekampMassey;

import BMVM ::*;
//typedef 12 Size; //Length of the input sequence
typedef enum {S0,S1,S2} States deriving(Eq, Bits); // Defining states. S0- Start, S1- Update, S2- Done.

interface BerlekampMassey;
	method Action start(Bit#(Size) s_in);
	method Reg#(Bit#(Size)) polynomial();
	method Reg#(Int#(32)) poly_length();
	method Bit#(32) outputValid;
endinterface: BerlekampMassey

(*synthesize*)
module mkBerlekampMassey (BerlekampMassey);
	Reg#(States) state <- mkReg(S0);	
	Reg#(Bit#(Size)) b <- mkReg(1);
	Reg#(Bit#(Size)) c <- mkReg(1);
	Reg#(Bit#(Size)) s <- mkReg(0);
	Reg#(Int#(32)) x <- mkReg(1);
	Reg#(Int#(32)) l <- mkReg(0);
	Reg#(Int#(32)) m <- mkReg(0);
	Reg#(bit) out_en<- mkReg(0);
   Reg#(Bit#(32)) outputDone <- mkRegU();
	


	rule update(state==S1);
		bit discrepancy=s[m];
		//----------------discrepancy calculation---------------------
		for(int i=1;i<fromInteger(valueOf(Size));i=i+1)
			if(i<l+1)
				discrepancy = discrepancy^(c[i] & s[m-i]);		
		//------------------------------------------------------------
		
		if(discrepancy==1) begin
		//----------------updating sequence c-------------------------
			Bit#(Size) t=c;	// copy of c
			for(int j=0;j<fromInteger(valueOf(Size));j=j+1)
				if(j>x-1)
					t[j]=t[j]^b[j-x];
			c<=t;		//updated c sequence
		//------------------------------------------------------------

			if (2*l<m+1) begin
				l<=m+1-l;
				b<=c;
				x<=1;
			end	
			else begin	
				x<=x+1;
			end
		end	
		else begin
			x<=x+1;
		end
		m<=m+1;
	
		if(m==fromInteger(valueOf(Size)-1))begin
			state<=S2;
		end
	endrule: update

	rule done (state==S2);
		out_en<=1;	
		outputDone<=1;
		m <=0;
		state <= S0;
	endrule: done

	
	method Action start(s_in);
		s<=s_in;
		c<=1;
		x<=1;
		l<=0;
		m<=0;
		state <= S1;
	endmethod

   method Bit#(32) outputValid;
      return outputDone;
   endmethod

	method Reg#(Bit#(Size)) polynomial() if(out_en==1);
		return (c);
	endmethod
	
	method Reg#(Int#(32)) poly_length()if(out_en==1);
		return(l);
	endmethod


endmodule: mkBerlekampMassey

endpackage: BerlekampMassey
	


