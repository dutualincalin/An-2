CC = gcc
CFLAGS = -Wall -g -O0

.PHONY: all clean run build

all: build run

build: $(wildcard *.c)
	@$(CC) $(CFLAGS) -fPIC -shared $^ -o libprint.so

run:
	@python3 checker.py

clean:
	@rm -rf libprint.so output
