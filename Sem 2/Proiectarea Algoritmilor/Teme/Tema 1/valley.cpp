#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm>

using namespace std;

int main() {
	ifstream f("valley.in");
	ofstream o("valley.out");

	int i, j, n, min_pos;

	// citirea numarului de elemente;
	f >> n;

	vector<int> valee(n, 0);

	// citirea elementelor din input;
	for(i = 0; i < n; i++) {
		f >> valee[i];
	}

	// gasirea indexului elementului cu cea mai mica valoare;
	min_pos = min_element(valee.begin() + 1, valee.end() - 1) - valee.begin();

	i = 1;
	j = n - 2;
	long long hours = 0;

	while(i <= min_pos || j >= min_pos) {
		// pentru partea stanga daca valea precedenta e < decat valea actuala
		// atunci se ia din valea actuala suficient cat sa fie la egal cu valea
		// precedenta si se actualizeaza numarul de ore;
		if(valee[i - 1] < valee[i] && i <= min_pos) {
			hours += (valee[i] - valee[i - 1]);
			valee[i] = valee[i - 1];
		}

		// pentru partea dreapta daca valea actuala e > decat urmatoarea vale atunci
		// se mai ia din valea actuala pana ajunge la nivel cu urmatoarea si se
		// actualizeaza numarul de ore lucrate;
		if(valee[j] > valee[j + 1] && j >= min_pos) {
			hours += (valee[j] - valee[j + 1]);
			valee[j] = valee[j + 1];
		}

		i++;				// se pregateste pentru
		j--; 				// urmatoarea iteratie;
	}

	o << hours;				// Se scrie numarul minim de ore in output;
	o.close();
	return 0;
}
