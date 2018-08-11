#include "basics.h"
/* 
Iterative Function to calculate (x^y)%p in O(log y) 
The function is defined on integer and derived data types
*/

template <typename T>
T modPower(T x, T y, T p)
{
    T res = 1;
    x = x % p;
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
// instantiate template for compiler
template uinthp_t modPower<uinthp_t>(uinthp_t, uinthp_t, uinthp_t);
