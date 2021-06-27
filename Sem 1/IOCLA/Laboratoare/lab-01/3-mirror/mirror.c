#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void mirror(char *s)
{
	int length = strlen(s) - 1;
	char *sf = malloc(50);
	int i;

	for(i = 0; i <= length; i++)
		*(sf + i) = *(s + length - i);

	printf("%s\n",sf);
	return;
}

int main()
{
	char *string = malloc(50);
	scanf("%s",string);
	mirror(string);
	free(string);

	return 0;
}

