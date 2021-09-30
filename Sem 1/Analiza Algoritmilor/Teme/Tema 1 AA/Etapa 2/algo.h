#ifndef ALGO_H
#define ALGO_H

using namespace std;

class AVLNode{
public:
	int cheie;
	int inaltime;
	string descriere;
	AVLNode *stanga;
	AVLNode *dreapta;
};

class AVLTree{
public:
	int nr_elem;
	AVLNode *radacina;
};

class HeapNode{
public:
	string descriere;
	int prioritate;
};

class MaxHeap{
public:
	int capacitate;
	int nr_elem;
	HeapNode *elem;
};

// Semnaturile functiilor pentru AVL tree

AVLTree* createAVLTree();

int AVLIsEmpty(AVLTree* tree);

AVLNode* AVLNewNode(int key);

int height(AVLNode *nod);

int max(int a, int b);

AVLNode* AVLRightRotate(AVLNode *y);

AVLNode* AVLLeftRotate(AVLNode *x);

int AVLGetBalance(AVLNode *nod);

AVLNode* AVLInsert(AVLTree *tree, AVLNode *nod, int key , string description);

AVLNode* AVLMinimum(AVLNode* nod);

AVLNode* AVLMaximum(AVLNode* nod);

int AVLinOrder(AVLNode *nod ,int v[], int i);

AVLNode* AVLDelete(AVLTree* tree, AVLNode *nod, int key);

void AVLDeleteHelper(AVLNode *nod);

AVLTree* AVLSendTreeToOblivion(AVLTree *tree);


// Semnaturile functiilor pentru un Min-Heap

MaxHeap* makeHeap(int capacitate);

HeapNode HeapNewNode(int prioritate, string continut);

int getLeftChild(int i);

int getRightChild(int i);

int getParent(int i);

void HeapSiftUp(MaxHeap* heap, int idx);

void HeapInsert(MaxHeap* heap, HeapNode x);

int HeapGetMax(MaxHeap* heap);

void HeapSiftDown(MaxHeap* heap, int idx);

HeapNode HeapExtractMax(MaxHeap* heap);

MaxHeap* HeapSendMaxToOblivion(MaxHeap* heap);

#endif