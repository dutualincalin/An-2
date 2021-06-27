#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>

#include "lib.h"

#define HOST "127.0.0.1"
#define PORT 10000

int main(int argc, char *argv[])
{
	msg t;
	int i, j, res;
	int wso = atoi(argv[1]) / 1405;

	
	printf("[SENDER] - Starting.\n");	
	init(HOST, PORT);

	printf("[SENDER] - BDP=%d\n", atoi(argv[1]));

	//t.len = MSGSIZE + 50; - pentru bonus se decomenteaza aici si se comenteaza

    t.len = MSGSIZE;        // <------- aici

	for(i = 0; i < wso; i++){
		t.check_sum = 'c';

	//	for(j = 0; j < MSGSIZE - 1 + 50; j++){  - pentru bonus se decomenteaza aici si se comenteaza

        for(j = 0; j < MSGSIZE - 1; j++){       // <------- aici
			t.payload[j] = rand()%256;
			t.check_sum ^= t.payload[j];
		}

		t.payload[j] = t.check_sum;

		printf("[SENDER] - Sending Frame No. %d\n", i + 1);
		res = send_message(&t);

		if (res < 0) {
			perror("[SENDER] - Send error [Etapa 1] - Damn!\n");
			return -1;
		}
	}

	for (i = 0; i < COUNT - wso; i++) {

		res = recv_message(&t);
		
		if (res < 0) {
			perror("[SENDER] - Receive error [Etapa 2] - Rip!\n");
			return -1;
		}

		else{
			printf("[SENDER] - Receiver sent confirmation message %s succesfully! :D\n\n", t.payload);

            t.check_sum = 'c';

            for(j = 0; j < MSGSIZE - 1; j++){
                t.payload[j] = rand()%256;
                t.check_sum ^= t.payload[j];
            }

            t.payload[j] = t.check_sum;

            printf("[SENDER] - Sending Frame No. %d\n", wso + i + 1);
            res = send_message(&t);

            if (res < 0) {
               perror("[SENDER] - Send error [Etapa 2] - Fatality!\n");
               return -1;
            }
        }	
    }

	for(i = 0; i < wso; i++){

		res = recv_message(&t);

		if (res < 0) {
			perror("[SENDER] - Send error [Etapa 3] - Well, that was a great...game!\n");
			return -1;
		}

		printf("[SENDER] - Receiver sent confirmation message %s succesfully! :D\n\n", t.payload);
	}



	printf("[SENDER] - Job done, all sent. Hooray!\n");
		
	return 0;
}
