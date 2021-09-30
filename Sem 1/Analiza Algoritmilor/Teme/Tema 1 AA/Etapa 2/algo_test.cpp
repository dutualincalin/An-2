#include <iostream>
#include <fstream>
#include <cstring>
#include <chrono>
#include <tgmath.h>
#include "algo.h"
using namespace std;
using namespace std::chrono;

#define NrTesteAVL 5
#define NrTesteHeap 10

void printLayout1(){
	cout << endl;
	cout << " ===========================================" << endl << endl;
	cout << "               Tester Tema AA"<< endl;
	cout << "           Dutu Alin Calin - 323CD"<< endl << endl;
	cout << " ==========================================="<< endl << endl;
	cout << "                 Testare AVL" << endl;
	cout << "  ******************************************" << endl << endl;
}

void printLayout2(){
	cout << endl;
	cout << "               Testare Max-Heap" << endl;
	cout << "  ******************************************" << endl << endl;
}

int main(){
	int i, j, no_elements, cheie, max, min, cond, capacity;
	AVLTree *copac;
	AVLNode *nod;
	string input, output, continut;
	float time;

	printLayout1();					// Se afiseaza Layout-ul de inceput al tester-ului si layout-ul pentru testele AVL-ului;

	for(i = 1; i <= NrTesteAVL; i++){		// Aici se acceseaza toate teste pentru AVL;
		input = ".";
		input = input + "/in/test";			// Se retine calea testelor de intrare si iesire pentru declararea
		input = input + to_string(i);		// fisierelor de intrare si iesire;
		input = input + ".in";
		
		output = ".";
		output = output + "/out/test";
		output = output + to_string(i);
		output = output + ".out";

		ifstream f(input);					// Se citesc fisierele de intrare si iesire;
		ofstream o(output);

		cout << "           Test " << to_string(i) << " - ";			// La rularea programului in consola va aparea un
		f >> no_elements;												// checker care va arata nr. testului, nr. de
		cout << no_elements << " elemente" << endl;						// elemente al testului, operatiile testului adica
		cout << "  ------------------------------------------" << endl;	// create tree, insert, max&min, delete max & min si
		cout << "     Operatie    | Rezultat | Timp executie " << endl;	// Delete AVL, fiecare operatie cu rezultatul sau si
		cout << "  ------------------------------------------" << endl;	// cu propriul sau timp de executie.

		auto start = steady_clock::now();
		cout << "   Create Tree   - ";			//Testul de creare al AVL-ului
		copac = createAVLTree();
		auto stop = steady_clock::now();													// Se folosesc variabilele
		time = chrono::duration_cast<chrono::nanoseconds>(stop - start).count()/1000000.0;	// start, stop si time pentru
																							// a calcula timpul de executie.
		if(copac != NULL)
			cout << " Succes  - ";			// Se verifica crearea AVL-ului si se trece in consola
		else cout << " Fail    - ";			// rezultatul testului si timpul de executie.

		cout << time << " ms" << endl;		// Se afiseaza timpul de executie in milisecunde

		cout << "   Insert        - ";		// Testul de inserare a elementelor;

		max = -1;
		min = 99999;

		start = steady_clock::now();		// Timpul de incepere a executiei insert-ului;
		while(f >> cheie){
			if(cheie > max)					// In timp ce se insereaza elemente, se retin minimul
				max = cheie;				// si maximul elementelor
			if(cheie < min)
				min = cheie;

			copac->radacina->stanga = AVLInsert(copac, copac->radacina->stanga, cheie, "Nod");	
		}

		stop = steady_clock::now();
		time = chrono::duration_cast<chrono::nanoseconds>(stop - start).count()/1000000.0;

		int inorder = 1;
		int v[no_elements];
		j = AVLinOrder(copac->radacina->stanga, v, 0);  // Se face si o parcurgere Inorder pentru verificarea
		o << "Parcurgerea Inorder: ";					// corectitudinii. Parcurgerea Inorder va fi afisata
														// si in fisierul de output.
		for(j = 0; j < no_elements - 1; j++)
			o << v[j]<< ", ";

		o << v[no_elements - 1] << ";" << endl; 

		for(j = 1; j < no_elements; j++){
			if(v[j-1] > v[j]){
				inorder = 0;
				break;
			}
		}

		if(copac->nr_elem == no_elements && AVLGetBalance(copac->radacina->stanga) >= -1	// Se verifica daca au fost
			&& AVLGetBalance(copac->radacina->stanga) <= 1 && inorder == 1 && 				// adaugate toate elementele,
			height(copac->radacina->stanga) < 1,44* log2(no_elements+2) - 1){		// factorul de balanta al radacinii e 
																				// intre -1 si 1 si daca inatimea radacinii
			cout << " Succes  - ";												// e mai mica decat 1,44 * log2(n + 2) - 1.
		}
		else cout << " Fail    - ";						// Se afiseaza rezultatul;
		cout << time << " ms" << endl;


		cout << "   Min & Max     - ";						// Test de obtinere a minimului si maximului;
		start = steady_clock::now();

		cond = 0;
		nod = AVLMaximum(copac->radacina->stanga);			// Obtinerea maximului;
		o << "Maximul din AVL: "<<nod->cheie<<endl;

		if(max == nod->cheie)
			cond++;

		nod = AVLMinimum(copac->radacina->stanga);			// Obtinerea minimului;
		o << "Minimul din AVL: "<<nod->cheie<<endl;

		stop = steady_clock::now();
		time = chrono::duration_cast<chrono::nanoseconds>(stop - start).count()/1000000.0;

		if(min == nod->cheie)
			cond++;

		if(cond == 2)							// Daca minimul si maximul sunt egale cu cele retinute de la insert atunci
			cout << " Succes  - ";				// rezultatul este corect.
		else cout << " Fail    - ";				// Minimul si maximul vor fi afisate in fisierul de output pentru verificare
												// folosind parcurgerea Inorder din acelasi fisier.
		cout << time << " ms" << endl;


		cout << "   Delete MinMax - ";			// Testul de eliminarea al maximului si minimului;
		start = steady_clock::now();

		cond = 0;
		copac->radacina->stanga = AVLDelete(copac, copac->radacina->stanga, max);	// Elimina maximul din AVL;
		nod = AVLMaximum(copac->radacina->stanga);
		o << "Maximul dupa delete: " << nod->cheie << ", " << max << endl;		// Scrie noul maxim in output si se poate
																				// verifica cu inorder;
		if(max != nod->cheie)		// Se verifica daca noul maxim e diferit
			cond++;					// de vechiul maxim

		copac->radacina->stanga = AVLDelete(copac, copac->radacina->stanga, min);	// Elimina minimul din AVL;
		nod = AVLMinimum(copac->radacina->stanga);
		o << "Minimul dupa delete: " << nod->cheie << ", " << min << endl;		// Scrie noul minim in output si se poate
																				// verifica cu inorder ;
		stop = steady_clock::now();
		time = chrono::duration_cast<chrono::nanoseconds>(stop - start).count()/1000000.0;

		if(min != nod->cheie)		// Se verifica daca noul minim e diferit fata de vechiul minim;
			cond++;

		if(cond == 2)
			cout << " Succes  - ";				// Se afiseaza rezultatul;
		else cout << " Fail    - ";

		cout << time << " ms" << endl;


		cout << "   Delete Tree   - ";				// Testul de eliminare al AVL-ului;
		start = steady_clock::now();

		copac = AVLSendTreeToOblivion(copac);		// Se elimina AVL-ul din memorie;
		
		stop = steady_clock::now();
		time = chrono::duration_cast<chrono::nanoseconds>(stop - start).count()/1000000.0;

		if(copac == NULL)
			cout << " Succes  - ";					// Se afiseaza rezultatul;
		else cout << " Fail    - ";

		cout << time << " ms" << endl << endl << endl;
	}

	printLayout2();					// Se afiseaza layout-ul pentru testele Max-Heap-ului;

	MaxHeap *heap;
	HeapNode Heapnod;

	for(i = 6; i <= NrTesteHeap; i++){		// Aici se acceseaza toate testele pentru Max-Heap;
		input = ".";
		input = input + "/in/test";
		input = input + to_string(i);		// Se retin numele fisierelor de input si output;
		input = input + ".in";
		
		output = ".";
		output = output + "/out/test";
		output = output + to_string(i);
		output = output + ".out";

		ifstream f(input);					// Se declara fisierele de input si output;
		ofstream o(output);

		f >> capacity;
		f >> no_elements;

		cout << "       Test " << to_string(i) << " - ";						// Fata de testele AVL, cele pentru Max-Heap
		cout << no_elements << " elemente" << ", cap: " << capacity << endl;	// mai afiseaza capacitatea heap-ului, iar 
		cout << "  ------------------------------------------" << endl;			// subtestele pentru aflarea minimului au
		cout << "     Operatie    | Rezultat | Timp executie " << endl;			// fost eliminate deoarece Max-heap-ul este
		cout << "  ------------------------------------------" << endl;			// specializat doar in extragerea maximului.


		cout << "   Create Heap   - ";					// Test de creare a Heap-ului;

		auto start = steady_clock::now();
		heap = makeHeap(capacity);						// Creare Max-Heap;
		auto stop = steady_clock::now();
		time = chrono::duration_cast<chrono::nanoseconds>(stop - start).count()/1000000.0;

		if(heap != NULL && heap->capacitate != 0 && heap->nr_elem == 0)
			cout << " Succes  - ";						// Rezultatul testului;
		else cout << " Fail    - ";

		cout << time << " ms" << endl;


		cout << "   Insert        - ";					// Testul de inserare a elementelor;
		max = -1;
		min = 99999;
		cond = 1;

		start = steady_clock::now();
		while(f >> cheie){								// Inserarea elementelor;
			if(max < cheie)								// Retinerea maxim-ului;
				max = cheie;

			f >> continut;

			HeapInsert(heap, HeapNewNode(cheie, continut));
		}

		stop = steady_clock::now();
		time = chrono::duration_cast<chrono::nanoseconds>(stop - start).count()/1000000.0;

		if(heap->nr_elem != 0)							// Se verifica daca s-au adaugat toate elementele;
			cond++;

		for(j = 0; j < heap->nr_elem; j++)
			if(heap->elem[j].prioritate == 0){			// Se verifica daca este respectata proprietatea heap-ului;
				cond--;
				break;
			}

		if(heap->elem[0].prioritate > heap->elem[1].prioritate
			&& heap->elem[0].prioritate > heap->elem[2].prioritate) // Se verifica primul element este maximul dintre copii;
			cond++;

		if(cond == 3)
			cout << " Succes  - ";						// Se afiseaza rezultatul;
		else cout << " Fail    - ";

		cout << time << " ms" << endl;


		cout << "   Maximum       - ";					// Testul pentru obtinerea maximului;
		start = steady_clock::now();
		
		if(HeapGetMax(heap) == max)						// Se verifica daca maximul obtinut coincide cu maximul obtinut
			cout << " Succes  - ";						// la insert si se afiseaza rezultatul.
		else cout << " Fail    - ";

		stop = steady_clock::now();
		time = chrono::duration_cast<chrono::nanoseconds>(stop - start).count()/1000000.0;
		cout << time << " ms" << endl;


		cout << "   Extract Max   - ";					// Testul de extragere al maximului;
		start = steady_clock::now();
		Heapnod = HeapExtractMax(heap);					// Se extrage maximul;

		stop = steady_clock::now();
		time = chrono::duration_cast<chrono::nanoseconds>(stop - start).count()/1000000.0;
		
		o << "Maximul Max-Heap-ului: " << Heapnod.prioritate << endl;			// Se scriu in fisierul de output vechiul si noul
		o << "Noul maxim dupa extragere: " << HeapGetMax(heap) << endl;			// maxim pentru comparatie;
		
		if(max != HeapGetMax(heap))
			cout << " Succes  - ";									// Se scriu rezultatele;
		else cout << " Fail    - ";

		cout << time <<" ms" << endl;


		cout << "   Delete Heap   - ";								// Testul de stergere a Max-Heap-ului;
		start = steady_clock::now();
		heap = HeapSendMaxToOblivion(heap);							// Se sterge Max-Heap-ul;
		stop = steady_clock::now();
		time = chrono::duration_cast<chrono::nanoseconds>(stop - start).count()/1000000.0;

		if(heap == NULL)
			cout << " Succes  - ";									// Se afiseaza rezultatul
		else cout << " Fail    - ";

		cout << time << " ms" << endl << endl << endl;
	}
 	return 0;
}