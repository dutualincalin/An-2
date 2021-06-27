#include <stdio.h>

void main(void)
{
	int v[] = {4, 1, 2, -17, 15, 22, 6, 2, 29};
	int max;
	int i;

	int dim = sizeof(v) / sizeof(int);

Pasul_2:
	i = 0;

Pasul_2_1:
	max = v[i];

Pasul_2_2:
	if(i == dim)
		goto Pasul_3;

	if(v[i] > max)
		goto Pasul_2_1;

	i++;
	goto Pasul_2_2;

Pasul_3:
	printf("Elementul maxim este: %d\n", max);
}
