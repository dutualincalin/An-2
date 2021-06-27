#ifndef _HELPERS_H
#define _HELPERS_H 1

#include <stdio.h>
#include <stdlib.h>


#define DIE(assertion, call_description)	\
	do {									\
		if (assertion) {					\
			fprintf(stderr, "(%s, %d): ",	\
					__FILE__, __LINE__);	\
			perror(call_description);		\
			exit(EXIT_FAILURE);				\
		}									\
	} while(0)

#define BUFLEN 	10000

#endif

typedef struct{
	char nume[100];
	int cmd;
	char descriere[1001];
	int ind;
} Client_cmd;

typedef struct Item Item;

struct Item{
	char nume[100];
	char descriere[1000];
	Item *next;
};

typedef struct{
	int no_elems;
	Item *items;
} Item_list;
