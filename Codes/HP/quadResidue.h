#ifndef _QUAD_RESIDUE_H_
#define _QUAD_RESIDUE_H_

#include "stdafx.h"
#include "basics.h"

template <typename T>
int LegJacSymbol(T A, uinthp_t m);

int getLJPrimes(uinthp_t* primes, uinthp_t* ljPrimes, uinthhp_t N, int numPrimes);

void getQuadResidues(uinthp_t* ljPrimes, const int ljCount, \
                     uinthp_t* quadResidues, const uinthhp_t a_hhp);
uinthp_t estimateB(uinthhp_t N);

int loadPrimes(const char* primesFileName, uinthp_t* primes, uinthp_t B);

#endif // !_QUAD_RESIDUE_H_