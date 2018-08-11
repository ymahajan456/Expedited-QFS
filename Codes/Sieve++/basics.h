#ifndef _BASICS_H_
#define _BASICS_H_

#include "stdafx.h"

// modular exponentiation function
template <typename T>
T modPower(T x, T y, T p);
// get size of file in bytes
std::ifstream::pos_type filesize(const char* fileName);

#endif
