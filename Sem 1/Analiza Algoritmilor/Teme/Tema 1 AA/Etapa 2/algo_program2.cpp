#include <iostream>
#include <fstream>
#include <chrono>
#include "algo.h"

using namespace std;
using namespace std::chrono;

// Sa presupunem ca acest program este folosit intr-un centru de analize cu scopul de a organiza pacientii in functie de
// prioritate (in ordine crescatoare, adica 1 este cea mai mica prioritate, iar 100 este prioritatea cea mai mare).

int main(){
	cout << "Programul 2"<< endl << endl;

	ifstream f("./in/test_analize.in");
	ofstream o("./out/test_analize.out");

	int capacitate, greutate, i = 0, nr_total, max;
	string descriere;

	f >> capacitate;
	AVLTree *AVLclient = createAVLTree();
	MaxHeap *Heapclient = makeHeap(capacitate);
	AVLNode *AVLnod;
	HeapNode Heapnod;

	f >> nr_total;

	// Cheia de la AVL reprezinta prioritatea pacientului.

	while(i < nr_total){
		f >> greutate;
		getline(f, descriere);

		AVLclient->radacina->stanga = AVLInsert(AVLclient, AVLclient->radacina->stanga, greutate, descriere);
		HeapInsert(Heapclient, HeapNewNode(greutate, descriere));

		i++;
	}

	// Functionalitatea principala a programului este sa se organizeze pacientii in functie de prioritate, de aceea ...

	cout << "1) Gasim pactientul cu cea mai mare prioritate folosind Heap si apoi folosind AVL." << endl << endl;
	o << "1) Gasim pactientul cu cea mai mare prioritate folosind Heap si apoi folosind AVL." << endl << endl;

	auto start = steady_clock::now();
	max = HeapGetMax(Heapclient);
	auto stop = steady_clock::now();
	float time = chrono::duration_cast<chrono::nanoseconds>(stop - start).count()/1000000.0;
	float remember = time;

	cout << "Urmeaza pacientul nr " << max << " cu descrierea " << Heapclient->elem[0].descriere << ";" << endl;
	cout << "Timp de executie folosind Max-heap: " << time << " ms" << endl << endl;
	o << "Urmeaza pacientul nr " << max << " cu descrierea " << Heapclient->elem[0].descriere << ";" << endl;
	o << "Timp de executie folosind Max-heap: " << time << " ms" << endl << endl;

	start = steady_clock::now();
	AVLnod = AVLMaximum(AVLclient->radacina->stanga);
	stop = steady_clock::now();
	time = chrono::duration_cast<chrono::nanoseconds>(stop - start).count()/1000000.0;

	cout << "Urmeaza pacientul nr " << AVLnod->cheie << " cu descrierea " << AVLnod->descriere << ";" << endl;
	cout << "Timp de executie folosind AVL: " << time << " ms" << endl << endl << endl;
	o << "Urmeaza pacientul nr " << AVLnod->cheie << " cu descrierea " << AVLnod->descriere << ";" << endl;
	o << "Timp de executie folosind AVL: " << time << " ms" << endl << endl << endl;

	// In acest caz Max-heap-ul bate la performanta AVL-ul deoarece maximul din heap se aceseaza din radacina,
	// insa la AVL este nevoie de parcurgere pana la nodul cel mai din dreapta. Cu cat baza de date este mai mare
	// cu atat heap-ul va avea o performanta mai buna fata de AVL


	// Pentru a trece la urmatorul pacient este necesara eliminarea ultimului pacient de pe lista, de aceea...

	cout << "2) Eliminam pactientul cu cea mai mare prioritate din Heap si apoi din AVL." << endl << endl;
	o << "2) Eliminam pactientul cu cea mai mare prioritate din Heap si apoi din AVL." << endl << endl;

	// Avand in vedere ca HeapExtractMax extrage elementul maxim si il elimina din heap, am scazut din durata eliminarii
	// durata gasirii maxim-ului in heap pentru ca testul sa fie corect.

	start = steady_clock::now();
	Heapnod = HeapExtractMax(Heapclient);
	stop = steady_clock::now();
	time = chrono::duration_cast<chrono::nanoseconds>(stop - start).count()/1000000.0 - remember;

	max = HeapGetMax(Heapclient);

	cout << "Urmeaza pacientul nr " << max << " cu descrierea " << Heapclient->elem[0].descriere << ";" << endl;
	cout << "Timp de executie pentru eliminare folosind Max-heap: " << time << " ms" << endl << endl;
	o << "Urmeaza pacientul nr " << max << " cu descrierea " << Heapclient->elem[0].descriere << ";" << endl;
	o << "Timp de executie pentru eliminare folosind Max-heap: " << time << " ms" << endl << endl;

	start = steady_clock::now();
	AVLnod = AVLDelete(AVLclient, AVLclient->radacina->stanga, AVLnod->cheie);
	stop = steady_clock::now();
	time = chrono::duration_cast<chrono::nanoseconds>(stop - start).count()/1000000.0 - remember;

	AVLnod = AVLMaximum(AVLclient->radacina->stanga);

	cout << "Urmeaza pacientul nr " << AVLnod->cheie << " cu descrierea " << AVLnod->descriere << ";" << endl;
	cout << "Timp de executie pentru eliminare folosind AVL: " << time << " ms" << endl << endl << endl;
	o << "Urmeaza pacientul nr " << AVLnod->cheie << " cu descrierea " << AVLnod->descriere << ";" << endl;
	o << "Timp de executie pentru eliminare folosind AVL: " << time << " ms" << endl << endl << endl;

	// In acest caz AVL-ul pare sa aiba o performanta mai buna decat heap-ul intrucat operatiile pentru eliminarea maximului
	// sunt mai costisitoare la heap fata de AVL.

	// In concluzie Max-Heap-ul este cel mai bun cand vine vorba de gasirea elementului maxim, insa la eliminarea elemntului
	// maxim AVL-ul este mai eficient din punct de vedere al timpului de executie fata de Max-Heap.
}