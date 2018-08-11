package Tb;

import BMVM::*;

(* synthesize *)
module mkTb (Empty);
	
		BMVM_Server  ifc <- mkBMVM;
		Reg#(int) i   <- mkReg (0);
		rule r(i==0);
			ifc.put(3'b100);
			
			i<=i+1;
		endrule: r

		rule theUltimateAnswer(i==1);
		
		   $display ("Output Vector= %b",  ifc.get);
		   $finish (0);
		endrule
			

endmodule: mkTb

endpackage: Tb

