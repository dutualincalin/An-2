#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
 
void fatal(char * mesaj_eroare){

    perror(mesaj_eroare);
    exit(0);
}

int main(int argc, char *argv[]){

    int fd, i, size;
    int descriptor;
    char buf[1024];
    char *file;

    fd = open(argv[1], O_RDONLY);
 
    if (fd < 0){
    	fatal("Fisierul nu exista sau nu se poate deschide");
    }

    while (descriptor = read(fd, buf, sizeof(buf))) {
    	if (descriptor < 0){
    	    fatal("Eroare la citire");
        }
    }

    for(i = 0; i < sizeof(buf); i++){
        if(buf[i] == '\0'){
            size = i;
            break;
        }
    }

    for(i = size - 2; i >= 0 ; i--){
    	printf("%c", buf[i]);
    }

    printf("\n");

    close(fd);
    return 0;
}