#include <stdio.h>

int power(int x, int n){
	int i, pow = 1;

	for(i = 0; i < n; i++){
		pow *= x;
	}

	return pow;
}

int main(){
	int x, n;

	printf("x = ");
	scanf("%d", &x);
	printf("n = ");
	scanf("%d", &n);
	printf("Rezultatul este %d\n", power(x, n));

	return 0;
}