#ifndef _BASICS_H_
#define _BASICS_H_

#include "stdafx.h"
#include "uint192_t.h"

#define B_SLACK 800
#define PRIME_COUNT 7000
#define MAX_PRIME 499979


// printing macros
#define PRINT_PRIMES
#define PRINT_STEP 100


// modular exponentiation function
template <typename T, typename U>
T modPower(U x_hhp, T y, T p);
// get size of file in bytes
std::ifstream::pos_type filesize(const char* fileName);

uint64_t fromBinStr(string data);

#endif
