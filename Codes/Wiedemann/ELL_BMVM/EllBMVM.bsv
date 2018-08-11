// Author : OV Shashank
// Roll No: 14D070021
// ELLPACK Sparse Format based Boolean Matrix Vector Multiplication

package EllBMVM;

import BRAM::*;
import ClientServer::*;
import Clocks::*;
import FIFO::*;

interface BMVM_Server;
    method ActionValue#(Bit#(32)) get();
    method Action put(Bit#(32) x);
endinterface: BMVM_Server

(* synthesize *)
module mkEllBMVM #(parameter int lut_num) (BMVM_Server);

    Reg#(Bit#(2)) state <- mkReg(0);		// FSM State Variable
    Reg#(Bit#(5)) row_num <- mkReg(0);		// Row being processed
	Reg#(Bit#(32)) in <- mkReg(0);			// Value popped from the input FIFO
	Reg#(Bit#(32)) out <- mkReg(0);			// Temporary store for output value
	FIFO#(Bit#(32)) in_fifo <- mkFIFO; 		// Input FIFO
	FIFO#(Bit#(32)) out_fifo <- mkFIFO;		// Output FIFO
	
	//String intStrings[12] = { "LUT/ell0.mem" , "LUT/ell1.mem", "LUT/ell2.mem", "LUT/ell3.mem", "LUT/ell4.mem", "LUT/ell5.mem", "LUT/ell6.mem", "LUT/ell7.mem", "LUT/ell8.mem", "LUT/ell9.mem", "LUT/ell10.mem", "LUT/ell11.mem"};//, "LUT/ell12.mem", "LUT/ell13.mem", "LUT/ell14.mem", "LUT/ell15.mem", "LUT/ell16.mem", "LUT/ell17.mem", "LUT/ell18.mem", "LUT/ell19.mem", "LUT/ell20.mem", "LUT/ell21.mem", "LUT/ell22.mem", "LUT/ell23.mem", "LUT/ell24.mem", "LUT/ell25.mem", "LUT/ell26.mem", "LUT/ell27.mem", "LUT/ell28.mem", "LUT/ell29.mem", "LUT/ell30.mem", "LUT/ell31.mem" };
	String fileName = /*"ell.mem";*/"../ELL_BMVM/LUT/ell4.mem";// + intStrings[lut_num] + ".mem";*/
    
    BRAM_Configure cfg = defaultValue;	//BRAM Configuration
    cfg.memorySize = 32;
    cfg.allowWriteResponseBypass = False;
    cfg.loadFormat = tagged Binary fileName;
    BRAM1Port#(Bit#(5), Bit#(26)) lut <- mkBRAM1Server(cfg);	//BRAM Instance

	//Initial Starting State
    rule initiateBMVM(state == 0);
       	in <= in_fifo.first(); in_fifo.deq();	//Get input from the Input FIFO
       	lut.portA.request.put(BRAMRequest{address:pack(row_num), datain:?, responseOnWrite:False, write:False});	//Send request to obtain next row column indices
        //$display ("Request Recevived %s", fileName);    
        state <= 1;
        row_num <= row_num + 1;
    endrule
    
    //State that performs BMVM
    rule receive(state == 1 || state == 2);
    	if (row_num == 0 && state == 2)	// After all rows have been processed
        	state <= 3;
        else begin	
		    if (row_num == 0)	// Last row being processed
		    	state <= 2;
			lut.portA.request.put(BRAMRequest{address:pack(row_num), datain:?, responseOnWrite:False, write:False});
			Bit#(26) row <- lut.portA.response.get;	//Get requested data
			//$display("Row Entry Read: %0b", row);	
			Bit#(1) out_temp;	//To store intermediate XORed values
			Bit#(4) valid = 0;	//To invalidate padding 0s 
			for (int i = 0; i < 4; i = i + 1)
		  		valid[i] = row[i * 5] | row[i * 5 + 1] | row[i * 5 + 2] | row[i * 5 + 3] | row[i * 5 + 4];
		  	//Int#(5) row_part = unpack(row[4:0]);
			out_temp = row[25] & in[row[24:20]];	//MSB holds information of empty rows
			for (int i = 0; i < 4; i = i + 1) begin
				Bit#(5) row_part = row[i*5 + 4 : i*5];
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
   	endrule

    //rule complete(ad == 15 && state == 0);
    //    $finish (0);
    //endrule
    
    // Get value from the Module    
    method ActionValue#(Bit#(32)) get();
    	let val = out_fifo.first;
    	out_fifo.deq;
    	return val;
    endmethod: get

    // Send value to Module    
    method Action put(Bit#(32) x);
    	in_fifo.enq(x);
    endmethod: put
    
    //interface req = fifoToPut(in_FIFO);
	//interface res = fifoToGet(out_FIFO);

endmodule: mkEllBMVM

endpackage: EllBMVM
