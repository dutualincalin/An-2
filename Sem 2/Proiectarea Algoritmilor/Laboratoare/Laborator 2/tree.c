#include "tree.h"

Tree createTree(T value) {
	Tree root = malloc(sizeof(struct tree));
	root->value = value;
	root->left = NULL;
	root->right = NULL;
	return root;
}

void inorder(Tree root) {
	if (root == NULL)
		return;
	inorder(root->left);
	printf("%d ", root->value);
	inorder(root->right);
}

void preorder(Tree root) {
	if (root == NULL)
		return;
	printf("%d ", root->value);
	preorder(root->left);
	preorder(root->right);
}

void postorder(Tree root) {
	if (root == NULL)
		return;
	postorder(root->left);
	postorder(root->right);
	printf("%d ", root->value);
}

Tree freeTree(Tree root) {
	if (root == NULL)
		return root;
	root->left = freeTree(root->left);
	root->right = freeTree(root->right);
	free(root);
	return NULL;
}