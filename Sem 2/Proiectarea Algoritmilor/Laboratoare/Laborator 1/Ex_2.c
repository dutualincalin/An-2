#include <stdio.h>

int power(int x, int n){
	if(n == 1){
		return x;
	}

	return x * power(x, n - 1);
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