//Author: Ajinkya D. Kharalkar (14D070031)
//This file contains the implementation of Wiedemann algorithm using EllBMVM and Berlekamp_massey module
//This code returns a vector which permuted, can be in the null space of matrix A
package Wiedemann;
import EllBMVM::*;
import BerlekampMassey::*;
import Randomizable ::* ;
import LFSR ::*;

typedef 224 N;//no. of rows/ columns of the matrix
typedef enum {S0,S0_1,S0_2,S1,S2,S3,S4,S5} Wiedemann_states deriving(Eq, Bits); // Defining states. S0- Start, S1,S2 and S3- repeatative BMVM, S4-Minimal polynomial generation, S5-Done.

interface Wiedemann;
	method Action wiedemann_in();	//action method for start of the operation
	method Reg#(Bit#(N)) wiedemann_out();	//output of the module
	method Reg#(Int#(32)) wiedemann_out_degree();	// degree of the output sequence
endinterface: Wiedemann

(*synthesize*)
module mkWiedemann (Wiedemann);
	BMVM_Server ifc <- mkEllBMVM(0);		//interface for BMVM module
	BerlekampMassey ifc2 <- mkBerlekampMassey;	//interface for Berlekamp module

	Reg#(Wiedemann_states) state <- mkReg(S0);
	Randomize#(Bit#(N)) random <- mkGenericRandomizer;		//used for random vector generation
	Reg#(Bit#(N)) x <- mkReg(0); 
	Reg#(Bit#(N)) t <- mkReg(0); 
	Reg#(Bit#(N)) mul <- mkReg(0);	// intermediate product Ax^(k-1)
	Reg#(Bit#(N)) s <- mkReg(0);		// copy of input sequence
	Reg#(Bit#(N)) c <- mkReg(0);		// output sequence
	Reg#(Int#(32)) n <- mkReg(0);
	Reg#(bit) done <- mkReg(0);
	Reg#(Int#(32)) d <- mkReg(0);		// degree of output sequence
	
	//-----------random vector x generation--------------//
	rule state_s0_1(state==S0_1);
		let mul_temp <-random.next(); 	//random vector x
		state<=S0_2;
		mul<=mul_temp;
	endrule
	//-----------random vector t generation--------------//
	rule state_s0_2(state==S0_2);		//random vector t
		let t_temp <-random.next();	
		state<=S1;
		t <=t_temp;
	endrule
	
//-----------giving input to BMVM module and Kt sub-space generation--------------//
	rule state_s1(state==S1);
		ifc.put(mul);
		bit sum=0;
		for(Int#(32) i=0;i<fromInteger(valueOf(N));i=i+1) //calculation of Kt
			sum=sum^(mul[i] & t[i]);
		
		s[n]<=sum;
		
		
		state<=S2;
		//$display ("state= S1");
		
	endrule
//-----------taking BMVM output--------------//	
	rule state_s2(state==S2);
		Bit#(N) mul_temp;
		mul_temp <-ifc.get();
		n<=n+1;
		state<=S3;
		mul<=mul_temp;
		//$display ("state= S2");
		$display ("s[n]=%b",s[n]);
	endrule

	rule state_s3(state==S3);
		if(n<fromInteger(valueOf(N))) begin
			state<=S1;
			$display ("n= %d",  n);
		end
		else begin
			state<=S4;
		end
		//$display ("state= S3");
	endrule

//-----------input to Berlekamp module--------------//	
	rule state_s4(state==S4);
		ifc2.start(s);
		state<=S5;
		//$display ("state= S4");
	endrule

//-----------reading output of Berlekamp module--------------//
	rule state_s5(state==S5);
		done<=1;
		c<=ifc2.polynomial();
		d<=ifc2.poly_length();
		
		state<=S0;
		//$display ("state= S5");
	endrule

	method Action wiedemann_in();
		random.cntrl.init(); 

		state<=S0_1;
		n<=0;
		
	endmethod 
	
	method Reg#(Bit#(N)) wiedemann_out() if(done==1);
		return (c);		//returns minimal polynomial
	endmethod

	method Reg#(Int#(32)) wiedemann_out_degree() if(done==1);
		return (d);		//returns degree of output sequence
	endmethod


endmodule: mkWiedemann

endpackage: Wiedemann

