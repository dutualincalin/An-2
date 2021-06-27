#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char* delete_first(char *s, char *pattern){
	char *point = malloc(100* sizeof(char));
	char *copy = malloc(100* sizeof(char));

	strcpy(copy,s);

	point = strstr(copy,pattern);
	strcpy(point,point + strlen(pattern));

	return copy;
}

int main(){
	char *s = "Ana are mere";
	char *pattern = "re";

	printf("%s\n", delete_first(s, pattern));

	return 0;
}
