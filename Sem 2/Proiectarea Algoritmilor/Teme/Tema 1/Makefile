# Darius-Florentin Neatu <neatudarius@gmail.com>

# Exemplu de Makefile pentru tema

# tag-uri obligatorii (nume + comportament identic)
# build    => compileaza toata tema
#             (ATENTIE! E important - NU compilati in tag-urile de run. Sesizati?)
# run-p$ID => ruleaza problema cu ID-ul specificat (1, 2, 3, 4)
# clean    => sterge toate fisierele generate

# restul este la alegerea studentului
# TODO

# nume necesar (build)
build: crypto stocks valley ridge trigigel

crypto: crypto.cpp
	g++ crypto.cpp -o crypto

stocks: stocks.cpp
	g++ stocks.cpp -o stocks

valley: valley.cpp
	g++ valley.cpp -o valley

ridge: ridge.cpp
	g++ ridge.cpp -g -o ridge

trigigel: trigigel.cpp
	g++ trigigel.cpp -g -o trigigel

run-p1:
	./crypto

run-p2:
	./stocks

run-p3:
	./valley

run-p4:
	./ridge

run-p5:
	./trigigel

clean:
	rm -f crypto stocks valley ridge trigigel
