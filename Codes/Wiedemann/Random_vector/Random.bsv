package Tb;
import Randomizable::*;
module mkDisplayRandom(Empty); 
  Reg#(Bool) initialized <- mkReg(False); 
  Randomize#(Bit#(4)) x_destination <- mkConstrainedRandomizer(0,10); 

  rule init (!initialized) ;
    x_destination.ctrl.init(); 
    initialized <= True; 
  endrule 

  rule display_number(initialized); 
    let n <- x_destination.next(); 
    $display("The current number is: %h", n); 
  endrule 

endmodule
endpackage 
