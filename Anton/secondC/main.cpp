#include <iostream>
#include <vector>
#include <string>
#include "Hello.h"
#include "MD5.h"

using namespace std;

int main() {
    sayHello();
    //cout << "Hash of hello: " << MD5("Hello") << endl;
    int count = 15000;
    //string* stringArray = new string[count];
    vector<string> stringArray;
    vector<string> hashArray;
    char alphabet[] = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'g', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 'u', 'v', 'w',
                        'x', 'y', 'z'};
    int hashcount = 0;
    srand(time(0));
    for (int i = 0; i < count; i++) {
        // stringArray[i] = new string("A");
        string s = "";
        for (int j = 0; j < 10; j++) {
            int randNum = rand() % (25) + 1;
            s += alphabet[randNum];
        }
        stringArray.push_back(s);
        //MD5 obj =
        //cout << md5(s) << endl;
        string myhash = md5(s);

        //cout << sizeof(myhash) << endl;
        char buffer[20];
        myhash.copy(buffer, 4, 0);
        myhash = buffer;
      //  cout << myhash << endl;
        for (int x = 0; x < hashArray.size(); x++) {

            if (hashArray[x].compare(myhash) == 0) {
                cout << hashArray[x] << endl << myhash << endl;
                cout << stringArray[x] << endl << s << endl;
                cout << x << " Hash count is: " << hashcount << endl;
                return 0;
            }
        }
        hashcount++;
        hashArray.push_back(myhash);

    }
    cout << "end" << endl;
    return 0;
}