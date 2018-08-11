// Author : OV Shashank
// Roll No: 14D070021
// Brute-Force BMVM for Testbench Purposes

#include <iostream>
#include <fstream>
using namespace std;

#define NUM_BLOCKS 7 
#define BLOCK_SIZE 32

int main(){
	int block; cin >> block;
	int row = block / NUM_BLOCKS, column = block % NUM_BLOCKS;
	bool x[BLOCK_SIZE] = {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
						1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1};
	ifstream matrix("permuted_matrix");
	int count = 0, element, nnz = 0, mat[BLOCK_SIZE*NUM_BLOCKS][BLOCK_SIZE*NUM_BLOCKS];
	for(int i = 0; i < BLOCK_SIZE*NUM_BLOCKS; i++) {
		for(int j = 0; j < BLOCK_SIZE*NUM_BLOCKS; j++) {
			matrix >> mat[i][j];
		}
	}
	 
	bool out[BLOCK_SIZE] = {false};
	for(int k = 0; k < BLOCK_SIZE; k++) {
		for(int l = 0; l < BLOCK_SIZE; l++){
			out[k] = (out[k] != (x[l] && mat[row*BLOCK_SIZE + k][column*BLOCK_SIZE + l]));
			//cout << "(" << i*BLOCK_SIZE + k << ", " << j*BLOCK_SIZE + l << ")" << endl;
		}
	}
	for(int i = 0; i < BLOCK_SIZE; i++)
		cout << out[BLOCK_SIZE - 1 - i];
	cout << endl;
}

