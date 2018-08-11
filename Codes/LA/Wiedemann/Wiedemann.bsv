package Wiedemann;
import BMVM::*;
import BerlekampMassey::*;
import Randomizable ::* ;
import LFSR ::*;

typedef enum {S0,S1,S2,S3,S4,S5,S6} Wiedemann_states deriving(Eq, Bits); // Defining states. S0- Start, S1- Update, S2- Done.

interface Wiedemann;
	method Action wiedemann_in();
	method Reg#(Bit#(Size)) wiedemann_out();
endinterface: Wiedemann

(*synthesize*)
module mkWiedemann (Wiedemann);
	BMVM_Server ifc <- mkBMVM;
	BerlekampMassey ifc2 <- mkBerlekampMassey;
	Reg#(Wiedemann_states) state <- mkReg(S0);
	Reg#(Bit#(Size)) x <- mkReg(0);
	Reg#(Bit#(Size)) t <- mkReg(0);
	Reg#(Bit#(Size)) mul <- mkReg(0);
	Reg#(Bit#(Size)) s <- mkReg(0);
	Reg#(Bit#(Size)) c <- mkReg(0);
	Reg#(Int#(32)) n <- mkReg(0);
	Reg#(bit) done <- mkReg(0);
	
	
	rule state_s1(state==S1);
		ifc.put(mul);
		bit sum=0;
		for(int i=0;i<fromInteger(valueOf(Size));i=i+1)
			sum=sum^(mul[i] & t[i]);
		
		s[n]<=sum;
		
		
		state<=S2;
		
	endrule
	
	rule state_s2(state==S2);
		mul <=ifc.get();
		n<=n+1;
		state<=S3;
		$display ("s= %b",  s[n]);
	endrule

	rule state_s3(state==S3);
		if(n<fromInteger(valueOf(Size))) begin
			state<=S1;
		end
		else begin
			state<=S4;
		end

	endrule

	
	rule state_s4(state==S4);
		ifc2.start(s);
		state<=S5;
	endrule

	rule state_s5(state==S5);
		done<=1;
		c<=ifc2.polynomial();
		state<=S0;
	endrule

	method Action wiedemann_in();
		x<=3'b101;
		t<=3'b110;
		state<=S1;
		n<=0;
		mul<=3'b101;
	endmethod 
	
	method Reg#(Bit#(Size)) wiedemann_out() if(done==1);
		return (c);
	endmethod


endmodule: mkWiedemann

endpackage: Wiedemann
/*	LFSR#(Bit#(8)) lfsr <- mkLFSR_8 ;
	
	Reg#(int) i   <- mkReg (0);
	rule r(i==0);
		lfsr.seed( 'h11 );	
		
		i<=i+1;
	endrule: r
*/
	


