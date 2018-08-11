#include "quadResidue.h"
#include "stdafx.h"
#include "basics.h"

using namespace std;

int main(int argc, char **argv)
{
    uinthp_t primes[PRIME_COUNT], quadResidues[PRIME_COUNT], B;
    string nBase = "000000000000000000000000000000000000000000000000000000000000001010110001000101000011001100100110000000101011101100101101001111110100011010001101111001100000000110000011011110101000110101010111";
    uinthhp_t n(nBase);
    int numPrimes;
    int start_s=clock();
    B = estimateB(n);
    cout << "B " << B;
    numPrimes = loadPrimes("primesBin.yo", primes, B);

    cout << " numPrimes " << numPrimes << endl;
    numPrimes = getLJPrimes(primes, primes, n, numPrimes);
    getQuadResidues(primes, numPrimes, quadResidues, n);
    int stop_s=clock();
    #ifdef PRINT_PRIMES
    for(int i= 0 ; i < numPrimes; i+= PRINT_STEP)
        cout << quadResidues[i] << ' ' << primes[i] << endl;
        n.print();
    #endif
    cout << "time (ms): " << (stop_s-start_s)/double(CLOCKS_PER_SEC)*1000 << endl;
}


// n = 915942972447382947582161328343629860183
// nBase = 000000000000000000000000000000000000000000000000000000000000001010110001000101000011001100100110000000101011101100101101001111110100011010001101111001100000000110000011011110101000110101010111