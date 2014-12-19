First homework by Greg

Two hash values problem

```
#include "CheckHashParadox.h";

using namespace std;

void MakeCheck(){
    CheckHashParadox hashCheck(1e5);
    hashCheck.Check();
    hashCheck.~CheckHashParadox();
}

int main() {
   // hello_world();

    MakeCheck();
    system("pause");
	
    return 0;
}
```
