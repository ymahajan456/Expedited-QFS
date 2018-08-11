package BMVM;
import Vector::*;
typedef 3 Size;
typedef TMul#(Size, Size) Matrix_Size;	

interface BMVM_Server;
    method ActionValue#(Bit#(Size)) get();
    method Action put(Bit#(Size) x);
endinterface: BMVM_Server

(* synthesize *)
module mkBMVM (BMVM_Server);

	Reg#(Bit#(Size)) x_in <- mkReg(0);
	Reg#(bit) start_bit <- mkReg(0);
   
	
	Bit#(Matrix_Size) a;
	a=9'b101011100;

	method ActionValue#(Bit#(Size)) get ();
	Bit#(Size) sum=0;	
		for (int i=0; i<fromInteger(valueOf(Size)); i=i+1)
			for (int j=0; j<fromInteger(valueOf(Size)); j=j+1)
				sum[i]=sum[i]^(a[fromInteger(valueOf(Size))*j+i] & x_in[j]);
		
			
      return sum;
   endmethod 
   
	method  Action put (x);
		x_in<=x;
	endmethod 

endmodule: mkBMVM

endpackage: BMVM

