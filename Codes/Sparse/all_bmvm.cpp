// Author : OV Shashank
// Roll No: 14D070021
// Brute-Force BMVM for Testbench Purposes

#include <iostream>
#include <fstream>
using namespace std;

#define NUM_BLOCKS 7 
#define BLOCK_SIZE 32

int main(){
	bool x[BLOCK_SIZE*NUM_BLOCKS];
	for(int i = 0; i < BLOCK_SIZE*NUM_BLOCKS; i++)
		x[i] = true;

	ifstream matrix("permuted_matrix");
	int count = 0, element, nnz = 0, mat[BLOCK_SIZE*NUM_BLOCKS][BLOCK_SIZE*NUM_BLOCKS];
	for(int i = 0; i < BLOCK_SIZE*NUM_BLOCKS; i++) {
		for(int j = 0; j < BLOCK_SIZE*NUM_BLOCKS; j++) {
			matrix >> mat[i][j];
		}
	}
	 
	bool out[BLOCK_SIZE*NUM_BLOCKS] = {false};
	for(int k = 0; k < BLOCK_SIZE*NUM_BLOCKS; k++) {
		for(int l = 0; l < BLOCK_SIZE*NUM_BLOCKS; l++){
			out[k] = (out[k] != (x[l] && mat[k][l]));
			//cout << "(" << i*BLOCK_SIZE + k << ", " << j*BLOCK_SIZE + l << ")" << endl;
		}
	}
	for(int i = 0; i < BLOCK_SIZE*NUM_BLOCKS; i++)
		cout << out[BLOCK_SIZE*NUM_BLOCKS - 1 - i];
	cout << endl;
}

