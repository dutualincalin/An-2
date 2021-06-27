#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>

#include "lib.h"

#define HOST "127.0.0.1"
#define PORT 10001

int main(void)
{
	msg r;
	int i, j, res;
	
	printf("[RECEIVER] Starting.\n");
	init(HOST, PORT);
	
	for (i = 0; i < COUNT; i++) {
		/* wait for message */
		res = recv_message(&r);

		if (res < 0) {
			perror("[RECEIVER] Receive error. This is sad...\n");
			return -1;
		}

		else{
			char checking_sum = 'c';

			for(j = 0; j < MSGSIZE - 1; j++){
				checking_sum ^= r.payload[j];
			}

			if(r.payload[j] != checking_sum){
				perror("[SENDER] - Received corrupt message [Etapa 2] - NOOOOOOOOOOOOOOO!\n");
				return -1;
			}

			else{
				printf("[RECEIVER] - Received Frame No. %d - Sending Acknowledgement\n", i + 1);  // the love to write "acknowledgement" :D
		
				/* send dummy ACK */
				sprintf(r.payload, "%s %d", "ACK", i + 1);
				res = send_message(&r);

				if (res < 0) {
					perror("[RECEIVER] Send ACK error. Feeling a bit depressed.\n");
					return -1;
				}
			}
		}
	}

	printf("[RECEIVER] Finished receiving..^-^\n");
	return 0;
}
