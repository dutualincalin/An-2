#include <iostream>
#include <fstream>

using namespace std;

int main(){
	ifstream f("Euro.in");
	int i, sum, max_pow, base;

	f >> sum >> max_pow >> base;
	f.close();

	int max = 1;
	int nr = 0;

	for(i = 0; i < max_pow; i++){
		if(max * base > sum){
			break;
		}

		max *= base;
	}

	while(sum > 0){
		nr += sum / max;
		sum = sum % max;
		max /= base;
	}

	cout << "Numarul minim de bancnote = " << nr << endl;
}