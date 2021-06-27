#include <stdio.h>
#include <string.h>
#include <stdlib.h>
/*
*	Created by Nan Mihai on 05.03.2020
*	Copyright (c) 2020 Nan Mihai. All rights reserved.
*	Laborator 3 - Proiectarea algoritmilor (Greedy)
*	Facultatea de Automatica si Calculatoare
*	Anul Universitar 2019-2020, Seria CD
*/
#include "heap.h"

typedef struct pair {
	unsigned char value;
	unsigned int appearances;
} Pair;

/**
*	Variabilă globală folosită pentru setarea id-ului unui nod, în funcția
* initHuffman.
**/
int idx;

/**
*	Inițializează un nod ar arborelui de compresie Huffman, alocându-i și
* memorie.
**/
TreeNode initHuffman(double frequency,
					 unsigned char value,
					 TreeNode left,
					 TreeNode right);

/**
*	Funcție generică de comparare, folosită pentru heap.
**/
int treeNode_compare(const void* a_pointer, const void* b_pointer);

/**
*	Funcție care primește textul ce urmează a fi codificat și realizeaza
* arborele de compresie Huffman, pe baza acestuia.
**/
TreeNode createHuffmanTree(char *text);

/**
*	Funcție care dealocă memoria alocată pentru un arbore de compresie.
**/
TreeNode freeTree(TreeNode root);

void drawHeapAux(Heap h, int index, FILE* stream);
