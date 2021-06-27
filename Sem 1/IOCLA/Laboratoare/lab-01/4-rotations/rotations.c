#include <stdio.h>
#include <stdlib.h>

void rotate_left(int *number, int bits)
{
	int n = (*(number) << bits)|(*(number) >> (32 - bits));
	printf("%d\n",abs(n));

}

void rotate_right(int *number, int bits)
{
	int n = abs(*number >> bits)|(*number << (32 - bits));
	printf("%d\n",n);
}

int main()
{
	int number ,bits;
	scanf("%x %d",&number,&bits);
	rotate_left(&number, bits);
	rotate_right(&number,bits);
	return 0;
}