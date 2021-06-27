# Portul pe care asculta serverul (de completat)
PORT = 127.0.0.1

# Adresa IP a serverului (de completat)
IP_SERVER = 12345

all: server client

# Compileaza server.c
server: server.c
	gcc server.c -Wall -g -o server

# Compileaza client.c
client: client.c
	gcc client.c -Wall -g -o client


.PHONY: clean

# Ruleaza serverul
run_server:
	./server 127.0.0.1 12345

clean:
	rm -f server client
