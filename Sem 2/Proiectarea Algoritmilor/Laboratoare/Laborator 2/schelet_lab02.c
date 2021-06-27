/*
*	Created by Nan Mihai on 23.02.2020
*	Copyright (c) 2020 Nan Mihai. All rights reserved.
*	Laborator 1 - Proiectarea algoritmilor (Divide et Impera)
*	Facultatea de Automatica si Calculatoare
*	Anul Universitar 2019-2020, Seria CD
*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include "tree.h"

#define pa_assert(message, test) \
	do { \
		if (!(test)) \
			return message; \
	} while (0)
	
#define pa_run_test(test, score) \
	do { \
		char *message = test(); \
		tests_run++; \
		if (message) \
			return message; \
		else \
			total_score += score; \
	} while (0)

int tests_run = 0;
int total_score = 0;

/*
*	Problema 1
*   arr1 - primul vector sortat crescător
*   arr2 - al doilea vector sortat crescător
*   size - numărul de elemente comune din cei doi vectori
*/
int element_dei(int *arr1, int *arr2, int start, int finish){
	int ind = (start + finish)/2;

	if(arr1[ind] != arr2[ind]){
		return ind;
	}

	if(start == finish){
		return -1;
	}

	int k = element_dei(arr1, arr2 , start, ind);

	if(k != -1){
		return k;
	}

	k = element_dei(arr1, arr2 , ind + 1, finish);

	if(k != -1){
		return k;
	}

	else return -1;
}

int find_missing_element(int *arr1, int *arr2, int size) {
	// int fk = size + 1;

	// if(arr1[size/2] != arr2[size/2])
	// 	fk = size/2;

	int k = element_dei(arr1, arr2 , 0, (size - 1)/2);

	if(k != -1){
		return k;
	}

	// else if(fk < size){
	// 	return fk;
	// }

	k = element_dei(arr1, arr2 , (size - 1)/2 + 1, size - 1);

	if(k != -1){
		return k;
	}

	else return size;
}

/*
*	Problema 2
*   arr - vectorul de cuvinte
*   size - dimensiunea vectorului de cuvinte
*/

char *common_prefix_of_two(char *arr1, char *arr2){
	int i = 0;

	while(i > -1){
		if(arr1[i] == '\0' || arr2[i] == '\0'){
			break;
		}

		if(arr1[i] != arr2[i]){
			break;
		}

		i++;
	}

	return strndup(arr1, i);
}

char *common_prefix_dei(char **arr, int start, int finish){
	if(start == finish){
		return arr[start];
	}

	int ind = (start + finish)/2;

	common_prefix_of_two(common_prefix_dei(arr, start, ind), common_prefix_dei(arr, ind + 1, finish));
}

char *longest_common_prefix(char **arr, int size) {
	return common_prefix_dei(arr, 0, size - 1);
}

/*
*	Problema 3
*   inOrder - vectorul care conține parcurgerea în inordine
*   preOrder - vectorul care  conține parcurgerea în preordine
*   inLeft - indicele primului element din vectorul inOrder
*   inRight - indicele ultimului element din vectorul inOrder
*   preIndex - indicele elementului din vectorul preOrder care urmează să fie adăugat
*/
int expand_tree_dei(Tree tree, int *inOrder, int *preOrder, int start, int finish, int indP){

	if(start == finish){
		tree = createTree(preOrder[indP]);
		return indP;
	}

	int i, ind;

	for(i = start; i <= finish; i++){
		if(inOrder[i] == preOrder[indP]){
			break;
		}
	}

	tree = createTree(preOrder[indP]);

	if(i == finish){
		return expand_tree_dei(tree->left, inOrder, preOrder, start, i - 1, indP + 1);
	}

	else if(i == start){
		return expand_tree_dei(tree->right, inOrder, preOrder, i + 1, finish, indP + 1);
	}

	else{
		ind = expand_tree_dei(tree->left, inOrder, preOrder, start, i - 1, indP + 1);
		ind = expand_tree_dei(tree->right, inOrder, preOrder, i + 1, finish, ind + 1);
		return ind;
	}

	return 1;
}

