// Author : OV Shashank
// Roll No: 14D070021
// BRAM testing and learning 101 file

package Tb;

import BRAM::*;
import ClientServer::*;
import Clocks::*;
import StmtFSM::*;

(* synthesize *)
module mkTb (Empty);

    //Ifc_type  ifc <- mkModuleDeepThought;
    Reg#(Bit#(1)) state <- mkReg(0);
    Reg#(Bit#(4)) ad <- mkReg(0);

    BRAM_Configure cfg = defaultValue;
    cfg.memorySize = 16;
    cfg.allowWriteResponseBypass = False;
    cfg.loadFormat = tagged Binary "lut.mem";

    BRAM1Port#(Bit#(4), Bit#(4)) test <- mkBRAM1Server(cfg);

    rule sendRequest(state == 0 && ad <= 15);
        test.portA.request.put(BRAMRequest{address:pack(ad), datain:?, responseOnWrite:False, write:False});
        $display ("Completed Requesting at Address: %0d", ad);    
        state <= 1;
        ad <= ad + 1;
    endrule
    
    rule receive(state == 1);
        $display ("Completed Obtaining Data: %0d", test.portA.response.get);    
        state <= 0;
    endrule

    rule complete(ad == 15 && state == 0);
        $finish (0);
    endrule

    rule theUltimateAnswer;
        //$display ("Hello World! The answer is: %0d", 10 + 20);
    endrule

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
