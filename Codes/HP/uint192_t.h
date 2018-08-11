#ifndef _UINT192_T_H_
#define _UINT192_T_H_

#include "stdafx.h"

class uint192_t{
    private:
        uint64_t VAL[3];
        // VAL[0] is MSN, little endian

    public:
        // constructors

        // assign zeroes
        uint192_t();
        // from binary string
        uint192_t(const string n);
        // from 3 nibbles of types uint64_t
        uint192_t(const uint64_t upper, const uint64_t middle, const uint64_t lower);
        
        // typecast
        operator uint64_t() const;
        operator int() const;
        operator double() const;

        // arithmetic operators
        // addition
        template <typename T>
        uint192_t operator+(const T rhs);
        // modulo
        // uint192_t operator%(const uint192_t & rhs);
        template <typename T>
        T operator%(const T rhs);
        
        // equality
        uint192_t & operator=(const uint192_t & rhs);
        template <typename T>
        uint192_t & operator=(const T rhs);
        // comparator
        bool operator==(const uint192_t & rhp);
        template <typename T>
        bool operator==(const T rhp);
        // divide
        // uint192_t operator/(const int rhs);
        // uint192_t operator/(const uint64_t & rhs);
        // uint192_t operator/(const uint192_t & rhs);

        // special functions
        // int modPow2(const uint192_t & HP, int pow);
        void print();
};

#define uinthhp_t uint192_t

#endif