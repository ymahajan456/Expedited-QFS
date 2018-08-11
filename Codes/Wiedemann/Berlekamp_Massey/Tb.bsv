//Author: Ajinkya D. Kharalkar (14D070031)
//This file contains the testbench for Berlekamp module
//This code prints the output of Berlekamp module and its degree
package Tb;

import BerlekampMassey::*;

(* synthesize *)
module mkTb (Empty);
	
		BerlekampMassey  ifc <- mkBerlekampMassey;
		Reg#(int) i   <- mkReg (0);
		rule r(i==0);
			ifc.start(4'b1110); //give the test input here in the binary format
									  // if input is not of size 4, change the parameter 'Size' accordingly in the file BerlekampMassey.bsv 
			
			i<=i+1;
		endrule: r

		rule theUltimateAnswer(i==1);
		
		   $display ("Polynolmial= %b, degree= %d",  ifc.polynomial, ifc.poly_length);
		   $finish (0);
		endrule
			

endmodule: mkTb

endpackage: Tb

