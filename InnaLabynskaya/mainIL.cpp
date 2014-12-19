#include <iostream>
#include <string>
#include <sstream>
#include <stdlib.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdlib.h>
#include <ctime>
#include <map>

using namespace std;

typedef unsigned _int64 HashType;

HashType HashH37(const char * str);

static const char alphanum[] =
"0123456789"
"!@#$%^&*"
"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
"abcdefghijklmnopqrstuvwxyz";

int stringLength = sizeof(alphanum) - 1;

char genRandom()
{

    return alphanum[rand() % stringLength];
}

int main(int argc, char* argv[])
{
	int size = 10000000;
	//bool flag = false;
	srand(time(0));
	map<HashType, string> hashes;
	for(int i = 0; i < size; i++)
	{
		string Str;
		for(unsigned int i = 0; i < 20; ++i)
		{
			Str += genRandom();
		}
		//cout << Str << endl;
		const char * c = Str.c_str();
		HashType hash = HashH37(c);

		if(hashes.find(hash)==hashes.end())
			hashes[hash] = Str;
		else
			cout<<hashes[hash]<<' '<<Str<<' '<<hash<<endl;

		//int Ar[1000];
		//for(int j = 0; j < size; j++)
		//{
		//	hashes[]=Str;
			
			//Ar[j] = HashH37(c);
			//cout<<HashH37(c)<<endl;
			/*for(int k = 0; k < size; k++)
			{
				for (int s=k+1; s<size-1; s++) 
				{
					if (Ar [j] == Ar [s]) 
					flag = true;
					 break;
				}
				
			}break;*/
			
		//}
		
		//if (flag)
  //          cout << "matches\n";
		//else   
		//	cout << "No matches\n";
	}
	return 0;
}
		/*char str[128];
		for (int i=0;i<127;i++) 
			str[i]=' '+rand()%96;
		 str[127]=0;
		cout<<str<<endl;

		char str2[128];
		for (int i=0;i<127;i++) 
			str2[i]=' '+ rand()%96;
		 str2[127]=0;
		cout<<str2<<endl;

	cout<<HashH37(str)<<endl;
	cout<<HashH37(str2)<<endl;
	if(HashH37(str) == HashH37(str2))
		cout<< "Match\n";*/
	


HashType HashH37(const char * str)
{
    HashType hash = 2139062143;

    for(; *str; str++)
        hash = 37 * hash + *str;

    return hash;

}