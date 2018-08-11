// Author : OV Shashank
// Roll No: 14D070021
// Conversion of Matrix to Block Level CSR Format
// Amenable to be loaded into Bluespec BRAM

#include <iostream>
#include <fstream>
#include <algorithm>

using namespace std;
#define NUM_BLOCKS 7 
#define BLOCK_SIZE 32

string dtoany(int num, int base, int len)
{
	string binary  = "";
	while(num!=0&&binary.length()!=len)
	{
        char rem;
        if(num%base>9)
            rem='a'+num%base-10;
        else
            rem='0'+num%base;
		binary=rem+binary;
		num=num/base;
	}
	for(int i=binary.length();i<len;i++)
	{
        binary='0'+binary;
	}

	return binary;
}

int main(){
    ifstream matrix("permuted_matrix");
	int count1 = 0, count2 = 0, val, nnz = 0, mat[BLOCK_SIZE*NUM_BLOCKS][BLOCK_SIZE*NUM_BLOCKS];
	for(int i = 0; i < BLOCK_SIZE*NUM_BLOCKS; i++) {
		for(int j = 0; j < BLOCK_SIZE*NUM_BLOCKS; j++) {
			matrix >> mat[i][j];
		}
	}    

    ofstream nnz_file, row_file;
    string nnz_lut = "./LUTs/nnz", row_lut = "./LUTs/row";
	for(int i = 0; i < NUM_BLOCKS; i++) {
		for(int j = 0; j < NUM_BLOCKS; j++){
            nnz_file.open(nnz_lut + to_string(i*NUM_BLOCKS + j) + ".mem");
			row_file.open(row_lut + to_string(i*NUM_BLOCKS + j) + ".mem");
            for(int k = 0; k < BLOCK_SIZE; k++) {
                for(int l = 0; l < BLOCK_SIZE; l++){
                    val = mat[i*BLOCK_SIZE + k][j*BLOCK_SIZE + l];
                    if(val)
                        nnz_file << "@" << dtoany(nnz, 16, 2) << " " << dtoany(l, 2, 5) << endl;
                    nnz += val;
				}
				row_file << "@" << dtoany(k, 16, 2) << " " << dtoany(nnz, 2, 6) << endl;
            }
            nnz = 0;
            nnz_file.close();
            row_file.close();
		}
	}
    
}