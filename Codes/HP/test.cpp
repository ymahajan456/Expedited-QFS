// #include "basics.h"
#include "stdafx.h"
#include "uint192_t.h"

int main()
{
    string nBase = "000000000000000000000000000000000000000000000000000000000000001010110001000101000011001100100110000000101011101100101101001111110100011010001101111001100000000110000011011110101000110101010111";
    uint192_t n(nBase);
    n.print();
    // uint192_t b, d;
    // b = n;
    // uint64_t nMax = std::numeric_limits<uint64_t>::max();
    // // n.print();
    // // b.print();
    // // d = n+ nMax;
    // // d.print();

    // // cout << (b == n) << endl;
    // // b = uint192_t(0,0,12);
    // // cout << (b == (int)12) << endl;

    // uint64_t t;
    // t = n%78;

    // cout << t << endl;

    

}
