// Author : OV Shashank
// Roll No: 14D070021
// Sparsity Analysis of a Matrix

#include <iostream>
#include <fstream>
using namespace std;

#define NUM_BLOCKS 7 
#define BLOCK_SIZE 32

int main(){

	//Reading matrix from serially written file (Row-Major Format)
	ifstream matrix("permuted_matrix");
	ofstream ofile("out.csv");
	int count = 0, element, nnz = 0, mat[BLOCK_SIZE*NUM_BLOCKS][BLOCK_SIZE*NUM_BLOCKS];
	for(int i = 0; i < BLOCK_SIZE*NUM_BLOCKS; i++) {
		for(int j = 0; j < BLOCK_SIZE*NUM_BLOCKS; j++) {
			matrix >> mat[i][j];
			ofile << mat[i][j] << ",";
		}
		ofile << endl;
	}
	
	// Block-Wise # of Non-Zero Counts
	cout << "Sparsity Analysis:\n";
	for(int i = 0; i < NUM_BLOCKS; i++) {
		for(int j = 0; j < NUM_BLOCKS; j++){
			nnz = 0;
			for(int k = 0; k < BLOCK_SIZE; k++)
				for(int l = 0; l < BLOCK_SIZE; l++){
					nnz += mat[i*BLOCK_SIZE + k][j*BLOCK_SIZE + l];
					//cout << "(" << i*BLOCK_SIZE + k << ", " << j*BLOCK_SIZE + l << ")" << endl;
				}
				//cin >> count;
			cout << nnz << "\t";
		//cout << "NNZ: " << nnz << " Percentage: " << 100*double(nnz)/BLOCK_SIZE/BLOCK_SIZE << endl;
		}
		cout << endl;
	}
	
	// Full Matrix NNZ per Row Analysis
	cout << "Analysis for ELLPACK format: \n";
	int row_nnz[NUM_BLOCKS*BLOCK_SIZE] = {0};
	double mean = 0, sd = 0, maximum = 0;
	for(int i = 0; i < BLOCK_SIZE*NUM_BLOCKS; i++){
		row_nnz[i] = 0;
		for(int j = 0; j < BLOCK_SIZE*NUM_BLOCKS; j++){
			row_nnz[i] += mat[i][j];
		}
		cout << row_nnz[i] << " ";
		mean += row_nnz[i];
	}
	mean = mean / BLOCK_SIZE / NUM_BLOCKS;
	for(int i = 0; i < BLOCK_SIZE*NUM_BLOCKS; i++){
		sd += (row_nnz[i] - mean) * (row_nnz[i] - mean);
		maximum = row_nnz[i] < maximum ? maximum : row_nnz[i];
	}
	sd = sd / BLOCK_SIZE / NUM_BLOCKS;
	cout << endl;

	cout << "Mean: " << mean << " Variance: " << sd << " Maximum: " << maximum << endl;
	
	// Block Level Matrix NNZ per Row Analysis
	cout << "Analysis for Block Level ELLPACK format: \n";
	int brow_nnz[BLOCK_SIZE] = {0};
	for(int i = 0; i < NUM_BLOCKS; i++) {
		for(int j = 0; j < NUM_BLOCKS; j++) {
			mean = sd = maximum = 0;
			for(int k = 0; k < BLOCK_SIZE; k++) {
				brow_nnz[k] = 0;
				for(int l = 0; l < BLOCK_SIZE; l++){
					brow_nnz[k] += mat[i*BLOCK_SIZE + k][j*BLOCK_SIZE + l];
				}
				cout << brow_nnz[k] << " ";
				mean += brow_nnz[k];
			}
			mean = mean / BLOCK_SIZE;
			for(int i = 0; i < BLOCK_SIZE; i++){
				sd += (brow_nnz[i] - mean) * (brow_nnz[i] - mean);
				maximum = (brow_nnz[i] < maximum) ? maximum : brow_nnz[i];
			}
			sd = sd / BLOCK_SIZE;
			cout << endl;

			cout << "Mean: " << mean << " Variance: " << sd << " Maximum: " << maximum << endl;
		}
	}
}
