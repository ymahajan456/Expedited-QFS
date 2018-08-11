#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <vector>
#include <fstream>
#include <sys/types.h>
#include <sys/wait.h>
#include <signal.h>
#include <math.h>
#include <unistd.h>
#include <pthread.h>
#include <cstdio>
#include "stdafx.h"
using namespace std;

int main()
{
    ifstream inFile;
    inFile.open("markers.yo", ios::binary);

    uinthp_t data;

    while(inFile.read((char*)&data, sizeof(data)))
    {
        cout << data << endl;
    }
    
    inFile.close();
}