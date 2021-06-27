#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include "link_emulator/lib.h"

#define HOST "127.0.0.1"
#define PORT 10001


int main(int argc,char** argv){
    msg r;
    init(HOST,PORT);
    int fd, descriptor;
    mode_t mode = S_IRWXU | S_IRWXG;

    fd = open("Text_File_Trasmission.txt", O_CREAT | O_WRONLY | O_TRUNC, mode);

    while(1){
        if (recv_message(&r) < 0){
            perror("[RECEIVER] - Message got lost, send help!\n");
            return -1;
        }

        printf("[RECEIVER] - Received payload: <%s>, Sending Ackonwledgement\n", r.payload);

        if (strncmp(r.payload, "SSSTOPP", 7) == 0){
            break;
        }

        else {
            int i;

            for(i = 0; i < r.len - 2; i++){
                if(r.payload[i] == '\n'){
                  break;
                }
            }

            if(i < r.len - 2){
                char aux[9];
                strcpy(aux, r.payload);
                strncpy(r.payload, aux, i);
                r.len = i + 2;
            }

            descriptor = write(fd, r.payload, r.len - 2);

            if(descriptor < 0){
                perror("[RECEIVER] - Huston, we have a problem! Message couldn't be written.\n");
                return -1;
            }
        }

        sprintf(r.payload,"%s", "ACK");
        r.len = strlen(r.payload) + 1;
        send_message(&r);
        printf("[RECEIVER] - ACK sent\n");
    }

    close(fd);
    return 0;
}
