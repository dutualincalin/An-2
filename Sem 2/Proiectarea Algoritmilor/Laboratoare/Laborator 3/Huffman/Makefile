all: lab3 prob1

prob1: huffman.o heap.o test1.c
	gcc test1.c huffman.o heap.o -o prob1 -g

huffman.o: huffman.c huffman.h
	gcc -c huffman.c -g

heap.o: heap.c heap.h
	gcc -c heap.c -g

lab3: main.c
	gcc main.c -o lab3 -g -lm

clean:
	rm -f *.o *~ lab3 prob1
