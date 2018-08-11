This folder contains following sub-folders:
1)Berlekamp_Massey 	:Contains files for Berlekamp module.
2)BMVM 					:Contains files for BMVM (inefficient) module.
3)ELL_BMVM				:Contains files for sparse matrix based BMVM module.
4)Wiedemann				:Contains files for Wiedemann module (and all module files).

All these subfolders have bsv files of the corresponding module and a testbench file "Tb.bsv" which is used for running verilog simulations.
The first 3 sub-folder contains individual files of all modules while the 4th one contain the Wiedemann module and the all 
individual module files. 

Every subfolder has a file "Tb.bsv"-tesbench file- which has to be executed for running codes.
Steps for running code for a particular module:
1) Go in the subsequent sub-folder
2) Open terminal in that deirectory
3) Enter command "make". 
4) Enter command "make vexe". This command makes verilog executable.
5) Enter command "make vsim". This command runs verilog simulation.
Note: If you make changes in the bsv file, you have to run "make vexe" before running "make vsim". If you make change in any bsv file
other than "Tb.bsv", you have to run the command "make fullclean" before running "make vexe".
