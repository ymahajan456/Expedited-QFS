#include "stdafx.h"
#include "basics.h"
using namespace std;

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

/*int main(int argc, char **argv)
{
    uinthp_t primes[1000], quadResidues[1000];
    uinthp_t n = 43142746595714191;
    int numPrimes;
    int start_s=clock();
    numPrimes = getLJPrimes("primesBin.yo", primes, n);
    getQuadResidues(primes, numPrimes, quadResidues, n);
    int stop_s=clock();
    for(int i=0; i < numPrimes; i++)
        cout << quadResidues[i] << ' ' << primes[i] << ' ' << n << endl;
    cout << "time (ms): " << (stop_s-start_s)/double(CLOCKS_PER_SEC)*1000 << endl;
}*/