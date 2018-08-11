//Author: Ajinkya D. Kharalkar (14D070031)
//This file contains an inefficient implementation of BMVM for the testing of Wiedemann algorithm
package BMVM;
import Vector::*;
typedef 4 Size;
typedef TMul#(Size, Size) Matrix_Size;	

interface BMVM_Server;
    method ActionValue#(Bit#(Size)) get();	//output
    method Action put(Bit#(Size) x);			//input
endinterface: BMVM_Server

(* synthesize *)
module mkBMVM (BMVM_Server);

	Reg#(Bit#(Size)) x_in <- mkReg(0);
	Reg#(bit) start_bit <- mkReg(0);
   
	
	Bit#(Matrix_Size) a;
	a=16'b1010111001011010;		//hard coded A matrix

	method ActionValue#(Bit#(Size)) get ();
	Bit#(Size) sum=0;	

//-------------------Matrix multiplication---------------------//
		for (int i=0; i<fromInteger(valueOf(Size)); i=i+1)
			for (int j=0; j<fromInteger(valueOf(Size)); j=j+1)
				sum[i]=sum[i]^(a[fromInteger(valueOf(Size))*i+j] & x_in[j]);
		
			
      return sum;
   endmethod 
   
	method  Action put (x);
		x_in<=x;		
	endmethod 

endmodule: mkBMVM

endpackage: BMVM

