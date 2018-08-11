// Author : OV Shashank
// Roll No: 14D070021
// Apply random permutation of columns to break
// pattern of Matrices generated by Quadratic Field Sieve

#include <iostream>
#include <fstream>
#include <vector>
#include <time.h>
#include <algorithm>
#include <cstdlib>

#define MATRIX_SIZE 32*7
using namespace std;

int lt_rand(int lt){
    return rand() % lt;
}
int main(){
    ifstream matrix("output_matrix");
	int count = 0, element, nnz = 0, mat[MATRIX_SIZE][MATRIX_SIZE];
	for(int i = 0; i < MATRIX_SIZE; i++) {
		for(int j = 0; j < MATRIX_SIZE; j++) {
			matrix >> mat[i][j];
		}
	}
	
    srand(time(NULL));
    vector<int> permutation;
    for(int i = 0; i < MATRIX_SIZE; i++){
        permutation.push_back(i);
    }
    for(int i = 0; i < 10; i++)
        random_shuffle(permutation.begin(), permutation.end(), lt_rand);

    ofstream perm_matrix("permuted_matrix");
    for(int i = 0; i < MATRIX_SIZE; i++) {
		for(int j = 0; j < MATRIX_SIZE; j++) {
			perm_matrix << mat[i][permutation[j]] << endl;
		}
	}
    for(int i = 0; i < MATRIX_SIZE; i++) {
        perm_matrix << permutation[i] << endl;
    }    

}