// Author : OV Shashank
// Roll No: 14D070021
// Conversion of Matrix to Block Level ELL Format
// Amenable to be loaded into Bluespec BRAM

#include <iostream>
#include <fstream>
#include <algorithm>

using namespace std;
#define NUM_BLOCKS 7 
#define BLOCK_SIZE 32
#define ELL_ROW 5

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

    ofstream ell_file;
    string ell_lut = "./LUTs/ell";
	for(int i = 0; i < NUM_BLOCKS; i++) {
		for(int j = 0; j < NUM_BLOCKS; j++){
            ell_file.open(ell_lut + to_string(i*NUM_BLOCKS + j) + ".mem");
            for(int k = 0; k < BLOCK_SIZE; k++) {
                string store = "";
                ell_file << "@" << dtoany(k, 16, 2) << " ";
                for(int l = 0; l < BLOCK_SIZE; l++){
                    val = mat[i*BLOCK_SIZE + k][j*BLOCK_SIZE + l];
                    if(val)
                        store += dtoany(l, 2, 5);
                    nnz += val;
				}
                for(int l = nnz; l < ELL_ROW; l++)
                    store += "00000";
                ell_file << ((nnz == 0) ? "0" : "1") << store << endl;
                nnz = 0;
            }
            nnz = 0;
            ell_file.close();
        }
	}
    
}