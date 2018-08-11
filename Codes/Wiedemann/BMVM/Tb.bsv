//Author: Ajinkya D. Kharalkar (14D070031)
//This file contains the testbench for BMVM module
//This code prints the output of BMVM module
package Tb;

import BMVM::*;

(* synthesize *)
module mkTb (Empty);
	
		BMVM_Server  ifc <- mkBMVM;
		Reg#(int) i   <- mkReg (0);
		rule r(i==0);
			ifc.put(4'b0111);	// give the input here
									// if the input is not of size 4, change the size in the parameter in BMVM.bsv
			
			i<=i+1;
		endrule: r

		rule theUltimateAnswer(i==1);
		
		   $display ("Output Vector= %b",  ifc.get);
		   $finish (0);
		endrule
			

endmodule: mkTb

endpackage: Tb

