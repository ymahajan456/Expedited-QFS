package Tb;

import EllBMVM::*;
import BRAM::*;
import ClientServer::*;
import Clocks::*;
import StmtFSM::*;

(* synthesize *)
module mkTb (Empty);

    //Ifc_type  ifc <- mkModuleDeepThought;
    BMVM_Server mod <- mkEllBMVM(0);
	
	rule send;
		mod.put(pack(4294967295)); //All 1s
		//$finish(0);
	endrule
	
	rule receive;
		$display("Value: %0b", mod.get());
		$finish(0);
	endrule
	
    //rule theUltimateAnswer;
    //    $display ("Hello World! The answer is: %0d", 10 + 20);
    //    $finish(0);
    //endrule

endmodule: mkTb

endpackage: Tb

/* ================================================================
 * ================================================================
 * ================================================================

Commentary (rest of this file)

    import DeepThought::*;

Imports declarations from the package.
The '*' imports all the declarations exported by the package.

* ================================================================
*/
