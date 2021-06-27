#include <cstddef>
#include <iostream>
#include <cstdlib>
#include "algo.h"

using namespace std;

//Implementariile functiilor pentru AVL tree

// O parte din functiile pentru AVL au fost inspirate intr-o mare masura de pe
// site-ul GeeksforGeeks. Cele 2 link-uri au fost accesate la data de 27 noiembrie 2020 
// URL 1: https://www.geeksforgeeks.org/avl-tree-set-1-insertion/
// URL 2: https://www.geeksforgeeks.org/avl-tree-set-2-deletion/
//
// Precizare: La functia delete in cazul in care nodul de sters (sa ii spunem n) are 2 copii,
// se va considera predecesorul nodului n in Inorder ca inlocuitor.

AVLTree* createAVLTree(){
	AVLTree *tree = new AVLTree();

	tree->radacina = new AVLNode();
	tree->radacina->stanga = NULL;
	tree->radacina->dreapta = NULL;
	tree->radacina->inaltime = 0;
	tree->nr_elem = 0;

	return tree;
}

int AVLIsEmpty(AVLTree* tree){
	if(tree->radacina->stanga == NULL)
		return 1;
	else return 0;
}

AVLNode* AVLNewNode(int cheie, string descriere){
	AVLNode *nod  = new AVLNode();
	nod->stanga = NULL;
	nod->dreapta = NULL;
	nod->inaltime = 1;
	nod->descriere = descriere;
	nod->cheie = cheie;
	return nod;
}

int height(AVLNode *nod){
	if(nod == NULL)
		return 0;

	return nod->inaltime;
}

int max(int a, int b){
	if(a > b)
		return a;
	else return b;
}

AVLNode* AVLRightRotate(AVLNode *y){

	AVLNode *x = y->stanga;
	AVLNode *aux = x->dreapta;

	x->dreapta = y;
	y->stanga = aux;

	y->inaltime = max(height(y->stanga), height(y->dreapta)) + 1;
	x->inaltime = max(height(x->stanga), height(x->dreapta)) + 1;

	return x;
}

AVLNode* AVLLeftRotate(AVLNode *x){
	AVLNode *aux;

	AVLNode *y = x->dreapta;
	aux = y->stanga;

	y->stanga = x;
	x->dreapta = aux;

	x->inaltime = max(height(x->stanga), height(x->dreapta)) + 1;
	y->inaltime = max(height(y->stanga), height(y->dreapta)) + 1;

	return y;
}

int AVLGetBalance(AVLNode *nod){
	if(nod == NULL)
		return 0;

	int stanga = height(nod->stanga);
	int dreapta = height(nod->dreapta);
	return stanga - dreapta;
}

AVLNode* AVLInsert(AVLTree *tree, AVLNode *nod, int key, string description){
	if(nod == NULL){
		tree->nr_elem++;
		return(AVLNewNode(key, description));
	}

	if(key > nod->cheie)
		nod->dreapta = AVLInsert(tree, nod->dreapta, key, description);
	
	else{
		if(key < nod->cheie)
			nod->stanga = AVLInsert(tree, nod->stanga, key, description);

		else{
			tree->nr_elem++;
			return nod;
		}
	}

	nod->inaltime  = max(height(nod->stanga),height(nod->dreapta)) + 1;

	int factBalans = AVLGetBalance(nod);

	if(factBalans > 1 && key < nod->stanga->cheie){
		return AVLRightRotate(nod);
	}

	if(factBalans < -1 && key > nod->dreapta->cheie){
		return AVLLeftRotate(nod);
	}

	if(factBalans > 1 && key > nod->stanga->cheie)
	{
		nod->stanga = AVLLeftRotate(nod->stanga);
		return AVLRightRotate(nod);
	}

	if(factBalans < -1 && key < nod->dreapta->cheie){
		nod->dreapta = AVLRightRotate(nod->dreapta);
		return AVLLeftRotate(nod);
	}

	return nod;
}

AVLNode* AVLMinimum(AVLNode* nod){
	while(nod->stanga != NULL)
		nod = nod->stanga;

	return nod;
}

AVLNode* AVLMaximum(AVLNode* nod){
	while(nod->dreapta != NULL)
		nod = nod->dreapta;

	return nod;
}

int AVLinOrder(AVLNode *nod ,int v[], int i){  
    if(nod == NULL){
    	return i;
    }

    i = AVLinOrder(nod->stanga, v, i);  
    v[i++] = nod->cheie;
    i = AVLinOrder(nod->dreapta, v, i);

    return i;
}

