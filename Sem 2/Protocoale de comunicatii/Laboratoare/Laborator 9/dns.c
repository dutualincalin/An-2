// Protocoale de comunicatii
// Laborator 9 - DNS
// dns.c

#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <string.h>
#include <sys/socket.h>
#include <netdb.h>
#include <arpa/inet.h>

int usage(char* name)
{
	printf("Usage:\n\t%s -n <NAME>\n\t%s -a <IP>\n", name, name);
	return 1;
}

// Receives a name and prints IP addresses
void get_ip(char* name)
{
	int ret;
	struct addrinfo hints, *result, *p;
	char *dst = malloc(32 * sizeof(char));

	// TODO: set hints
	hints.ai_flags = 0;
	hints.ai_family = AF_INET;
	hints.ai_socktype = SOCK_DGRAM;   //se verificat
	hints.ai_protocol = IPPROTO_UDP;
	hints.ai_addrlen = 0;
	hints.ai_addr = NULL;
	hints.ai_canonname = NULL;
	hints.ai_next = NULL;


	// TODO: get addresses
	ret = getaddrinfo(name, NULL, &hints, &result);

	if(ret != 0){
		gai_strerror(ret);
	}

	// TODO: iterate through addresses and print them
	p = result;

	while(p != NULL){
		if(p->ai_addr == NULL){
			break;
		}

		printf("%s\n", inet_ntop(AF_INET, &(((struct sockaddr_in *)(p -> ai_addr))->sin_addr), dst, 32));
		p = p->ai_next;
	}

	// TODO: free allocated data
	freeaddrinfo(result);
}

// Receives an address and prints the associated name and service
void get_name(char* ip)
{
	int ret;
	struct sockaddr_in addr;
	char host[1024];
	char service[20];

	// TODO: fill in address data
	ret = inet_aton(ip, &(addr.sin_addr));
	addr.sin_family = AF_INET;
	addr.sin_port = htons(53);

	// TODO: get name and service
	ret = getnameinfo((struct sockaddr *) (&addr), sizeof(struct sockaddr), host, 1024, service, 20, 0);

	if(ret != 0){
		gai_strerror(ret);
	}

	// TODO: print name and service
	printf("Name: %s\nService: %s\n", host, service);
}

int main(int argc, char **argv)
{
	if (argc < 3) {
		return usage(argv[0]);
	}

	if (strncmp(argv[1], "-n", 2) == 0) {
		get_ip(argv[2]);
	} else if (strncmp(argv[1], "-a", 2) == 0) {
		get_name(argv[2]);
	} else {
		return usage(argv[0]);
	}

	return 0;
}
