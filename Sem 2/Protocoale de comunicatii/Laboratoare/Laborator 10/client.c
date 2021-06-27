#include <stdio.h>      /* printf, sprintf */
#include <stdlib.h>     /* exit, atoi, malloc, free */
#include <unistd.h>     /* read, write, close */
#include <string.h>     /* memcpy, memset */
#include <sys/socket.h> /* socket, connect */
#include <netinet/in.h> /* struct sockaddr_in, struct sockaddr */
#include <netdb.h>      /* struct hostent, gethostbyname */
#include <arpa/inet.h>
#include "helpers.h"
#include "requests.h"

int main(int argc, char *argv[])
{
	char *data[2];
	char *login;
    char *message;
    char *response;
    char *cookies[1];
    int sockfd;

    sockfd = open_connection("34.118.48.238", 8080, AF_INET, SOCK_STREAM, 0);
    if(sockfd < 0){
    	error("Socket not available. It has other missions to accomplish.");
    }   
    

    // Ex 1: GET dummy from main server
    message = compute_get_request("34.118.48.238", "/api/v1/dummy", NULL, NULL, 0);
    
    send_to_server(sockfd, message);
    response = receive_from_server(sockfd);

    printf("______________ Dummy GET ______________\n");
    printf("%s\n\n", response);

    
    // Ex 2: POST dummy and print response from main server
   	data[0] = strdup("data=chestie");
   	data[1] = strdup("other=altachestie");
   	message = compute_post_request("34.118.48.238:8080", "/api/v1/dummy", "application/x-www-form-urlencoded",data, 2, NULL, 0);
    
   	send_to_server(sockfd, message);
    response = receive_from_server(sockfd);

    printf("______________ POST dummy ______________\n");
    printf("%s\n\n", response);

    
    // Ex 3: Login into main server
    data[0] = strdup("username=student");
    data[1] = strdup("password=student");
    login = strdup("connect.sid=s%3Amwle94O33a33NhPZWbqu7M_6HQ2xQqGO.1OlIA9zO6MHrzPzG%2BopdRw72B9%2BXZTPLzbGDB7Jnz4E");
    cookies[0] = login;

    message = compute_post_request("34.118.48.238:8080", "/api/v1/auth/login", "application/x-www-form-urlencoded", data, 2, cookies, 1);
    
    send_to_server(sockfd, message);
    response = receive_from_server(sockfd);

    printf("______________ POST login ______________\n");
    printf("%s\n\n",response );
    
    
    // Ex 4: GET weather key from main server
    
    cookies[0] = login;
    message = compute_get_request("34.118.48.238:8080", "/api/v1/weather/key", NULL, cookies, 1);
    
    send_to_server(sockfd, message);
    response = receive_from_server(sockfd);
    
    printf("______________ GET weather key ______________\n");
    printf("%s\n\n",response );


    // Ex 5: GET logout

    message = compute_get_request("34.118.48.238:8080", "/api/v1/auth/logout", NULL, NULL, 0);
    
    send_to_server(sockfd, message);
    response = receive_from_server(sockfd);
    
    printf("______________ GET logout ______________\n");
    printf("%s\n\n",response );


    // BONUS 1: make the main server return "Already logged in!"

    data[0] = strdup("username=student");
    data[1] = strdup("password=student");
    login = strdup("connect.sid=connect.sid=s%3Amwle94O33a33NhPZWbqu7M_6HQ2xQqGO.1OlIA9zO6MHrzPzG%2BopdRw72B9%2BXZTPLzbGDB7Jnz4E");
    cookies[0] = login;

    message = compute_post_request("34.118.48.238:8080", "/api/v1/auth/login", "application/x-www-form-urlencoded",data, 2, cookies, 1);
    
    send_to_server(sockfd, message);
    response = receive_from_server(sockfd);

    printf("______________ POST login ______________\n");
    printf("%s\n\n",response );

    // Imi afiseaza mie "Already logged in", dar la primul login, nu stiu de ce...

    // BONUS 2: POST weather data for verification to main server

    int weather_sock = open_connection("37.139.1.159", 80, AF_INET, SOCK_STREAM, 0);
    char* query_params = strdup("q=Ramnicu Valcea&appid=b912dd495585fbf756dc6d8f415a7649");

    message = compute_get_request("api.openweathermap.org:80", "/data/2.5/weather",query_params, NULL, 0);
    
    send_to_server(weather_sock, message);
    response = receive_from_server(weather_sock);
    
    printf("______________ GET weather ______________\n");
    printf("%s\n\n",basic_extract_json_response(response) );


    // Ex 6: Logout from main server
    message = compute_get_request("34.118.48.238:8080", "/api/v1/auth/logout", NULL, NULL, 0);
    
    send_to_server(sockfd, message);

    // free the allocated data at the end!
    close_connection(sockfd);
    free(message);
    free(response);

    return 0;
}
