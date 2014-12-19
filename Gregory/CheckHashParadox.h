#include <time.h>
#include <string>

#include<iostream>
#include <cstdlib>
#include <stdio.h>
#include <ctime>
#include <vector>
#include <sstream>
using namespace std;



class CheckHashParadox {
    private:
        unsigned int numIterations;
public:
    vector<string> const &getAlphabet() const {
        return alphabet;
    }

private:
    vector<string> alphabet;
       // static const char *ar[] = {"а", "б", "в", "г", "д", "е", "ё", "ж", "з", "и", "й", "к", "л", "м", "н", "о", "п", "р", "с",
            //"т", "у", "ф", "х", "ц", "ч", "ш", "щ", "ъ", "ы", "ь", "э", "ю", "я"};
    public:

		~CheckHashParadox(){
			//alphabet.~vector();
		}

        static unsigned int HashFAQ6(const char * str)
        {
			unsigned int hash = 2139062143;

			for (; *str; str++)
				hash = 42 * hash + *str;

			return hash;

            /*unsigned int hash = 0;

            for (; *str; str++)
            {
                hash += (unsigned char)(*str);
                hash += (hash << 10);
                hash ^= (hash >> 6);
            }
            hash += (hash << 3);
            hash ^= (hash >> 11);
            hash += (hash << 15);

            return hash;*/
        }

        CheckHashParadox(unsigned int numIt) {

            for(int i=65; i<=90; ++i)
            {	
				char temp = (char)i;
				string forVec(1, temp);
                alphabet.push_back(forVec); // (char) приводит код к символу
				//cout << alphabet[i - 65];
            }

            if (numIt > 0) {
                numIterations = numIt;
            }
            else numIt = 1e5;
            srand(time(0));
        }

        string GenerateString(){
            int size = RandNum(1, 5);
			string subRandString = "";
            stringstream ss;
            for(int i = 0; i < size; ++i){
				int randomNumber = RandNum(0, 25);
                ss<<rand();
                subRandString = subRandString + alphabet[randomNumber] + ss.str();//  std::to_string(rand());
				//cout <<endl<< subRandString << endl;
            }

			//cout << "String = "<<subRandString << endl;
			return subRandString;
        }

        void Check(){

            vector<string> myStrings;

            vector<unsigned int> hashes;

            for(int i = 0; i < numIterations; ++i ){

                string strCurrent = GenerateString();

				myStrings.push_back(strCurrent); // adding string
                const char *cstrCurrent = strCurrent.c_str();
				
                unsigned int hashNumCurrent = HashFAQ6(cstrCurrent);

				//cout << "curr = "<<strCurrent<<"   " << hashNumCurrent << endl;
				//cout << "prev = " << strPrevious << "  " << hashNumPrevious << endl;

                hashes.push_back(hashNumCurrent);// adding number
				
				//delete[] cstrCurrent;
				//cout << "iter = " << i << endl;

            }

            OutFindIndex(hashes, myStrings);

			
        }

        unsigned int RandNum(int min, int max){

            return rand() % ((max) - (min) + 1) + (min);

        }

        void OutFindIndex(vector<unsigned int> hashes, vector<string> myStrings){

           // unsigned int *p = new unsigned int[2];
            bool isBreak = false;
            for(int i = 0; i < numIterations - 1; ++i){
                for(int j = i+1; j < numIterations; ++j){
                    if (hashes[i] == hashes[j] && myStrings[i]!=myStrings[j]){
                        cout << "curr = "<<myStrings[i]<<"   " << hashes[i] << endl;
                        cout << "prev = " << myStrings[j] << "  " << hashes[j] << endl;
                        isBreak = true;
                        break;

                    }

                }
                if (isBreak) break;
            }


         }
};