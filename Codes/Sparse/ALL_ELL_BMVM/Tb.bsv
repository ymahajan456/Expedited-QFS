package Tb;

import EllBMVM::*;
import BRAM::*;
import ClientServer::*;
import Clocks::*;
import StmtFSM::*;

(* synthesize *)
module mkTb (Empty);

	Reg#(Bit#(4)) sent <- mkReg(0);
	Reg#(Bit#(4)) received <- mkReg(0);
    BMVM_Server mod <- mkEllBMVM(0);
	Bit#(224) x = 0;
	rule send(sent != 5);
		mod.put(x - 1); //All 1s
		sent <= sent + 1;
	endrule
	
	rule receive;
		$display("Value: %0b\n", mod.get());
		received <= received + 1;
		if (received == 4)
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
