#include "quadResidue.h"
#include "uint192_t.h"
#include "stdafx.h"
#include "basics.h"

/*
Given positive
odd integer m, and integer a, this algorithm returns the Jacobi symbol (a/m) , 
which for m an odd prime is also the Legendre symbol.

Algorithm 2.3.5: Prime Numbers, A Computational Perspective, Richard Crandall
*/
template <typename T>
int LegJacSymbol(T A, uinthp_t m)
{
    int t = 1;
    int invT = 0;
    int tmp = 0;
    uinthp_t a = A % m;
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

template int LegJacSymbol<uinthhp_t>(uinthhp_t A, uinthp_t m);
template int LegJacSymbol<uinthp_t>(uinthp_t A, uinthp_t m);

int getLJPrimes(uinthp_t* primes, uinthp_t* ljPrimes, uinthhp_t N, int numPrimes)
{
    int i = 0, ljCount = 0, j=0, ljSymbol;
    // find symbols
    for(i = 0; i< numPrimes; i++)
    {
        ljSymbol = LegJacSymbol(N, primes[i]);
        if(ljSymbol == 1)
        {
            ljPrimes[ljCount] = primes[i];
            ljCount ++;
        }
    }
    return ljCount;
}

/*
Given an odd prime p and an integer a with legendre symbol (a/p) = 1, this 
algorithm returns a solution x to equation x^2 ≡ a (mod p).

Algorithm 2.3.8: Prime Numbers, A Computational Perspective, Richard Crandall
*/
void getQuadResidues(uinthp_t* ljPrimes, const int ljCount, \
                     uinthp_t* quadResidues, const uinthhp_t a_hhp)
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
                quadResidues[i] = modPower(a_hhp, (p+1)/4, p);
                // cout << quadResidues[i] << ' ' << a << ' ' << p <<endl;
                break;
            case 5:
                aModP = (uint192_t)a_hhp % p;
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
                A = modPower(a_hhp, t, p);
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
                tmp = modPower(a_hhp, (t+1)/2, p);
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

uinthp_t estimateB(uinthhp_t N)
{
    double nDouble, B;
    nDouble = (double)N;
    // cout << "nDouble " << nDouble << endl;
    B = exp(0.5 * sqrt(log(nDouble) * log(log(nDouble))));
    return (uinthp_t)B + B_SLACK;
}

int loadPrimes(const char* primesFileName, uinthp_t* primes, uinthp_t B)
{
    if (B > MAX_PRIME)
    {
        cout << "B is larger than maximum known prime, B: " << B << endl;
        exit(0);
    }
    // cout << "I was here" << endl;
    uinthp_t data;
    ifstream inFile;
    inFile.open(primesFileName, ios::binary);
    int count = 0;
    // read primes
    while(inFile.read((char*)&data, sizeof(data)))
    {
        // cout << data << endl;
        if(data == 2) continue;     // can't find quadratic residue of 2, so ignore
        if(data > B)
            break;
        else
        {
            primes[count] = data;
            count ++;
            if (count > PRIME_COUNT)
            {
                cout << "Insufficient array size" << endl;
                exit(0);
            }
        }
    }
    inFile.close();
    return count;
}



// baseN = "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010011001001010001010100101100000000001111011100001111011001110001101111010111"