#include "uint192_t.h"
#include "stdafx.h"
#include "basics.h"

uint64_t nMax = std::numeric_limits<uint64_t>::max();

// construtors

uint192_t::uint192_t()
{
    VAL[0] = 0;
    VAL[1] = 0;
    VAL[2] = 0;
}

uint192_t::uint192_t(const uint64_t upper, const uint64_t middle, const uint64_t lower)
{
    VAL[0] = upper;
    VAL[1] = middle;
    VAL[2] = lower;
}

uint192_t::uint192_t(const string n)
{
    VAL[0] = 0;
    VAL[1] = 0;
    VAL[2] = 0;
    int currPoint = 0;
    if(n.length() != 192)
    {
        cout << "Binary string must have 192 bits" << endl;
        exit(0);
    }
    for(int i = 0; i<3; i++)
    {
        string tmp = n.substr(64*i,64);
        // char* subStr = &tmp[0];
        // // strncpy(subStr, tmp.c_str(), 64);
        // VAL[i] =  strtoll(subStr,NULL,2);
        // // cout << tmp << " " << VAL[i] << endl;
        
        VAL[i] = fromBinStr(tmp);
    }
}

// typecast

uint192_t::operator uint64_t() const {return VAL[2];}
uint192_t::operator int() const {return (int)VAL[2];}

uint192_t::operator double() const
{
    return ((double)VAL[0]*pow((double)2, 128) + (double)VAL[1]*pow((double)2, 64) + (double)VAL[2]);
}

// arithemtic operators

// addition
template <typename T>
uint192_t uint192_t::operator+(const T rhs)
{
    uint64_t lower, middle, upper;
    lower = VAL[2] + rhs;
    middle = VAL[1] + (lower < VAL[2]);
    upper = VAL[0] + (middle < VAL[1]);
    return uint192_t(upper, middle, lower);
}


uint192_t & uint192_t:: operator=(const uint192_t & rhs)
{
    VAL[0] = rhs.VAL[0];
    VAL[1] = rhs.VAL[1];
    VAL[2] = rhs.VAL[2];
    return *this;
}

template <typename T>
uint192_t & uint192_t:: operator=(const T rhs)
{
    VAL[0] = 0;
    VAL[1] = 0;
    VAL[2] = (uint64_t)rhs;
    return *this;
}


bool uint192_t::operator==(const uint192_t & rhs)
{
    return (VAL[0] == rhs.VAL[0]) & (VAL[2] == rhs.VAL[2]) & (VAL[1] == rhs.VAL[1]) ;
}

template <typename T>
bool uint192_t::operator==(const T rhs)
{
    return (VAL[0] == 0) & (VAL[1] == 0) & (VAL[2] == (uint64_t)rhs);
}

void uint192_t::print()
{
    cout << VAL[0] << " *2**128 + " << VAL[1] << " *2**64 + "  << VAL[2] << endl;
}

template <typename T>
T uint192_t::operator%(const T rhs)
{
    T res;
    res = ((VAL[0] % rhs) * modPower((uint64_t)2, (uint64_t)128, (uint64_t)rhs)) % rhs;
    res = (((VAL[1] % rhs) * modPower((uint64_t)2, (uint64_t)64, (uint64_t)rhs)) % rhs + res) % rhs;
    res = (VAL[2] % rhs + res) % rhs;
    return res;

}

template uint192_t & uint192_t::operator=<int>(const int rhs);
template uint192_t & uint192_t::operator=<uint64_t>(const uint64_t rhs);

template uint192_t uint192_t::operator+<int>(const int rhs);
template uint192_t uint192_t::operator+<uint64_t>(const uint64_t rhs);

template bool uint192_t::operator==<int>(const int rhs);
template bool uint192_t::operator==<uint64_t>(const uint64_t rhs);

template int uint192_t::operator%<int>(const int rhs);
template uint64_t uint192_t::operator%<uint64_t>(const uint64_t rhs);
