#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm>

using namespace std;

typedef struct {
	long long productie;			// structura pentru un calculator;
	long long costuri;
} calculator;

// functia de comparare folosita la functia sort;
bool compare(calculator c1, calculator c2) {
	return c1.productie < c2.productie;
}

int main() {
	ifstream f("crypto.in");
	ofstream o("crypto.out");

	long long i, j, n, bani, sum = 0, prod;

	f >> n;								// citirea numarului de calculatoare
	f >> bani;							// si a sumei de bani disponibila;

	// declararea vectorului de calculatoare;
	vector<calculator> calculatoare(n);

	// Citirea datelor calculatoarelor;
	for(i = 0; i < n; i++) {
		f >> calculatoare[i].productie >> calculatoare[i].costuri;
	}

	f.close();

	// Sortarea vectorului de calculatoare
	sort(calculatoare.begin(), calculatoare.end(), compare);

	for(i = 0; i < n - 1; i++) {
		// se retine suma costurilor pentru
		// calculatorul actual si cele precedente;
		sum += calculatoare[i].costuri;

		// In cazul diferentelor de performanta se retine productia
		// calculatorului actual si se verifica daca exista bani pentru
		// imbunatatirile de performanta ale calculatoarelor precedente;
		if(calculatoare[i].productie < calculatoare[i + 1].productie) {
			prod = calculatoare[i].productie;

			// Cazul in care nu exista bani - Se returneaza productia
			// maxima posibila care se poate incadra in suma de bani;
			if(bani < sum * (calculatoare[i + 1].productie - prod)) {
				o << prod + bani/sum;
				o.close();
				return 0;
			} else {
				bani -= sum * (calculatoare[i + 1].productie - calculatoare[i].productie);
				// altfel se elimina din suma de bani costul pentru imbunatatiri;
			}
		}
	}

	// Se imbunatatesc calculatoarele pana cand
	// nu se mai poate si se returneaza nivelul
	// maxim posibil de productivitate;
	sum += calculatoare[n - 1].costuri;
	prod = calculatoare[n - 1].productie;
	o << prod + bani/sum;
	o.close();
	return 0;
}
