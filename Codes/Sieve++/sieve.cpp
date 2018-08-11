// Author : OV Shashank (Sieve) & Yogesh Mahajan (Legendre Symbol)
// Roll No: 14D070021 & 14D070022
// Optimized B-Smooth Number Sieve
// Reference: Prime Numbers: A Computational Perspective 

#include "stdafx.h"
#include "basics.h"
#include <math.h>
#include <fstream>
//#include "quadResidue.cpp"

#define PRIME_COUNT 1000
#define TEST_COUNT  100000000

uinthp_t B, N, MAX_NUM, sqrtn;
uinthp_t p[PRIME_COUNT], a[PRIME_COUNT], num[TEST_COUNT];
int finalMatrix[PRIME_COUNT][PRIME_COUNT] = {0};
uinthp_t finalNums[PRIME_COUNT];
bool is_smooth[TEST_COUNT];
int numPrimes;
uintllp_t logp[PRIME_COUNT]; 

/*
 * Optimized calculation of logarithm
 * to the base 2 rounded down to an 
 * integer
 */
uintllp_t log2_floor(uinthp_t num){
    uintllp_t to_return = 0;
    while(num >> 1 > 0) {
        ++to_return;
        num = num >> 1;
    }
    return to_return;        
}

void generate_log2(){
    for(int i = 0; i < numPrimes; i++)
        logp[i] = log2_floor(p[i]);
}

/* sieve_smooth()
 * Applied a thresholding to detect smooth numbers
 * based on the approximate logarithm.
 * This method is significantly error-prone for small
 * numbers hence a large margin is required
 */
void sieve_smooth(){
    ofstream test("test.csv");
    for(uinthp_t i = 0; i < TEST_COUNT; i++){ 
        if (log2(i*i + 2*i*sqrtn + (sqrtn*sqrtn - N)) > 60)
        cout << (unsigned) log2(i*i + 2*i*sqrtn + (sqrtn*sqrtn - N)) << "," << num[i] << endl;       
        if(log2(i*i + 2*i*sqrtn + (sqrtn*sqrtn - N)) <= num[i] + 60)
            is_smooth[i] = true;
        else
            is_smooth[i] = false;
    }
}

/* Supplementary Function smooth()
 * Generates the matrix form based on the 
 * exponents of prime numbers in the chosen
 * numbers (Hard Prime Factorization
 * is performed here to be sure of B-Smoothness)
 */
void smooth(){
    int k = 0;
    for(int i = 1; i < TEST_COUNT; i++){
        //is_smooth[i] = false;
        if(is_smooth[i]) {
            uinthp_t x = i*i + 2*i*sqrtn + (sqrtn*sqrtn - N), prime = p[0];
            finalNums[k] = x;
            int j = 0; 
            while(prime <= B){
                if(x % prime == 0) {
                    x = x/prime;
                    finalMatrix[k][j] += 1;//finalMatrix[k][j];
                    continue;
                }
                prime = p[++j];
            }
            is_smooth[i] = true;
            k++;
            if (x == 1)
                cout << finalNums[k - 1] << " " << k << endl;
            else if(x != 1) {
                is_smooth[i] = false;
                k--;
                for(int i = 0; i < numPrimes; i++){
                    finalMatrix[k][i] = 0;
                }
            }
        }
    }
}
  
/* Main Function: sieve()
 * Performs the complete sieving action using 
 * approximate logarithms based on the prime numbers
 * and their quadratic residue provided artificially 
 */
void sieve(){
    for(int i = 0; i < numPrimes; i++) {
        uintstd_t prime = p[i];
        //for(int power = 1; prime < MAX_NUM; power++){
            uinthp_t x1 = a[i] + p[i]*((sqrtn - a[i])/p[i] + 1);
            uinthp_t x2 = -a[i] + p[i]*((sqrtn + a[i])/p[i] + 1);
            while(x1 < MAX_NUM){
                num[x1 - sqrtn] += logp[i];
                x1 += prime;
            }
            while(x2 < MAX_NUM){
                num[x2 - sqrtn] += logp[i];
                x2 += prime;
            }
        //    prime = prime * prime;
        //}
        //cout << p[i] << endl;
    }
    sieve_smooth();
    smooth();
    int j = 0;
    for(int i = 0; i < TEST_COUNT; i++)
        if(is_smooth[i])
            cout << j++ << " " << i+sqrtn << "\t\t" << is_smooth[i] << endl;
    
    ofstream ofile("matrix.csv");
    for(int k = 0; k < j; k++) {
        //cout << finalNums[k] << " ";
        for(int i = 0; i < numPrimes - 1; i++)
            ofile << finalMatrix[k][i]%2 << ",";
        ofile << finalMatrix[k][numPrimes - 1]%2 << endl;
    }
}