Tree make_binary_tree(int *inOrder, int *preOrder, int inLeft, int inRight, int *preIndex) {
	int i;
	int ind;

	for(i = inLeft; i <= inRight; i++){
		if(inOrder[i] == preOrder[*preIndex]){
			break;
		}
	}

	Tree tree = createTree(inOrder[i]);
	ind = expand_tree_dei(tree->left, inOrder, preOrder, inLeft, i - 1, (*preIndex) + 1);
	ind = expand_tree_dei(tree->right, inOrder, preOrder, i + 1, inRight, ind + 1);

	return tree;

}

/*
*	Problema 4
*   (x, y) - coordonatele celulei pentru care dorim să aflăm valoarea
*/

int Z_DeI(int n, int x, int y){
	int dim = 1 << (n - 1);

	if(dim == 1){
		if(x == 1 && y == 1){
			return 1;
		}

		if(x == 1 && y == 2){
			return 2;
		}

		if(x == 2 && y == 1){
			return 3;
		}

		return 4;
	}

	else{
		if(x > dim && y > dim){
			return 3 * dim * dim + Z_DeI(n - 1,x - dim ,y - dim);
		}

		else if(x > dim && y <= dim){
			return 2 * dim * dim + Z_DeI(n - 1,x - dim ,y);
		}

		else if(x <= dim && y > dim){
			return dim * dim + Z_DeI(n - 1,x ,y - dim);
		}

		else return Z_DeI(n - 1, x, y);
	}
}

int ZParcurgere(int n, int x, int y) {
	return Z_DeI(n, x, y);
}


/*
*	Bonus 1
*   n - dimensiunea șirului magic pe care dorim să îl determinăm
*/
int *beautiful_array(int n) {
	int *result = malloc(n * sizeof(int));
	int i = 0;
	for (i = 0; i < n; i++) {
		result[i] = i+1;
	}
	return result;
}

/*
*	Bonus 2
*	arr - vectorul cu elemente
*	size - dimensiunea vectorului
*/
int peak_DeI(int *arr, int start, int finish){
	if(start == finish){
		return arr[start];
	}

	if(start > finish){
		return -99999;
	}

	int mid = (start + finish)/2;
	int bot = peak_DeI(arr, start, mid - 1);
	int top = peak_DeI(arr, mid + 1, finish);
	int max = arr[mid];

	if(max < bot){
		max = bot;
	}

	if(max < top){
		max = top;
	}

	return max;
	
}

int peak_value(int *arr, int size) {
	return peak_DeI(arr, 0, size - 1);
}

static char *test_problema1() {
	int v1[] = {1, 2, 3, 4, 5};
	int v2[] = {1, 2, 3, 4, 5, 6};
	pa_assert("Problema1 - Test1 picat", find_missing_element(v1, v2, 5) == 5);
	pa_assert("Problema1 - Test2 picat", find_missing_element(v2, v1, 5) == 5);
	int v3[] = {1, 2, 4, 5};
	pa_assert("Problema1 - Test3 picat", find_missing_element(v1, v3, 4) == 2);
	int v4[] = {2, 3, 4, 5};
	pa_assert("Problema1 - Test4 picat", find_missing_element(v1, v4, 4) == 0);
	int v5[] = {1, 2, 3, 5};
	pa_assert("Problema1 - Test5 picat", find_missing_element(v1, v5, 4) == 3);
	return 0;
}

static char *test_problema2() {
	char **arr1;
	int i;
	arr1 = malloc(3 * sizeof(char*));
	arr1[0] = strdup("ana");
	arr1[1] = strdup("ana are");
	arr1[2] = strdup("ana are mere");
	pa_assert("Problema2 - Test1 picat", !strcmp(longest_common_prefix(arr1, 3),"ana"));
	for (i = 0; i < 3; i++)
		free(arr1[i]);
	free(arr1);
	arr1 = malloc(5 * sizeof(char*));
	arr1[0] = strdup("abcd");
	arr1[1] = strdup("acdb");
	arr1[2] = strdup("abcdefgh");
	arr1[3] = strdup("abcdefghijk");
	arr1[4] = strdup("ab");
	pa_assert("Problema2 - Test2 picat", !strcmp(longest_common_prefix(arr1, 5),"a"));
	arr1[1][1] = 'b';
	pa_assert("Problema2 - Test3 picat", !strcmp(longest_common_prefix(arr1, 5),"ab"));
	for (i = 0; i < 5; i++)
		free(arr1[i]);
	free(arr1);
	return 0;
}

