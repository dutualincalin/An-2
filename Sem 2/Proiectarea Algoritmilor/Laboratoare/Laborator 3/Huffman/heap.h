/*
*	Created by Nan Mihai on 05.03.2020
*	Copyright (c) 2020 Nan Mihai. All rights reserved.
*	Laborator 3 - Proiectarea algoritmilor (Greedy)
*	Facultatea de Automatica si Calculatoare
*	Anul Universitar 2019-2020, Seria CD
*/
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define MAX 	10000
#define SIZE 	200

typedef struct treeNode {
	double frequency;
	unsigned char value;
	struct treeNode *left, *right;
	int idx;
} *TreeNode;

/**
*	Pentru primele 2 cerințe, lăsați comentată a doua linie și decomentată prima,
* iar pentru restul invers.
**/
// typedef int Type;
typedef TreeNode Type;

typedef struct heap {
	Type vector[MAX];
	int size;
	int capacity;
	int (*compare_func)(const void*, const void*);
} *Heap;

/**
* 	Inițializează cu 0 dimensiunea heap-ului și atribuie valoarea pentru
* funcția generică de comparare.
* 	De asemenea, alocă și memorie pentru structura heap.
**/
Heap initHeap(int (*compare_func) (const void*, const void*));

/**
*	Funcții auxiliare care realizează "cernerea" pentru a menține proprie-
* tățile structurii de date.
**/
Heap siftDown(Heap h, int index);
Heap siftUp(Heap h, int index);
Heap swapAndSiftDown(Heap h, int parent, int child);

/**
*	Introduce un element în heap și realizează "cernerea" pentru asigura-
* rea respectării proprietăților de maxHeap.
**/
Heap insertHeap(Heap h, Type element);

/**
*	Extrage elementul maxim din heap (rădăcina heap-ului).
**/
Type extractMax(Heap h);

/**
*	Funcție care dealoca memoria alocată pentru structura de date.
**/
Heap freeHeap(Heap h);