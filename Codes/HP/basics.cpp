#include "basics.h"
/* 
Iterative Function to calculate (x^y)%p in O(log y) 
The function is defined on integer and derived data types
*/

template <typename T, typename U>
T modPower(U x_hhp, T y, T p)
{
    T x;
    T res = 1;
    x = x_hhp % p;
    while (y > 0)
    {
        // If y is odd, muluinthp_tiply x wiuinthp_th resuluinthp_t
        if (y & 1)
            res = (res*x) % p;
        // y is even
        y = y>>1; // y = y/2
        x = (x*x) % p;  
    }
    return res;
}

/*
Returns the size of file in bytes
*/
std::ifstream::pos_type filesize(const char* fileName)
{
    std::ifstream in(fileName, std::ifstream::ate | std::ifstream::binary);
    return in.tellg(); 
}

uint64_t fromBinStr(string binStr)
{
    // cout << binStr << endl;
    uint64_t val = 0;
    uint64_t addVal = 1;
    for(int i= 0; i< 64; i++)
    {
        // cout << pow((uint64_t)2, (uint64_t)i) << ' ';
        // cout << i << ' ' << addVal << endl;
        val += (binStr[63-i] == '1') ? addVal : 0;
        addVal = addVal * 2;
    }
    return val;
}



// instantiate template for compiler
template uinthp_t modPower<uinthp_t, uinthp_t>(uinthp_t, uinthp_t, uinthp_t);
template uinthp_t modPower<uinthp_t, uinthhp_t>(uinthhp_t, uinthp_t, uinthp_t);
