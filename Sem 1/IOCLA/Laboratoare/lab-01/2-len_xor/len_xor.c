#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int my_strlen(const char *str)
{
	int i = 0;
	while(*(str+i) != '\0'){
		i++;
	}

	return i;
}

void equality_check(const char *str)
{
	int i,p2, length = my_strlen(str);

	for(i = 0; i < length; i++){
		p2 = 1<<(i);

		if(i + p2 >= length)
			p2 = (i+p2)%length;
		else p2 = p2 + i;

		if(*(str+i) != *(str+p2)){}
		else{
			printf("Adress of %c: %p\n",*(str+i),(str+i));
		}
		
	}

	return;
}

int main(void)
{
	char *string = malloc(50);
	scanf("%s",string);
	printf("Length: %d\n",my_strlen(string));
	equality_check(string);
	free(string);
	return 0;
}

