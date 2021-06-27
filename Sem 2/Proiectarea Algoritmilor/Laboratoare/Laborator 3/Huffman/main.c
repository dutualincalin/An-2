/*
*	Created by Nan Mihai on 05.03.2020
*	Copyright (c) 2020 Nan Mihai. All rights reserved.
*	Laborator 3 - Proiectarea algoritmilor (Greedy)
*	Facultatea de Automatica si Calculatoare
*	Anul Universitar 2019-2020, Seria CD
*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <math.h>

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

int check(double value1, double value2) {
	return fabs(value1 - value2) <= 0.01;
}

typedef struct product {
	int value, weight;
} Product;

double fractionalKnapsack(Product *arr, int n, int Gmax) {
	return 0.0;
}

typedef struct show {
	int begin, end;
	int idx;
} Show;

int *planningShows(Show *arr, int n, int *size) {
	return arr;
}

static char *test_problema2() {
	Product arr1[3];
	arr1[0].value = 60;
	arr1[1].value = 100;
	arr1[2].value = 120;
	arr1[0].weight = 10;
	arr1[1].weight = 20;
	arr1[2].weight = 30;
	pa_assert("Problema2 - Test1 picat", check(fractionalKnapsack(arr1, 3, 50), 240.0));
		
	Product arr2[3];
	arr2[0].value = 7;
	arr2[1].value = 10;
	arr2[2].value = 2;
	arr2[0].weight = 4;
	arr2[1].weight = 3;
	arr2[2].weight = 9;
	pa_assert("Problema2 - Test2 picat", check(fractionalKnapsack(arr2, 3, 2), 6.666));

	Product arr3[4];
	arr3[0].value = 280;
	arr3[0].weight = 40;
	arr3[1].value = 100;
	arr3[1].weight = 10;
	arr3[2].value = 120;
	arr3[2].weight = 20;
	arr3[3].value = 120;
	arr3[3].weight = 24;
	pa_assert("Problema2 - Test3 picat", check(fractionalKnapsack(arr3, 4, 60), 440));

	Product arr4[6] = {{6, 6}, {2, 10}, {1, 3}, {8, 5}, {3, 1}, {5, 3}};
	pa_assert("Problema2 - Test4 picat", check(fractionalKnapsack(arr4, 6, 16), 22.333));

	return 0;
}

int check_arrays(int *arr1, int *arr2, int size1, int size2) {
	if (size1 != size2)
		return 0;
	int i;
	for (i = 0; i < size1; i++) {
		if (arr2[i] != arr1[i])
			return 0;
	}
	return 1;
}

static char *test_problema3() {
	int sol1[] = {4, 1, 3};
	int size1 = 0;
	Show arr1[5] = {{12*60+30, 16*60+30, 0}, {15*60,18*60,1}, {10*60,18*60+30,2}, {18*60,20*60+45, 3},
					{12*60+15, 13*60, 4}};
	int *rez1 = planningShows(arr1, 5, &size1);
	pa_assert("Problema3 - Test1 picat", check_arrays(sol1, rez1, 3, size1));
	
	Show arr2[10] = {{5, 14, 0}, {14, 17, 1}, {8, 13, 2}, {13, 15, 3}, {15, 17, 4}, {3, 6, 5},
					 {4, 7, 6}, {6, 9, 7}, {11, 14, 8}, {10, 11, 9}};
	int size2 = 0;
	int *rez2 = planningShows(arr2, 10, &size2);
	pa_assert("Problema3 - Test2 picat", size2 == 5);
	return 0;
}

static char *all_tests() {
	pa_run_test(test_problema2, 3);
	pa_run_test(test_problema3, 3);
	return 0;
}

static char *selective_tests(int argc, char **argv) {
	int i;
	int viz[5] = {0};
	for (i = 1; i < argc; i++) {
		if (viz[atoi(argv[i])]) {
			continue;
		}
		if (!strcmp(argv[i], "2")) {
			viz[1] = 1;
			pa_run_test(test_problema2, 2);
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
