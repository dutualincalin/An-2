/*
*   Created by Nan Mihai on 05.03.2020
*   Copyright (c) 2020 Nan Mihai. All rights reserved.
*   Laborator 3 - Proiectarea algoritmilor (Greedy)
*   Facultatea de Automatica si Calculatoare
*   Anul Universitar 2019-2020, Seria CD
*/
#include "huffman.h"

void drawHuffmanAux(TreeNode huffman, FILE* stream) {
    static int nullcount = 0;

    if (huffman->left == NULL && huffman->right == NULL) {
        fprintf(stream, "%d [fillcolor=yellow]\n", huffman->idx);
    }

    if (huffman->left) {
    	if (huffman->value == '0') {
    		if (huffman->left->value == '0') {
    			fprintf(stream, "    %d -> %d [label=\"0\", color=green] \n %d [label = \" \", fillcolor=blue] \n %d[label = \" \", fillcolor=blue];\n",
    				huffman->idx, huffman->left->idx, huffman->idx, huffman->left->idx);
    		} else {
    			fprintf(stream, "    %d -> %d [label=\"0\", color=green] \n %d [label = \" \", fillcolor=blue] \n %d[label = \"%c\"];\n",
    				huffman->idx, huffman->left->idx, huffman->idx, huffman->left->idx, huffman->left->value);
    		}
    	} else {
    		if (huffman->left->value == '0') {
    			fprintf(stream, "    %d -> %d [label=\"0\", color=green]  \n %d [label = \"%c\"] \n %d[label = \"\", fillcolor=blue];\n",
    				huffman->idx, huffman->left->idx, huffman->idx, huffman->value, huffman->left->idx);
    		} else {
    			fprintf(stream, "    %d -> %d [label=\"0\", color=green]  \n %d [label = \"%c\"] \n %d[label = \"%c\"];\n",
    				huffman->idx, huffman->left->idx, huffman->idx, huffman->value, huffman->left->idx, huffman->left->value);
    		}
    	}
        
        drawHuffmanAux(huffman->left, stream);
    }
    if (huffman->right) {
        if (huffman->value == '0') {
    		if (huffman->right->value == '0') {
    			fprintf(stream, "    %d -> %d [label=\"1\", color=purple] \n %d [label = \" \", fillcolor=blue] \n %d[label = \" \", fillcolor=blue];\n",
    				huffman->idx, huffman->right->idx, huffman->idx, huffman->right->idx);
    		} else {
    			fprintf(stream, "    %d -> %d [label=\"1\", color=purple] \n %d [label = \" \", fillcolor=blue] \n %d[label = \"%c\"];\n",
    				huffman->idx, huffman->right->idx, huffman->idx, huffman->right->idx, huffman->right->value);
    		}
    	} else {
    		if (huffman->right->value == '0') {
    			fprintf(stream, "    %d -> %d [label=\"1\", color=purple] \n %d [label = \"%c\"] \n %d[label = \"\", fillcolor=blue];\n",
    				huffman->idx, huffman->right->idx, huffman->idx, huffman->value, huffman->right->idx);
    		} else {
    			fprintf(stream, "    %d -> %d [label=\"1\", color=purple] \n %d [label = \"%c\"] \n %d[label = \"%c\"];\n",
    				huffman->idx, huffman->right->idx, huffman->idx, huffman->value, huffman->right->idx, huffman->right->value);
    		}
    	}
        drawHuffmanAux(huffman->right, stream);
    }
}

void drawHuffman(TreeNode huffman, char *fileName) {
	FILE* stream = fopen("test.dot", "w");
	char buffer[SIZE];
    fprintf(stream, "digraph HEAP {\n");
    fprintf(stream, "    node [fontname=\"Arial\", shape=circle, style=filled, fillcolor=blue];\n");
    if (!huffman)
        fprintf(stream, "\n");
    else if (huffman->left == NULL && huffman->right == NULL)
        fprintf(stream, "    %d;\n", huffman->idx);
    else
        drawHuffmanAux(huffman, stream);
    fprintf(stream, "}\n");
    fclose(stream);
    sprintf(buffer, "dot test.dot | neato -n -Tpng -o %s", fileName);
    system(buffer);
}

int main() {
	TreeNode huffman = createHuffmanTree("ana_are_mere");
	drawHuffman(huffman, "huffman1.png");
	huffman = freeTree(huffman);
	huffman = createHuffmanTree("ala_bala_portocala");
	drawHuffman(huffman, "huffman2.png");
	huffman = freeTree(huffman);
	huffman = createHuffmanTree("this_is_an_example_of_a_huffman_tree");
	drawHuffman(huffman, "huffman3.png");
	huffman = freeTree(huffman);
	huffman = createHuffmanTree("aaaaaabbbbcccddef");
	drawHuffman(huffman, "huffman4.png");
	huffman = freeTree(huffman);
	return 0;
}
