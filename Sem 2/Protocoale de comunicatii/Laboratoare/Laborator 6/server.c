/*
*  	Protocoale de comunicatii: 
*  	Laborator 6: UDP
*	mini-server de backup fisiere
*/

#include <fcntl.h>
#include <netinet/in.h>
#include <netdb.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/socket.h>
#include <string.h>
#include <unistd.h>
#include <string.h>
#include <arpa/inet.h>
#include "helpers.h"


void usage(char*file)
{
	fprintf(stderr,"Usage: %s server_port file\n",file);
	exit(0);
}

/*
*	Utilizare: ./server server_port nume_fisier
*/
int main(int argc,char**argv)
{
	if (argc!=3){
		usage(argv[0]);
	}

	int fd, check, sockfd;	
	struct sockaddr_in my_sockaddr, from_station ;
	char buf[BUFLEN];

	/*Deschidere socket*/
	sockfd = socket(PF_INET, SOCK_DGRAM, 0);
	DIE(sockfd == -1, "No socket for you!\n");

	/*Setare struct sockaddr_in pentru a asculta pe portul respectiv */
	my_sockaddr.sin_family = AF_INET;
	my_sockaddr.sin_port = htons(atoi(argv[1]));
	inet_aton("127.0.0.1", &(my_sockaddr.sin_addr));

	/* Legare proprietati de socket */
	check = bind(sockfd, (struct sockaddr*)(&my_sockaddr), sizeof(my_sockaddr));
	DIE(check < 0, "No binding for you! >:)");

	/* Deschidere fisier pentru scriere */
	DIE((fd=open(argv[2],O_WRONLY|O_CREAT|O_TRUNC,0644))==-1,"open file");

	/*
	*  cat_timp  mai_pot_citi
	*		citeste din socket
	*		pune in fisier
	*/
	while(1){
		unsigned int addrlen = sizeof(struct sockaddr_in); 
		check = recvfrom(sockfd, buf, sizeof(buf), 0, (struct sockaddr*)&from_station, (socklen_t*)&addrlen);
		DIE(check < 0, "Not opening the file, server too lazy..");

		if(strstr(buf, "| STOP |") != NULL){
			break;
		}

		check = write(fd , buf, strlen(buf));
		DIE(check < 0, "No writings, here.");
	}

	/*Inchidere socket*/	
	close(sockfd);
	
	/*Inchidere fisier*/
	close(fd);
	return 0;
}
