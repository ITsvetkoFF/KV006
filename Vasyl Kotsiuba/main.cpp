#include <iostream>
#include <stdio.h>      /* printf, scanf, puts, NULL */
#include <stdlib.h>     /* srand, rand */


using namespace std;
unsigned int HashH37(const char * str);
unsigned int HashTable(string word);
unsigned int JSHash(const std::string& str);
unsigned int hash32(char *str);

int main() {

    string inputString = "";
    int n = 10;
    int hashArray[n];
    string stringArray[n];

    for (int j = 0; j < n; j++) {
        inputString = "";
        for (int i = 0; i < 7; i++) {
            if (i % 2 == 0) {
                char g = 'A' + rand() % 26;
                inputString += g;
            } else {
                char g = 'a' + rand() % 26;
                inputString += g;
            }
        }
        stringArray[j] = inputString;
        hashArray[j] = HashTable(inputString);
        //int hash = HashTable(inputString);
        int hash = hash32(&inputString[0]);
        cout << hash << endl;

        for (int k = 0; k <+ j; k++ ){
            if (hash == hashArray[k]){
                //cout << "YES" << endl;
                cout << "------------------------------------------------" << endl;
                cout << "Number " << j << " String (" << inputString << ")" << " hash (" << hash <<")" << endl;
                cout << "                     IS EQUAL TO                     " << endl;
                cout << "Number " << k << " String (" << stringArray[k] << ")" << " hash (" << hashArray[k] <<")" << endl;
            }
        }

    }

//    for (int i = 0; i < n; i++) {
//        cout <<  hashArray[i] << endl;
//    }



    //cout << HashH37("Hello, World!") << endl;

    //cout << inputString << endl;

    return 0;
}

unsigned int HashH37(const char * str)
{

    unsigned int hash = 2139062143156987;

    for(; *str; str++)
        hash = 142 * hash + *str;

    return hash;

}

unsigned int HashTable(string word)
{
    unsigned int seed = 131;
    unsigned long hash = 0;
    for(int i = 0; i < word.length(); i++)
    {
        hash = (hash * seed) + word[i];
    }
    return abs(hash);
}

unsigned int JSHash(const std::string& str)
{
    unsigned int hash = 1315423911;

    for(std::size_t i = 0; i < str.length(); i++)
    {
        hash ^= ((hash << 5) + str[i] + (hash >> 2));
    }

    return (hash & 0x7FFFFFFF);
}

unsigned int hash32(char *str)
{
    unsigned int h;
    unsigned char *p;

    h = 0;
    for (p = (unsigned char*)str; *p != '\0'; p++)
        h = 31 * h + *p;
    return h; // or, h % ARRAY_SIZE;
}