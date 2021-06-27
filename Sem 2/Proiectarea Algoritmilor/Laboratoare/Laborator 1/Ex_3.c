#include <stdio.h>

int power(int x, int n){
	if(n == 0){
		return 1;
	}

	int p;

	if(n % 2 == 0){
        p = power(x, n/2);
		return p * p;
	}

    p = power(x, (n - 1)/2);
	return (x * power(x, (n - 1)/2) * power(x, (n - 1)/2));
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
