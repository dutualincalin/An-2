/*
*  	Protocoale de comunicatii: 
*  	Laborator 6: UDP
*	client mini-server de backup fisiere
*/

#include <fcntl.h>
#include <netinet/in.h>
#include <netdb.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/socket.h>
#include <unistd.h>
#include <string.h>
#include <arpa/inet.h>
#include "helpers.h"

void usage(char*file)
{
	fprintf(stderr,"Usage: %s ip_server port_server file\n",file);
	exit(0);
}

/*
*	Utilizare: ./client ip_server port_server nume_fisier_trimis
*/
int main(int argc,char**argv)
{
	if (argc!=4){
		usage(argv[0]);
	}
	
	int fd, check;
	struct sockaddr_in to_station;
	char buf[BUFLEN];

	/*Deschidere socket*/
	int sockfd = socket(PF_INET, SOCK_DGRAM, 0);
	
	if(sockfd == -1){
		printf("No socket for you!\n");
	}

	/* Deschidere fisier pentru citire */
	DIE((fd=open(argv[3],O_RDONLY))==-1,"open file");
	
	/*Setare struct sockaddr_in pentru a specifica unde trimit datele*/
	to_station.sin_family = AF_INET;
	to_station.sin_port = htons(atoi(argv[2]));
	inet_aton(argv[1], &(to_station.sin_addr));

	/*
	*  cat_timp  mai_pot_citi
	*		citeste din fisier
	*		trimite pe socket
	*/
	while((check = read(fd, buf, BUFLEN))){
		DIE(check < 0, "You can't just read that, do ya?\n");

		check = sendto(sockfd, buf, strlen(buf), 0, (struct sockaddr *)&to_station, sizeof(to_station));
		DIE(check == -1,"It just won't send...\n");
	}

	sprintf(buf,"%s", "| STOP |");
	check = sendto(sockfd, buf, strlen(buf), 0, (struct sockaddr*)&to_station, sizeof(to_station));
	DIE(check == -1, "Make it stop...it just won't stop, maan.!\n");
	/*Inchidere socket*/
	close(sockfd);

	/*Inchidere fisier*/
	close(fd);
	return 0;
}
