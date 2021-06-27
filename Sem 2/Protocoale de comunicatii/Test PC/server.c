#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <arpa/inet.h>
#include "helpers.h"

void add_item(Item_list *item_list, char nume[], char descriere[]){
	Item *new_item = malloc(sizeof(Item));
	strcpy(new_item->nume, nume);
	strcpy(new_item->descriere, descriere);
	new_item->next = NULL;

	if(item_list->items == NULL){
		item_list->items = new_item;
		item_list->no_elems++;
		return;
	}

	Item *aux;
	aux = item_list->items;

	while(aux->next != NULL){
		aux = aux->next;
	}

	aux->next = new_item;
	item_list->no_elems++;
}

int delete_item(Item_list *item_list, int ind){
	if(ind > item_list->no_elems){
		return 0;
	}

	Item *aux, *next_node, *node;
	aux = item_list->items;

	if(ind == 1){
		item_list->items = aux->next;
		free(aux);
		return 1;
	}

	for(int i = 0; i < ind - 2; i++){
		aux = aux->next;
	}

	if(aux->next->next == NULL){
		next_node = aux->next;
		free(next_node);
		aux->next = NULL;
		return 1;
	}

	next_node = aux->next->next;
	node = aux->next;
	aux->next = next_node;
	free(node);
	return 1;
}

int send_list_to(int socket, Item_list *item_list){
	char buffer[BUFLEN];
	int check;
	Item *aux;
	
	aux = item_list->items;

	while(aux != NULL){
		sprintf(buffer, "%s%s\\%s\n", buffer, aux->nume, aux->descriere);
		aux = aux->next;
	}

	check = send(socket, &buffer, sizeof(buffer), 0);
	if(check < 0){
		return -1;
	}

	return 1;
}

int main(int argc, char *argv[]){
	DIE(argc < 2, "Not enough arguments!");

	char buffer[BUFLEN];
	int i, j, sockfd, maxsock, client_sock, check;
	struct sockaddr_in server_addr, client_addr;
	
	Client_cmd client_cmd;
	Item_list *item_list = malloc(sizeof(Item_list));
	item_list->no_elems = 0;

	sockfd = socket(AF_INET, SOCK_STREAM, 0);
	DIE(sockfd < 0, "Sock ded!");

	server_addr.sin_family = AF_INET;
	server_addr.sin_port = htons(atoi(argv[1]));
	server_addr.sin_addr.s_addr = INADDR_ANY;

	check = bind(sockfd, (struct sockaddr*)&server_addr, sizeof(struct sockaddr));
	DIE(check < 0, "Bind failed!");
	check = listen(sockfd, 100);
	DIE(check < 0, "Deaf socket!");
	fd_set read_sockets;
	fd_set tmp_sockets;

	FD_ZERO(&read_sockets);
	FD_ZERO(&tmp_sockets);

	FD_SET(0, &read_sockets);
	FD_SET(sockfd, &read_sockets);
	
	maxsock = sockfd ;


	while(1){
		tmp_sockets = read_sockets;
		check = select(maxsock + 1, &tmp_sockets, NULL, NULL, NULL);
		DIE(check < 0, "Failed select!");

		for(i = 0; i <= maxsock; i++){

			if(FD_ISSET(i, &tmp_sockets)){
				memset(buffer, 0, BUFLEN);
			
				// STDIN
				if(i == 0){
					fgets(buffer, BUFLEN - 1, stdin);

					if (strncmp(buffer, "exit", 4) == 0){
						if(maxsock > 3){
							for(j = 1; j < maxsock; j++){
								check = send(j, &buffer, 5, 0);
								DIE(check < 0, "Not sending");
								close(i);
							}
						}

						close(sockfd);
						return 0;
					}

					continue;
				}

				// Noua conexiune
				if(i == sockfd){
					socklen_t client_len = sizeof(client_addr);

					client_sock = accept(sockfd, (struct sockaddr*) &client_addr, &client_len);
					DIE(client_sock < 0, "Client not connected!\n");
					
					printf("New client connected\n");
					if (client_sock > maxsock) { 
						maxsock = client_sock;
					}

					FD_SET(client_sock, &read_sockets);
					continue;
				}

				check = recv(i, &client_cmd, sizeof(client_cmd), 0);
				DIE(check < 0, "Receiver is not receiving what should be received.\n");
				
				printf("%d\n", client_cmd.cmd);

				if(client_cmd.cmd == 1){
					add_item(item_list, client_cmd.nume, client_cmd.descriere);
					continue;
				}
				
				if(client_cmd.cmd == 2){
					check = delete_item(item_list, client_cmd.ind);

					if(check == 0){
						strcpy(buffer, "Incorrect index");
						send(i, &buffer, sizeof(buffer), 0);
						DIE(check < 0, "Not sending");
					}

					continue;
				}
				
				if(client_cmd.cmd == 3){
					check = send_list_to(i, item_list);
					DIE(check < 0, "Shown command corrupted.");
					continue;
				}
			}
		}
	}

	close(sockfd);
	return 0;
}