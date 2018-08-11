//Author: Ajinkya D. Kharalkar (14D070031)
//This file contains the testbench for Wiedemann module
//This code prints the output of Wiedemann module
package Tb;

import BerlekampMassey::*;
import Wiedemann::*;

(* synthesize *)
module mkTb (Empty);
	
		BerlekampMassey  ifc <- mkBerlekampMassey;
		Wiedemann ifc2 <- mkWiedemann;
		Reg#(int) i   <- mkReg (0);
		rule r(i==0);
			ifc2.wiedemann_in();
			i<=1;
		endrule: r

		rule theUltimateAnswer(i==1);
		
		   $display ("Polynolmial= %b",  ifc2.wiedemann_out());
			$display ("degree= %d",  ifc2.wiedemann_out_degree());
		   $finish (0);
		endrule
			

endmodule: mkTb

endpackage: Tb

