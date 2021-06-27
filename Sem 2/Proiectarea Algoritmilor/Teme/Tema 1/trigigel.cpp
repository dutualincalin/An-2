#include <iostream>
#include <fstream>
#include <vector>
#include <cstring>

using namespace std;

#define MOD 1000000007
#define KMAX 4

void multiply_matrix(long long MAT1[KMAX][KMAX], long long MAT2[KMAX][KMAX],
					long long MAT3[KMAX][KMAX]) {
    long long tmp[KMAX][KMAX];
    long long i, j, sum, k;

    for (i = 0; i < KMAX; ++i) {
		for (j = 0; j < KMAX; ++j) {
			sum = 0;

			for (k = 0; k < KMAX; ++k) {
				sum += 1LL * MAT1[i][k] * MAT2[k][j];
			}

			if(sum < 0) {
				tmp[i][j] = (sum + MOD) % MOD;
			} else {
				tmp[i][j] = sum % MOD;
			}
		}
	}

	memcpy(MAT3, tmp, sizeof(tmp));
}

void power_matrix(long long MAT[KMAX][KMAX], long long p,
				long long R[KMAX][KMAX]) {
	long long tmp[KMAX][KMAX];
	long long i, j;

	for (i = 0; i < KMAX; ++i) {
		for (j = 0; j < KMAX; ++j) {
			if(i == j) {
				tmp[i][j] = 1;
			} else {
				tmp[i][j] = 0;
			}
		}
	}

	while (p != 1) {
		if  (p % 2 == 0) {
			multiply_matrix(MAT, MAT, MAT);
			p /= 2;
		} else {
			multiply_matrix(tmp, MAT, tmp);
			--p;
		}
	}

	multiply_matrix(MAT, tmp, R);
}

long long faaaast_solution(long long n) {
	long sol;

	if (n == 1) return 1;
	if (n == 2) return 3;
	if (n == 3) return 6;
	if (n == 4) return 10;

	long long C[KMAX][KMAX] = {{0, 0, 0, -1},
	{1, 0, 0, 1}, {0, 1, 0, -1}, {0, 0, 1, 2}};

	power_matrix(C, n - 4, C);

	sol = (((1LL * C[0][3] + 1LL * 3 * C[1][3]) % MOD
			+ 1LL * 6 * C[2][3]) % MOD + 1LL * 10 * C[3][3]) % MOD;

	return sol % MOD;
}

int main() {
	ifstream f("trigigel.in");
	ofstream o("trigigel.out");

	long long i, j, n;

	f >> n;
	f.close();

	o << faaaast_solution(n);
	o.close();
	return 0;
}
