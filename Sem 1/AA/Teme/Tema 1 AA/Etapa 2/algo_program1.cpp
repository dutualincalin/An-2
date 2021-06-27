#include <iostream>
#include <fstream>
#include <chrono>
#include "algo.h"

using namespace std;
using namespace std::chrono;

// Sa presupunem ca acest program este folosit pentru a retine inventarul trenurilor dintr-o gara.

int main(){

	cout << "Programul 1"<< endl << endl;
	ifstream f("./in/test_tren.in");
	ofstream o("./out/test_tren.out");

	int capacitate, greutate, i = 0, nr_total, min = 9999;
	string descriere;

	f >> capacitate;
	AVLTree *AVLtren = createAVLTree();
	MaxHeap *Heaptren = makeHeap(capacitate);
	AVLNode *AVLnod;
	HeapNode Heapnod;

	// Consideram prioritatea heap-ului si cheia AVL-ului ca fiind greuatea trenului
	f >> nr_total;

	while(i < nr_total){
		f >> greutate;
		getline(f, descriere);

		AVLtren->radacina->stanga = AVLInsert(AVLtren, AVLtren->radacina->stanga, greutate, descriere);
		HeapInsert(Heaptren, HeapNewNode(greutate, descriere));

		i++;
	}

	// Pentru incarcarea a cat mai multa marfa este nevoie de un tren cat mai gol, de aceea...

	cout << "1) Cautam trenul cu cea mai mica greutate folosind AVL si apoi folosind Heap." << endl << endl;
	o << "1) Cautam trenul cu cea mai mica greutate folosind AVL si apoi folosind Heap." << endl << endl;

	auto start = steady_clock::now();

	AVLnod = AVLMinimum(AVLtren->radacina->stanga);
	
	auto stop = steady_clock::now();
	float time = chrono::duration_cast<chrono::nanoseconds>(stop - start).count()/1000000.0;

	cout << "Tren-ul din AVL cu cea mai mica greutate: " << AVLnod->cheie;
	cout << " - " << AVLnod->descriere << ";" << endl << "Timp de executie: " << time << " ms" << endl << endl << endl;

	o << "Tren-ul din AVL cu cea mai mica greutate: " << AVLnod->cheie;
	o << " - " << AVLnod->descriere << ";" << endl << "Timp de executie: " << time << " ms" << endl << endl << endl;

	start = steady_clock::now();
	for(i = 0; i < Heaptren->nr_elem; i++){
		if(Heaptren->elem[i].prioritate < min){
			min = Heaptren->elem[i].prioritate;
			Heapnod = Heaptren->elem[i];
		}
	}

	stop = steady_clock::now();
	time = chrono::duration_cast<chrono::nanoseconds>(stop - start).count()/1000000.0;

	cout << "Tren-ul din Heap cu cea mai mica greutate: " << Heapnod.prioritate;
	cout << " - " << Heapnod.descriere << ";" << endl << "Timp de executie: " << time << " ms" << endl << endl;

	o << "Tren-ul din Heap cu cea mai mica greutate: " << Heapnod.prioritate;
	o << " - " << Heapnod.descriere << ";" << endl << "Timp de executie: " << time << " ms" << endl << endl;

	// Acest caz este cel mai rau pentru Heap deoarece va trebui sa se parcurga toate elementele din heap deoarece vectorul
	// heap-ului nu este sortat. Pentru AVL acest caz este worst case deoarece este nevoie sa se parcurga log n
	// elemente, o ramura intreaga, insa AVL are o performanta mult mai buna fata de Heap daca ne uitam la timpii de executie.


	// O alta utilizare ar fi sa aflam care din trenuri are o anumita greutate, citita din fisier, pentru a formula documentele
	// oficiale necesare pentru o calatorie, de aceea...

	cout << "2) Cautam un tren cu o anumita greutate primita ca parametru folosind AVL si apoi folosind Heap." << endl << endl;
	o << "2) Cautam un tren cu o anumita greutate primita ca parametru folosind AVL apoi folosind Heap." << endl << endl;
	f >> greutate;
	AVLnod = AVLtren->radacina->stanga;

	start = steady_clock::now();
	while(AVLnod != NULL){

		if(AVLnod->cheie > greutate)
			AVLnod = AVLnod->stanga;

		if(AVLnod->cheie < greutate)
			AVLnod = AVLnod->dreapta;

		if(AVLnod->cheie == greutate){
			break;
		}
	}

	stop = steady_clock::now();
	time = chrono::duration_cast<chrono::nanoseconds>(stop - start).count()/1000000.0;

	cout << "Tren-ul din AVL cu greutatea cautata: " << AVLnod->cheie << " - ";
	cout << AVLnod->descriere << ";" << endl;
	o << "Tren-ul din AVL cu greutatea cautata: " << AVLnod->cheie << " - ";
	o << AVLnod->descriere << ";" << endl;
	cout << "Timp de executie: " << time << " ms" << endl << endl << endl;
	o << "Timp de executie: " << time << " ms" << endl << endl << endl;

	start = steady_clock::now();
	for(i = 0; i < Heaptren->nr_elem; i++){
		if(Heaptren->elem[i].prioritate == greutate){
			Heapnod = Heaptren->elem[i];
			break;
		}
	}
	stop = steady_clock::now();
	time = chrono::duration_cast<chrono::nanoseconds>(stop - start).count()/1000000.0;

	cout << "Tren-ul din Heap cu greutatea cautata: " << Heapnod.prioritate << " - ";
	cout << Heapnod.descriere << ";" << endl << "Timp de executie: " << time << " ms" << endl << endl<< endl;

	o << "Tren-ul din Heap cu greutatea cautata: " << Heapnod.prioritate << " - ";
	o << Heapnod.descriere << ";" << endl << "Timp de executie: " << time << " ms" << endl << endl<< endl;

	// In acest caz Heap-ul poate avea: un best case daca greutatea este cea mai mare din heap, un average case daca gaseste
	// trenul cu greutatea ceruta parcurgand doar o parte din elemente sau un worst case daca gaseste trenul parcurgand
	// toate elementele sau nu il gaseste deloc. In cazul AVL-ului avem: best case - cand trenul cautat este in radacina din
	// AVL, average case cand trebuie sa parcurga un numar de noduri < log n si worst case cand trebuie parcurse log n
	// noduri. Totusi AVL-ul are o performanta mult mai buna si in acest caz decat heap-ul din puctul de vedere al
	// timpului de executie.

	// Totusi in cazul in care se cere trenul cu greutatea maxima, heap-ul din acest program depaseste cu mult performantele
	// AVL-ului. Fiind un max-heap avem acces la elementul maxim prin radacina heap-ului, in schimb la AVL trebuie sa se
	// parcurga arborele pana la nodul cel mai din dreapta.

	// In concluzie, se poate observa faptul ca arborele AVL este mult mai eficient decat Max-heap la cautarea elementelor.

	AVLtren = AVLSendTreeToOblivion(AVLtren);
	Heaptren = HeapSendMaxToOblivion(Heaptren);

}