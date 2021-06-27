#include <stdio.h>
#include <stdlib.h>

int main(){
	int n, i;
	int* v = malloc(500 * sizeof(int));

	v[0] = 0;
	v[1] = 1;

	printf("n = ");
	scanf("%d", &n);

	for(i = 2; i <= n; i++){
		v[i] = v[i - 1] + v[i - 2];
	}

	printf("Rezultatul este %d\n", v[n]);

	free(v);
	return 0;
}
