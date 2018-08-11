package Tb;

import CsrBMVM::*;
import BRAM::*;
import ClientServer::*;
import Clocks::*;
import StmtFSM::*;

(* synthesize *)
module mkTb (Empty);

    //Ifc_type  ifc <- mkModuleDeepThought;
    BMVM_Server mod <- mkCsrBMVM(0);
	Reg#(Bit#(1)) sent <- mkReg(0);
	
	rule send(sent == 0);
		mod.put(pack(4294967295));	//All 1s
		sent <= 1;
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
