package Tb;

import BerlekampMassey::*;

(* synthesize *)
module mkTb (Empty);
	
		BerlekampMassey  ifc <- mkBerlekampMassey;
		Reg#(int) i   <- mkReg (0);
		rule r(i==0);
			ifc.start(12'b101110100101);
			
			i<=i+1;
		endrule: r

		rule theUltimateAnswer(i==1);
		
		   $display ("Polynolmial= %b, degree= %d",  ifc.polynomial, ifc.poly_length);
		   $finish (0);
		endrule
			

endmodule: mkTb

endpackage: Tb

