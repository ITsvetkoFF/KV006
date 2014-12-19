#include <iostream>
#include <cstdlib>
#include <map>
#include <ctime>
#include "foo.h"

using namespace std;

int main()
{

    srand(time(NULL));

    map <int, string> logins;

    string login;
    int hash;

    int count = 0;

    while(true)
    {
        login = randomStrGen(32);
        hash = genHash(login.c_str());

        if(logins.count(hash) == 0) {
            logins[genHash(login.c_str())] = login;
            count++;
        }
        else {
            cout << "Hooray! We've got a match!" << endl;
            cout << "Login: " << logins[hash] << " and login: " << login << " have same hashes: " << hash << endl;
            cout << "We've generated " << count << " logins." << endl;
            break;
        }
    }

    cout << "\nTest: " << genHash("ZVNCFlxSIHccGO0v2acKIOrU7LVVvTpd") << " & " << genHash("D7T4FjTvjJNddJNmMsxdur2bc7lOg8gb") << endl;

    return 0;
}