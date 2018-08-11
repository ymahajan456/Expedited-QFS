package Tb;
import Randomizable::*;
(* synthesize *)
module mkTb (Empty);
	
Reg#(int) initialized <- mkReg(0); 
  Randomize#(Bit#(224)) x_destination <- mkGenericRandomizer; 

  rule init (initialized==0);
    x_destination.cntrl.init(); 
    initialized <= initialized+1; 
  endrule 
  rule display_number1(initialized==1); 
    let n <- x_destination.next(); 
    $display("The current number is: %b", n); 
	 initialized <= initialized+1;
  endrule 

  rule display_number2(initialized==2); 
    let m<- x_destination.next(); 
    $display("The current number is: %b", m); 
	 $finish (0);
  endrule 
			

endmodule: mkTb

endpackage: Tb




