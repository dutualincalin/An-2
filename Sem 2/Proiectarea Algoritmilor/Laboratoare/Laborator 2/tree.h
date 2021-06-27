#include <stdlib.h>
#include <stdio.h>

typedef int T;

typedef struct tree {
	T value;
	struct tree *left, *right;
} *Tree;

Tree createTree(T value);
void inorder(Tree root);
void preorder(Tree root);
void postorder(Tree root);
Tree freeTree(Tree root);