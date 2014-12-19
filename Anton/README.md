
First Home Work

Birthday problem
```ruby
int main() {
    sayHello();
  
    int count = 15000;
    
    vector<string> stringArray;
    vector<string> hashArray;
    char alphabet[] = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'g', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 'u', 'v', 'w',
                        'x', 'y', 'z'};
    int hashcount = 0;
    srand(time(0));
    for (int i = 0; i < count; i++) {
        string s = "";
        for (int j = 0; j < 10; j++) {
            int randNum = rand() % (25) + 1;
            s += alphabet[randNum];
        }
        stringArray.push_back(s);
        string myhash = md5(s);
        char buffer[20];
        myhash.copy(buffer, 4, 0);
        myhash = buffer;
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
```
