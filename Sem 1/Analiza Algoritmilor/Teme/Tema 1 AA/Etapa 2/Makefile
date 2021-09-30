all: build

build: algo_test algo_program1 algo_program2

algo.o: algo.cpp
	@g++ algo.cpp -c -Wall -Wextra -O2

algo_test: algo_test.cpp algo.o
	@g++ algo_test.cpp algo.o -g -Wall -std=c++11 -o algo_test

algo_program1: algo_program1.cpp algo.o
	@g++ algo_program1.cpp algo.o -g -Wall -std=c++11 -o algo_program1

algo_program2: algo_program2.cpp algo.o
	@g++ algo_program2.cpp algo.o -g -Wall -std=c++11 -o algo_program2

run: run_tests run_program1 run_program2

run_tests:
	@./algo_test

run_program1:
	@./algo_program1

run_program2:
	@./algo_program2

.PHONY: clean
clean:
	@rm -f algo.o
	@rm -f algo_test
	@rm -f algo_program1
	@rm -f algo_program2
