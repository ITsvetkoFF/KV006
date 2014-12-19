//#include "foo.h"
//#include <iostream>
#include "CheckHashParadox.h";

using namespace std;

void MakeCheck(){
    CheckHashParadox hashCheck(1e5);
    //string tmp = hashCheck.GenerateString();

    //const char* cstCurrent = tmp.c_str();

    //cout <<"Hash = "<< hashCheck.HashFAQ6(cstCurrent) << endl;

    hashCheck.Check();
    hashCheck.~CheckHashParadox();
    // cout<<"aplphabet0 = "<< hashCheck.getAlphabet()[0];
}

int main() {
   // hello_world();

    MakeCheck();
    system("pause");
	
    return 0;
}

