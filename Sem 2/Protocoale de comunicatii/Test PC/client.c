#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/tcp.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include "helpers.h"

#define ADDRESS "127.0.0.1"
#define PORT 12345

int main(int argc, char *argv[]){
	DIE(argc < 4, "Not enough arguments");

	char buffer[BUFLEN], *token;
	int i,sockfd, fdmax, check;
	struct sockaddr_in server_addr;
	Client_cmd client_cmd;
	client_cmd.ind = -1;

	sockfd = socket(AF_INET, SOCK_STREAM, 0);
	DIE(sockfd < 0,"Sock ded!");

	server_addr.sin_family = AF_INET;
	server_addr.sin_port = htons(atoi(argv[2]));
	inet_aton(argv[1], &server_addr.sin_addr);

	check = connect(sockfd, (struct sockaddr*) &server_addr, sizeof(server_addr));
	DIE(check < 0, "No connection to server.");

	fd_set read_sockets;
	fd_set tmp_sockets;

	FD_SET(0, &read_sockets);
	FD_SET(sockfd, &read_sockets);
	fdmax = sockfd;

	while(1){
		tmp_sockets = read_sockets;

		check = select(fdmax + 1, &tmp_sockets, NULL, NULL, NULL);
		DIE(check < 0, "No selection has been made to this BITchhhhhh");

		for(i = 0; i < fdmax; i++){
			if(FD_ISSET(i, &tmp_sockets)){
				memset(buffer, 0, BUFLEN);
				
				if(i == 0){
	  				// se citeste de la tastatura
					fgets(buffer, BUFLEN - 1, stdin);

					if (strncmp(buffer, "exit", 4) == 0){
						close(sockfd);
						return 0;
					}

					token = strtok(buffer, " \n");
					if(token == NULL)
						continue;

					if(strcmp(token, "show") == 0){
						client_cmd.cmd = 3;
					}

					else{
						if(strcmp(token, "delete") == 0){
							client_cmd.cmd = 2;

							token = strtok(NULL, " \n");

							if(token == NULL)
								continue;

							client_cmd.ind = atoi(token);
						}

						else{
							client_cmd.cmd = 1;

							token = strtok(NULL, "\0");
							strcpy(client_cmd.descriere, token);
						}
					}

					strcpy(client_cmd.nume, argv[3]);
					check = send(sockfd, &client_cmd, sizeof(client_cmd), 0);
					DIE(check < 0, "Not sending");

					continue;
				}

				check = recv(sockfd, &buffer, BUFLEN, 0);
				DIE(check < 0, "No updates :)");

				if (strncmp(buffer, "exit", 4) == 0){
					close(sockfd);
					return 0;
				}

				printf("%s\n", buffer);
			}
		}
	}
}