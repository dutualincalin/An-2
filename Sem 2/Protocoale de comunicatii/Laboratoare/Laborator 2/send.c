#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include "link_emulator/lib.h"

#define HOST "127.0.0.1"
#define PORT 10000


int main(int argc,char** argv){
    init(HOST,PORT);
    msg t;
    int count = 48;
    int fd, descriptor;

    fd = open("Text_File.txt", O_RDONLY);

    if(fd < 0){
        perror("[SENDER] - Fisierul nu exista sau nu poate fi deschis\n");
        return -1;
    }

    // Sending message
    printf("[SENDER] - Startin Sendin message\n");
    
    while (descriptor = read(fd, t.payload, 7)){
        t.payload[7] = count;
        t.payload[8] = '\0';

        if(count == 48){
          count++;
        }

        else count --;

        t.len = strlen(t.payload) + 1;
        send_message(&t);
  
    // Checking response:
        if (recv_message(&t)<0){
            perror("[SENDER] - Received error :O\n");
            return -1;
        }

        printf("[SENDER] - Received response: <%s>\n", t.payload);
    }

    sprintf(t.payload,"%s", "SSSTOPP");
    t.payload[7] = 48;
    send_message(&t);

    close(fd);
    return 0;
}
