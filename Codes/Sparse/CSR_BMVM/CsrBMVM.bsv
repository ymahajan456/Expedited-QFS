// Author : OV Shashank
// Roll No: 14D070021
// Compressed Sparse Row based Boolean Matrix Vector Multiplication

package CsrBMVM;

typedef 32								Dim;		//Dimension of the Matrix
typedef TLog#(Dim)						Width;		//Log_2 of the Dimension
typedef 6								NNZWidth;	//Address Width for Non-Zero Numbers

import BRAM::*;
import ClientServer::*;
import Clocks::*;
import FIFO::*;

// BMVM Standard Interface
interface BMVM_Server;
    method ActionValue#(Bit#(Dim)) get();
    method Action put(Bit#(Dim) x);
endinterface: BMVM_Server

(* synthesize *)
module mkCsrBMVM #(parameter int lut_num) (BMVM_Server);

    Reg#(Bit#(2)) state <- mkReg(0);			//FSM State Variable
    Reg#(Bit#(Width)) row_num <- mkReg(0);		//Row number being processed
    Reg#(Bit#(NNZWidth)) nz_num <- mkReg(0);	//Non-zero element count being processed
    
	Reg#(Bit#(Dim)) in <- mkReg(0);			//Vector popped from the input FIFO
	Reg#(Bit#(Dim)) out <- mkReg(0);		//Output vector to store temporary values
	FIFO#(Bit#(Dim)) in_fifo <- mkFIFO; 	//Input FIFO
	FIFO#(Bit#(Dim)) out_fifo <- mkFIFO;	//Output FIFO
	
	Reg#(Bit#(NNZWidth)) row_start <- mkReg(0);		//CSR Row Starting Index [Redundant]
	Reg#(Bit#(NNZWidth)) row_end <- mkReg(0);		//CSR Row Ending Index
	Bit#(Width) row_max = fromInteger(valueOf(TSub#(Dim, 1)));

	String fileName = "../CSR_BMVM/LUT/";	//Base file name

    	
    BRAM_Configure cfg = defaultValue;		//BRAM Configuration
    cfg.memorySize = valueOf(TExp#(NNZWidth));
    cfg.allowWriteResponseBypass = False;
    //cfg.outFIFODepth = 100;
    cfg.loadFormat = tagged Binary (fileName + "nnz7.mem");
    BRAM1Port#(Bit#(NNZWidth), Bit#(Width)) lut_nnz <- mkBRAM1Server(cfg);	//BRAM Instance holding the non-zero value column indices
    cfg.memorySize = valueOf(Dim);
    cfg.loadFormat = tagged Binary (fileName + "row7.mem");
    BRAM1Port#(Bit#(Width), Bit#(NNZWidth)) lut_row <- mkBRAM1Server(cfg);	//BRAM Instance holding the row boundaries 
    
    //Initial Starting State
    rule initiateBMVM(state == 0);	
       	//$display ("State 0");
       	in <= in_fifo.first(); in_fifo.deq();	//Obtain input - Rule deactivated if Input FIFO is empty 
       	lut_row.portA.request.put(BRAMRequest{address:pack(row_num), datain:?, responseOnWrite:False, write:False});	//Request next element of row boundaries
       	//$display("Row Request");
        //$display ("Request Recevived %s", fileName);    
        state <= 1;	//Move to next state
        row_num <= row_num + 1;	//Move to next row boundary index
    endrule
    
    //State handling transition between rows
    rule initiateRow(state == 1);
    	//$display ("State 1");
    	Bit#(NNZWidth) curr_row_end <- lut_row.portA.response.get;	//Obtain value requested from row boundary BRAM
    	//$display("Row Response %0b", curr_row_end);
    	row_end <= curr_row_end;
    	row_start <= curr_row_end;
    	if(curr_row_end == row_start) begin	//Empty Row
			if(row_num == row_max + 1)
				state <= 3;
			else begin
				row_num <= row_num + 1;
				lut_row.portA.request.put(BRAMRequest{address:pack(row_num), datain:?, responseOnWrite:False, write:False});
				//$display("Row Request");
			end
    	end
    	else begin	//Some Non-Zero elements exist
   			lut_nnz.portA.request.put(BRAMRequest{address:pack(nz_num), datain:?, responseOnWrite:False, write:False});
    		state <= 2;
			nz_num <= nz_num + 1;
    	end    		
    endrule
    
    //Performs the BMVM for every Non-Zero Element
    rule multiplyRow(state == 2);
    	//$display ("State 2");
    	if(nz_num == row_end + 1) begin	// If the row has been handled
    	    if (row_num == row_max + 1) begin	// If all rows have been handled
    	    	state <= 3;
    	    end
    	    else begin				// Else move to next row
    	    	state <= 1;
				lut_nnz.portAClear();
				lut_row.portA.request.put(BRAMRequest{address:pack(row_num), datain:?, responseOnWrite:False, write:False});
				row_num <= row_num + 1;
				nz_num <= nz_num - 1;
				//$display("Row Request");
    		end
    	end
		else begin	//Handle a Non-Zero Element
			Bit#(Width) nz_col <- lut_nnz.portA.response.get;
			$display("%0b", nz_col);
		   	lut_nnz.portA.request.put(BRAMRequest{address:pack(nz_num), datain:?, responseOnWrite:False, write:False});
			out[row_num - 1] <= out[row_num - 1] ^ in[nz_col];	// Performing the Addition of BMVM
			nz_num <= nz_num + 1;
		end
    endrule
    
    //Final State to push to Output FIFO and Reset
    rule complete (state == 3);	
    	//$display ("State 3");
   		out_fifo.enq(out);
   		state <= 0;
   		row_num <= 0;
   		nz_num <= 0;
		lut_nnz.portAClear();
		lut_row.portAClear();
   	endrule

	//rule testing;
	//	$display("State : %d, Row: %d, NNZ: %d", state, row_num, nz_num);
	//endrule
	
    //rule complete(ad == 15 && state == 0);
    //    $finish (0);
    //endrule
    
    // Get value from the Module
    method ActionValue#(Bit#(Dim)) get();
    	let val = out_fifo.first;
    	out_fifo.deq;
    	return val;
    endmethod: get
    
    // Send value to Module
    method Action put(Bit#(Dim) x);
    	in_fifo.enq(x);
    endmethod: put
    
    //interface req = fifoToPut(in_FIFO);
	//interface res = fifoToGet(out_FIFO);

endmodule: mkCsrBMVM

endpackage: CsrBMVM