/*
Given positive
odd integer m, and integer a, this algorithm returns the Jacobi symbol (a/m) , 
which for m an odd prime is also the Legendre symbol.

Algorithm 2.3.5: Prime Numbers, A Computational Perspective, Richard Crandall
*/
int LegJacSymbol(uinthp_t a, uinthp_t m)
{
    int t = 1;
    int invT = 0;
    int tmp = 0;
    a = a % m;
    while(a != 0)
    {
        tmp = m % 8;
        invT = (tmp == 5) || (tmp == 3) ? 1 : 0;
        while(!(a%2))
        {
            a = a/2;
            t = (invT == 1) ? -t : t;
        }
        tmp = a;
        a = m;
        m = tmp;
        t = (a%4 ==3) && (m%4 == 3) ? -t : t;
        a = a%m;
    }
    return (m == 1) ? t : 0;
}
/*
Number of primes is 655 for N = 2**64-1 => The array wont be too large.
*/
int getLJPrimes(const char* primeFileName, uinthp_t* ljPrimes, uinthp_t n)
{
    // get number of primes in binary file
    int numPrimes = filesize(primeFileName)/sizeof(uinthp_t);
    // arrays for storing primes nad symbols
    uinthp_t primes[1000];
    
    int ljSymbols[1000];
    numPrimes --;
    // few variables
    int i = 0, ljCount = 0, j=0;
    uinthp_t data;
    ifstream inFile;
    inFile.open(primeFileName, ios::binary);
    // read primes
    while(inFile.read((char*)&data, sizeof(data)))
    {
        if(data == 2) continue;     // can't find quadratic residue of 2, so ignore
        primes[i] = data;
        i++;
    }
    inFile.close();
    // find symbols
    for(i = 0; i< numPrimes; i++)
    {
        ljSymbols[i] = LegJacSymbol(n, primes[i]);
        if(ljSymbols[i] == 1)
            ljCount ++;
    }
    for(i = 0; i < numPrimes; i++)
    {
        if(ljSymbols[i] == 1)
        {
            ljPrimes[j] = primes[i];
            j++;
        }
    }
    return ljCount;
}

/*
Given an odd prime p and an integer a with ap = 1, this algorithm returns a 
solution x to x 2 ≡ a (mod p).

Algorithm 2.3.8: Prime Numbers, A Computational Perspective, Richard Crandall
*/
void getQuadResidues(uinthp_t* ljPrimes, const int ljCount, uinthp_t *quadResidues \
                    , const uinthp_t a)
{
    uinthp_t pMod8,p, aModP, x, tmp, d = 0, s,t, D, m, A;
    int found = 0, j, i;
    for(i = 0; i < ljCount; i++)
    {
        p = ljPrimes[i];
        pMod8 = p % 8;
        switch(pMod8)
        {
            // for pMod8 == {3,7}
            case 3:
            case 7:
                quadResidues[i] = modPower(a, (p+1)/4, p);
                // cout << quadResidues[i] << ' ' << a << ' ' << p <<endl;
                break;
            case 5:
                aModP = a % p;
                x = modPower(aModP, (p+3)/8, p);
                tmp = (x*x) % p;
                if(tmp != aModP)
                    x = (x * modPower((uinthp_t)2, (p-1)/4, p)) % p;
                quadResidues[i] = x;
                // cout << quadResidues[i] << ' ' << a << ' ' << p <<endl;
                break;
            case 1:
                // search for d from 2
                d = 0;
                for(tmp = 2; tmp < p; tmp++)
                {
                    if(LegJacSymbol(tmp, p) == -1)
                    {
                        d = tmp;
                        break;
                    }
                }
                if(d == 0)
                {
                    cout << "can't find d for p = " << p << endl;
                    exit(0);
                }
                // cout << d << ' ';
                // represent p-1 as 2^s * t
                t = p-1;
                s = 0;
                while((t % 2) == 0)
                {
                    t = t/2;
                    s++;
                }
                // cout << t << ' ' << s << " ";
                A = modPower(a, t, p);
                D = modPower(d, t, p);
                m = 0;
                for(tmp = 0; tmp < s; tmp ++)
                {
                    d = modPower(D, m, p);   // D^m
                    d = (A * d) % p;         // AD^m
                    x = pow(2, s-1-tmp);       // exponent
                    if(modPower(d,x,p) == (p-1))
                        m += pow((uinthp_t)2,tmp);
                }
                tmp = modPower(a, (t+1)/2, p);
                x = modPower(D, m/2, p);
                quadResidues[i] = (x * tmp) % p;
                // cout << quadResidues[i] << ' ' << a << ' ' << p <<endl;
                break;
            default:
                cout << "p mod 8 must be in {1,3,5,7}" << endl \
                << "Prime number is " << p << endl;
                exit(0);
        }
    }
}

int main(){
/*    ofstream ofile("log2.csv");
    for(unsigned long i = 1; i <= 65535; i++)
        ofile << i << "," << unsigned(log2_floor(i)) << endl;
*/
    N = 43142746595714191;
    sqrtn = sqrt(N);
    MAX_NUM = sqrtn + TEST_COUNT;
    B = exp(1.0/2.0*sqrt(log(N)*log(log(N)))) + 800;

    numPrimes = getLJPrimes("primesBin.yo", p, N);
    for(int i = 0; i < numPrimes; i++){
        if(p[i] > B){
            numPrimes = i;
            break;
        }
    }
    cout << B << " " << numPrimes << " " << sqrtn << endl;

    getQuadResidues(p, numPrimes, a, N);
    for(int i = numPrimes - 1; i >= 0; i--)
        p[i] = p[i-1];
    p[0] = 2;
    for(int i = numPrimes - 1; i >= 0; i--)
        a[i] = a[i-1];
    a[0] = 1;
    
    generate_log2();
    //cerr << "Done\n";
    sieve();
}