int checkBST(Tree node) { 
	if (node == NULL) 
		return 1;
	if (node->left != NULL && node->left->value > node->value)
		return 0; 
	if (node->right != NULL && node->right->value < node->value) 
		return 0; 
	if (!checkBST(node->left) || !checkBST(node->right)) 
		return 0; 
	return 1; 
}

void bst_print_dot_aux(Tree node, FILE* stream) {
    static int nullcount = 0;

    if (node->left) {
        fprintf(stream, "    %d -> %d;\n", node->value, node->left->value);
        bst_print_dot_aux(node->left, stream);
    }
    if (node->right) {
        fprintf(stream, "    %d -> %d;\n", node->value, node->right->value);
        bst_print_dot_aux(node->right, stream);
    }
}

void bst_print_dot(Tree tree, FILE* stream, int type) {
    fprintf(stream, "digraph BST {\n");
    if (type == 1)
    	fprintf(stream, "    node [fontname=\"Arial\", shape=circle, style=filled, fillcolor=red];\n");
    else
    	fprintf(stream, "    node [fontname=\"Arial\", shape=circle, style=filled, fillcolor=blue];\n");
    if (!tree)
        fprintf(stream, "\n");
    else if (!tree->right && !tree->left)
        fprintf(stream, "    %d;\n", tree->value);
    else
        bst_print_dot_aux(tree, stream);
    fprintf(stream, "}\n");
}

