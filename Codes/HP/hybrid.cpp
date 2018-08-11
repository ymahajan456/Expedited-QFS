#include <math.h>
#include <mpi.h>
#include <stdlib.h>
#include <unistd.h>
#include <iostream>
#include <stdint.h>
#include <stdio.h>
#include <vector>
#include <fstream>
#include <sys/types.h>
#include <sys/wait.h>
#include <signal.h>

#include <cstdio>
#include "stdafx.h"
using namespace std;


int main(int argc, char **argv) {
    /* Declare variables */
    uinthp_t N = (uinthp_t) pow(2, sizeof(uinthp_t)*8); /* The positive integer under which we are finding primes */
    uinthp_t sqrtN = 0; /* The square root of N, which is stored in a variable to 
                      avoid making excessive calls to sqrt(N) */
    uinthp_t c = 0; /* Used to check the next number to be circled */
    uinthp_t m = 0; /* Used to check the next number to be marked */
    uinthp_t *list1; /* The list of numbers <= sqrtN -- if list1[x] equals 1, then x 
                   is marked.  If list1[x] equals 0, then x is unmarked. */
    uinthp_t *list2; /* The list of numbers > sqrtN -- if list2[x-L] is marked, then 
                   x is marked.  If list2[x-L] equals 0, then x is unmarked. */
    char next_option = ' '; /* Used for parsing command line arguments */
    uinthp_t S = 0; /* A near-as-possible even split of the count of numbers above 
                  sqrtN */
    int R = 0; /* The remainder of the near-as-possible even split */
    uinthp_t L = 0; /* The lowest number in the current process's split */
    uinthp_t H = 0; /* The highest number in the current process's split */
    int r = 0; /* The rank of the current process */
    int p = 0; /* The total number of processes */

    uinthp_t printCount = 0;

    /* Initialize the MPI Environment */
    MPI_Init(&argc, &argv);

    /* Determine the rank of the current process and the number of processes */
    MPI_Comm_rank(MPI_COMM_WORLD, &r);
    MPI_Comm_size(MPI_COMM_WORLD, &p);
   
    /* Parse command line arguments -- enter 'man 3 getopt' on a shell to see
       how this works */
    while((next_option = getopt(argc, argv, "n:")) != -1) {
        switch(next_option) {
            case 'n':
                N = atoi(optarg);
                break;
            case '?':
            default:
                fprintf(stderr, "Usage: %s [-n N]\n", argv[0]);
                exit(-1);
        }
    }


    /* Calculate sqrtN */
    sqrtN = (uinthp_t)sqrt(N);

    /* Calculate S, R, L, and H */
    S = (N-(sqrtN+1)) / p;
    R = (N-(sqrtN+1)) % p;
    L = sqrtN + r*S + 1;
    H = L+S-1;
    if(r == p-1) {
        H += R;
    }

    /* Allocate memory for lists */
    list1 = (uinthp_t*)malloc((sqrtN+1) * sizeof(uinthp_t));
    list2 = (uinthp_t*)malloc((H-L+1) * sizeof(uinthp_t));

    cout << "Size of list 1 is " << (sqrtN+1) * sizeof(uinthp_t) <<endl;
    cout << "Size of list 2 is " << (H-L+1) * sizeof(uinthp_t) <<endl;

    ofstream binFile;
    binFile.open("primesBin.yo", ios::out | ios::binary);

    ofstream textFile;
    textFile.open("primesText.txt" , ios::out );

    ofstream markerFile;
    markerFile.open("markers.yo", ios::out | ios::binary);

    /* Exit if malloc failed */
    if(list1 == NULL) {
        fprintf(stderr, "Error: Failed to allocate memory for list1.\n");
        exit(-1);
    }
    if(list2 == NULL) {
        fprintf(stderr, "Error: Failed to allocate memory for list2.\n");
        exit(-1);
    }

    /* Run through each number in list1 */
#pragma omp parallel for
    for(c = 2; c <= sqrtN; c++) {

        /* Set each number as unmarked */
        list1[c] = 0;
    }
    
    /* Run through each number in list2 */
#pragma omp parallel for
    for(c = L; c <= H; c++) {

        /* Set each number as unmarked */
        list2[c-L] = 0;
    }

    /* Run through each number in list1 */
    for(c = 2; c <= sqrtN; c++) {

        /* If the number is unmarked */
        if(list1[c] == 0) {

            /* Run through each number bigger than c in list1 */
#pragma omp parallel for
            for(m = c+1; m <= sqrtN; m++) {

                /* If m is a multiple of c */
                if(m%c == 0) {

                    /* Mark m */
                    list1[m] = 1;
                }
            }

            /* Run through each number bigger than c in list2 */
#pragma omp parallel for
            for(m = L; m <= H; m++)
            {
                /* If m is a multiple of C */
                if(m%c == 0)
                {
                    /* Mark m */
                    list2[m-L] = 1;
                }
            }
        }
    }

    /* If Rank 0 is the current process */
    if(r == 0) {

        /* Run through each of the numbers in list1 */
        for(c = 2; c <= sqrtN; c++) {

            /* If the number is unmarked */
            if(list1[c] == 0) {

                /* The number is prime, print it */
                // printf("%d ", c);
                // cout << c << endl;
                textFile << c << endl;
                binFile.write((char*)&c, sizeof(c));
                printCount ++;
                if(printCount == 1000)
                {
                    // markerFile.write((char*)&printCount, sizeof(c));
                    // cout << c << endl;
                    markerFile.write((char*)&c, sizeof(c));
                    printCount = 0;
                }
            }
        }

        /* Run through each of the numbers in list2 */
        for(c = L; c <= H; c++) {

            /* If the number is unmarked */
            if(list2[c-L] == 0) {

                /* The number is prime, print it */
                // printf("%d ", c);
                // cout << c << endl;
                textFile << c << endl;
                binFile.write((char*)&c, sizeof(c));
                printCount ++;
                if(printCount == 1000)
                {
                    // markerFile.write((char*)&printCount, sizeof(c));
                    // cout << c << endl;
                    markerFile.write((char*)&c, sizeof(c));
                    printCount = 0;
                }
            }
        }

        /* Run through each of the other processes */
        for(r = 1; r <= p-1; r++) {
            
            /* Calculate L and H for r */
            L = sqrtN + r*S + 1;
            H = L+S-1;
            if(r == p-1) {
                H += R;
            }
            
            /* Receive list2 from the process */
            MPI_Recv(list2, H-L+1, MPI_UNSIGNED_LONG, r, 0, MPI_COMM_WORLD,
                    MPI_STATUS_IGNORE);

            /* Run through the list2 that was just received */
            for(c = L; c <= H; c++) {

                /* If the number is unmarked */
                if(list2[c-L] == 0) {

                    /* The number is prime, print it */
                    // printf("%d ", c);
                    // cout << c << endl;
                    textFile << c << endl;
                    binFile.write((char*)&c, sizeof(c));
                    printCount ++;
                    if(printCount == 1000)
                    {
                        // markerFile.write((char*)&printCount, sizeof(c));
                        // cout << c << endl;
                        markerFile.write((char*)&c, sizeof(c));
                        printCount = 0;
                    }
                }
            }
        }
        // printf("\n");
        // cout << endl;

        /* If the process is not Rank 0 */
    } 
    else {

        /* Send list2 to Rank 0 */
        MPI_Send(list2, H-L+1, MPI_UNSIGNED_LONG, 0, 0, MPI_COMM_WORLD);
    }

    /* Deallocate memory for list */
    binFile.close();
    textFile.close();
    markerFile.close();

    free(list2);
    free(list1);

    /* Finalize the MPI environment */
    MPI_Finalize();

    return 0;
}
