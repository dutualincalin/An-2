#include <stdio.h>
#include <stdlib.h>

void print_binary(int number, int nr_bits)
{
	int *number2 = calloc(nr_bits,sizeof(int));
	int i = 0;

	while(number != 0){
		*(number2+i) = number%2;
		number = number/2;
		i++;
	}

	printf("0b");
	
	for(i = 0; i < nr_bits; i++)
		printf("%d",*(number2 + nr_bits - i - 1));
	printf("\n");

	free(number2);
}

void check_parity(int *numbers, int n)
{
	int i;
	for(i = 0; i < n; i++){
		if(*(numbers + i)%2 == 0){
			print_binary(*(numbers+i),8);
		}
		else printf("0x%08x\n",*(numbers+i));
	}
}

int main()
{
	int i,n;

	scanf("%d",&n);
	int *v = malloc(n*sizeof(int));

	for(i = 0; i < n; i++)
		scanf("%d",&v[i]);

	check_parity(v,n);

	free(v);

	return 0;
}