static char *test_problema3() {
	int preOrder1[] = {4, 1, 0, 3, 2, 6, 5, 8, 7, 9};
	int inOrder1[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
	int index = 0;
	Tree root = make_binary_tree(inOrder1, preOrder1, 0, 9, &index);
	FILE *fout = fopen("test.dot", "w");
	bst_print_dot(root, fout, 1);
	fclose(fout);
	system("dot test.dot | neato -n -Tpng -o prob3_test1.png");
	pa_assert("Problema3 - Test1 picat", checkBST(root) && root != NULL && root->value == 4);
	root = freeTree(root);

	int preOrder2[] = {10, 7, 5, 6, 9, 8, 20, 15, 13, 18, 40};
	int inOrder2[] = {5, 6, 7, 8, 9, 10, 13, 15, 18, 20, 40};
	index = 0;
	root = make_binary_tree(inOrder2, preOrder2, 0, 10, &index);
	fout = fopen("test.dot", "w");
	bst_print_dot(root, fout, 1);
	fclose(fout);
	system("dot test.dot | neato -n -Tpng -o prob3_test2.png");
	pa_assert("Problema3 - Test2 picat", checkBST(root) && root != NULL && root->value == 10);
	root = freeTree(root);

	int preOrder3[] = {10, 7, 5, 4, 3, 2, 6, 9, 8, 20, 15, 13, 14, 18, 17, 16, 19, 40, 50, 60, 70};
	int inOrder3[] = {2, 3, 4, 5, 6, 7, 8, 9, 10, 13, 14, 15, 16, 17, 18, 19, 20, 40, 50, 60, 70};
	index = 0;
	root = make_binary_tree(inOrder3, preOrder3, 0, 20, &index);
	fout = fopen("test.dot", "w");
	bst_print_dot(root, fout, 1);
	fclose(fout);
	system("dot test.dot | neato -n -Tpng -o prob3_test3.png");
	pa_assert("Problema3 - Test3 picat", checkBST(root) && root != NULL && root->value == 10);
	root = freeTree(root);

	return 0;
}

static char *test_problema4() {
	pa_assert("Problema4 - Test1 picat", ZParcurgere(1, 2, 1) == 3);
	pa_assert("Problema4 - Test2 picat", ZParcurgere(5, 10, 20) == 392);
	pa_assert("Problema4 - Test3 picat", ZParcurgere(4, 5, 7) == 53);
	pa_assert("Problema4 - Test4 picat", ZParcurgere(4, 15, 9) == 233);
	pa_assert("Problema4 - Test5 picat", ZParcurgere(3, 1, 8) == 22);
	return 0;
}

int checkBeautiful(int *arr, int size) {
	int i;
	for (i = 1; i < size - 1; i++) {
		if (arr[i] * 2 == arr[i-1] + arr[i + 1])
			return 0;
	}
	return 1;
}

static char *test_problema5() {
	int *arr1 = beautiful_array(5);
	pa_assert("Bonus 1 - Test1 picat", checkBeautiful(arr1, 5));
	free(arr1);
	arr1 = beautiful_array(10);
	pa_assert("Bonus 1 - Test2 picat", checkBeautiful(arr1, 10));
	free(arr1);
	arr1 = beautiful_array(50);
	pa_assert("Bonus 1 - Test3 picat", checkBeautiful(arr1, 50));
	free(arr1);
	arr1 = beautiful_array(100);
	pa_assert("Bonus 1 - Test4 picat", checkBeautiful(arr1, 100));
	free(arr1);
	return 0;
}

static char *test_problema6() {
	int arr1[] = {1, 2, 3, 4, 5, 4, 3};
	pa_assert("Problema6 - Test1 picat", peak_value(arr1, 7) == 5);
	int arr2[] = {1, 10, 9, 8, 7, 6, 5, 4, 3, 2};
	pa_assert("Problema6 - Test2 picat", peak_value(arr2, 10) == 10);
	int arr3[] = {1, 2, 3, 4, 5, 6, 7, 8, 10, 9};
	pa_assert("Problema6 - Test3 picat", peak_value(arr3, 10) == 10);
	int arr4[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 9, 8, 7, 6, 5, 4, 3};
	pa_assert("Problema6 - Test3 picat", peak_value(arr4, 17) == 10);
	return 0;
}

static char *all_tests() {
	pa_run_test(test_problema1, 2);
	pa_run_test(test_problema2, 2);
	pa_run_test(test_problema3, 3);
	pa_run_test(test_problema4, 3);
	// pa_run_test(test_problema5, 4);
	pa_run_test(test_problema6, 3);
	return 0;
}

static char *selective_tests(int argc, char **argv) {
	int i;
	int viz[7] = {0};
	for (i = 1; i < argc; i++) {
		if (viz[atoi(argv[i])]) {
			continue;
		}
		if (!strcmp(argv[i], "1")) {
			viz[1] = 1;
			pa_run_test(test_problema1, 2);
		} else if (!strcmp(argv[i], "2")) {
			viz[2] = 1;
			pa_run_test(test_problema2, 1);
		} else if (!strcmp(argv[i], "3")) {
			viz[3] = 1;
			pa_run_test(test_problema3, 2);
		} else if (!strcmp(argv[i], "4")) {
			viz[4] = 1;
			pa_run_test(test_problema4, 2);
		} else if (!strcmp(argv[i], "5")) {
			viz[5] = 1;
			pa_run_test(test_problema5, 4);
		} else if (!strcmp(argv[i], "6")) {
			viz[6] = 1;
			pa_run_test(test_problema6, 3);
		}
	}
	return 0;
}

int main(int argc, char **argv) {
	srand(time(NULL));
	char *result;
	if (argc == 1) {
		result = all_tests();
		if (result != 0) {
			printf("%s\n", result);
		} else {
			printf("Toate testele au trecut! Felicitari!\n");
		}
	} else {
		result = selective_tests(argc, argv);
		if (result != 0) {
			printf("%s\n", result);
		} else {
			printf("Toate testele selectate au trecut!\n");
		}
	}
	printf("Punctajul obtinut este: %d\n", total_score);
	printf("Teste rulate: %d\n", tests_run);
	return result != 0;
}
