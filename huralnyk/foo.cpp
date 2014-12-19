#include <ctime>
#include <cstdlib>
#include <iostream>

using namespace std;

string randomStrGen(int length) {
    static string charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
    string result;
    result.resize(length);

    for (int i = 0; i < length; i++)
        result[i] = charset[rand() % charset.length()];

    return result;
}

int genHash(const char *str) {
    int h = 0;
    while (*str)
        h = h << 1 ^ *str++;
    return h;
}