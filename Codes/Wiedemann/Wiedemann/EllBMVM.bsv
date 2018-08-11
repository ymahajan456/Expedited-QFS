// Author : OV Shashank
// Roll No: 14D070021
// ELLPACK Sparse Format based Boolean Matrix Vector Multiplication

package EllBMVM;

import BRAM::*;
import ClientServer::*;
import Clocks::*;
import FIFOF::*;

interface BMVM_Server;
    method ActionValue#(Bit#(224)) get();
    method Action put(Bit#(224) x);
endinterface: BMVM_Server

(* synthesize *)
module mkEllBMVM #(parameter int lut_num) (BMVM_Server);

    Reg#(Bit#(2)) state <- mkReg(0);		// FSM State Variable
    Reg#(Bit#(8)) row_num <- mkReg(0);		// Row being processed
	Reg#(Bit#(224)) in <- mkReg(0);			// Value popped from the input FIFO
	Reg#(Bit#(224)) out <- mkReg(0);			// Temporary store for output value
	FIFOF#(Bit#(224)) in_fifo <- mkFIFOF; 		// Input FIFO
	FIFOF#(Bit#(224)) out_fifo <- mkFIFOF;		// Output FIFO
	
	String fileName = "ell.mem";
    
    BRAM_Configure cfg = defaultValue;	//BRAM Configuration
    cfg.memorySize = 224;
    cfg.allowWriteResponseBypass = False;
    cfg.loadFormat = tagged Binary fileName;
    BRAM1Port#(Bit#(8), Bit#(73)) lut <- mkBRAM1Server(cfg);	//BRAM Instance

	//Initial Starting State
    rule initiateBMVM(state == 0 && in_fifo.notEmpty);
       	in <= in_fifo.first(); in_fifo.deq();	//Get input from the Input FIFO
       	lut.portA.request.put(BRAMRequest{address:pack(row_num), datain:?, responseOnWrite:False, write:False});	//Send request to obtain next row column indices
        //$display ("Request Recevived %s", fileName);    
        state <= 1;
        row_num <= row_num + 1;
    endrule
    
    //State that performs BMVM
    rule receive(state == 1 || state == 2);
    	if (row_num == 225 && state == 2)	// After all rows have been processed
        	state <= 3;
        else begin	
		    if (row_num == 224) // Last row being processed
		    	state <= 2;
			lut.portA.request.put(BRAMRequest{address:pack(row_num), datain:?, responseOnWrite:False, write:False});
			Bit#(73) row <- lut.portA.response.get;	//Get requested data
			//$display("Row Entry Read: %0b", row);	
			Bit#(1) out_temp;	//To store intermediate XORed values
			Bit#(8) valid = 0;	//To invalidate padding 0s 
			for (int i = 0; i < 8; i = i + 1)
		  		valid[i] = row[i * 8] | row[i * 8 + 1] | row[i * 8 + 2] | row[i * 8 + 3] | row[i * 8 + 4] | row[i * 8 + 5] | row[i * 8 + 6] | row[i * 8 + 7];
		  	//Int#(5) row_part = unpack(row[4:0]);
			out_temp = row[72] & in[row[71:64]];	//MSB holds information of empty rows
			for (int i = 0; i < 8; i = i + 1) begin
				Bit#(8) row_part = row[i*8 + 7 : i*8];
				out_temp = out_temp ^ (in[row_part] & valid[i]);
			end
			out[row_num - 1] <= out_temp;
			// $display ("Completed Obtaining Data: %0d", test.portA.response.get);     
			row_num <= row_num + 1;
        end
    endrule
    
    //Final State to push to Output FIFO and Reset
    rule complete (state == 3);
   		out_fifo.enq(out);
   		state <= 0;
   		row_num <= 0;
		lut.portAClear;
   	endrule
	
	rule testing;
		//$display("State : %d, Row: %d", state, row_num);
	endrule
    
    // Get value from the Module    
    method ActionValue#(Bit#(224)) get();
    	let val = out_fifo.first;
    	out_fifo.deq;
    	return val;
    endmethod: get

    // Send value to Module    
    method Action put(Bit#(224) x);
    	in_fifo.enq(x);
    endmethod: put
    
    //interface req = fifoToPut(in_FIFO);
	//interface res = fifoToGet(out_FIFO);

endmodule: mkEllBMVM

endpackage: EllBMVM