AVLNode* AVLDelete(AVLTree* tree, AVLNode *nod, int key){
	if(nod == NULL)
		return nod;

	if(tree->nr_elem == 1){
		free (tree->radacina->stanga);
		tree->nr_elem = 0;
		return NULL;
	}


	if(key < nod->cheie){
		nod->stanga = AVLDelete(tree, nod->stanga, key);
	}

	else if(key > nod->cheie)
		nod->dreapta = AVLDelete(tree, nod->dreapta, key);

	else{
		if((nod->stanga == NULL) || (nod->dreapta == NULL)){
			AVLNode *aux = nod->stanga ?
						nod->stanga :
						nod->dreapta;

			if(aux == NULL){
				aux = nod;
				nod = NULL;
			}

			else *nod = *aux;

			free(aux);
		}

		else{
			AVLNode *aux = AVLMaximum(nod->stanga);
			nod->cheie = aux->cheie;
			nod->stanga = AVLDelete(tree, nod->stanga, aux->cheie);
		}
		
	}

	if(nod == tree->radacina->stanga){
		tree->nr_elem--;
	}

	if(nod == NULL){
		return nod;
	}


	nod->inaltime = 1 + max(height(nod->stanga),height(nod->dreapta));
	int factBalans = AVLGetBalance(nod);

	if(factBalans > 1 && AVLGetBalance(nod->stanga) >= 0)
		return AVLRightRotate(nod);

	if(factBalans < -1 && AVLGetBalance(nod->dreapta) <= 0)
		return AVLLeftRotate(nod);

	if(factBalans > 1 && AVLGetBalance(nod->stanga) < 0){
		nod->stanga = AVLLeftRotate(nod->stanga);
		return AVLRightRotate(nod);
	}

	if(factBalans < -1 && AVLGetBalance(nod->dreapta) > 0){
		nod->dreapta = AVLRightRotate(nod->dreapta);
		return AVLLeftRotate(nod);
	}


	return nod;
}

void AVLDeleteHelper(AVLNode *nod){
	if(nod->stanga != NULL)
		AVLDeleteHelper(nod->stanga);

	if(nod->dreapta != NULL)
		AVLDeleteHelper(nod->dreapta);

	free(nod);
}

AVLTree* AVLSendTreeToOblivion(AVLTree *tree){
	AVLDeleteHelper(tree->radacina);
	free(tree);
	tree = NULL;
	return tree;
}

// Implementariile functiilor pentru Max-Heap

// Max-heap-ul este stocat folosind un vector nesortat.

// O parte din acest cod a fost inspirat din cursurile si laboratoarele  echipei de Structuri de date 
// din Universitatea Politehnica Bucuresti. Link-ul urmator a fost accesat la data de 29 noiembrie.
// URL: https://acs.curs.pub.ro/2019/course/view.php?id=145

MaxHeap* makeHeap(int capacitate){
	MaxHeap* heap = new MaxHeap();
	heap->capacitate = capacitate;
	heap->nr_elem = 0;
	heap->elem = new HeapNode[capacitate];

	for(int i = 0; i < capacitate; i++){
		heap->elem[i].prioritate = 0;
	}

	return heap;
}

HeapNode HeapNewNode(int prioritate, string descriere){
	HeapNode nod;
	nod.prioritate = prioritate;
	nod.descriere = descriere;
	return nod;
}

int getLeftChild(int i) {
	return (i*2+1);
}

int getRightChild(int i) {
	return (i*2+2);
}

int getParent(int i) {
	return  abs((i-1)/2);
}

void HeapSiftUp(MaxHeap* heap, int idx){
	int id_parinte = getParent(idx);
	HeapNode aux = heap->elem[idx];
	heap->elem[idx] = heap->elem[id_parinte];
	heap->elem[id_parinte] = aux;
}

void HeapInsert(MaxHeap* heap, HeapNode x){
	if(heap->nr_elem == heap->capacitate){
		return;
	}

	int id_parinte,id_x;
	id_x = heap->nr_elem;
	heap->nr_elem++;
	heap->elem[id_x] = x;

	while (1){
		id_parinte = getParent(id_x);

		if(heap->elem[id_parinte].prioritate < heap->elem[id_x].prioritate && id_x != 0)
			HeapSiftUp(heap,id_x);

		else return;
		
		id_x = id_parinte;
	}
}

int HeapGetMax(MaxHeap* heap){
	return heap->elem[0].prioritate;
}

void HeapSiftDown(MaxHeap* heap, int idx){
	int id_stanga = 0, id_dreapta = 0;
	HeapNode aux;

	while(idx < heap->nr_elem && id_stanga < heap->nr_elem && id_dreapta < heap->nr_elem){
		id_stanga = getLeftChild(idx);
		id_dreapta = getRightChild(idx);

		if(heap->elem[idx].prioritate < heap->elem[id_stanga].prioritate
	   		&& heap->elem[id_stanga].prioritate > heap->elem[id_dreapta].prioritate){

			aux = heap->elem[id_stanga];
			heap->elem[id_stanga] = heap->elem[idx];
			heap->elem[idx] = aux;
			idx = id_stanga;
		}

		else
			if(heap->elem[id_stanga].prioritate < heap->elem[id_dreapta].prioritate
				&&  heap->elem[idx].prioritate < heap->elem[id_dreapta].prioritate){

				aux = heap->elem[id_dreapta];
				heap->elem[id_dreapta] = heap->elem[idx];
				heap->elem[idx] = aux;
				idx = id_dreapta;
			}		
	}

	return;
}

HeapNode HeapExtractMax(MaxHeap* heap){
	HeapNode nod;
	int id_x;

	id_x = heap->nr_elem - 1;
	nod = heap->elem[0];
	heap->elem[0] = heap->elem[id_x];
	heap->nr_elem--;
	id_x = 0;

	HeapSiftDown(heap,id_x);
	return nod;
}

MaxHeap* HeapSendMaxToOblivion(MaxHeap* heap){
	free(heap);
	heap = NULL;
	return heap;
}