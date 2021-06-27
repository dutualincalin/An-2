#include <iostream>
#include <fstream>
#include <vector>

#define MAX 1e16
#define MAXDOWN 3

using namespace std;

typedef struct {
	long long height;
	long long cost;
} mountain;

int main() {
	ifstream f("ridge.in");
	ofstream o("ridge.out");

	long min_cost;
	int n, i, j;

	f >> n;

	vector<mountain> mountains(n);
	vector<vector<long>> dp(n, vector<long>(3, MAX));

	for(i = 0; i < n; i++) {
		f >> mountains[i].height >> mountains[i].cost;
	}

	f.close();

	dp[0][0] = 0;
	dp[0][1] = mountains[0].cost;
	dp[0][2] = mountains[0].cost * 2;

	for(i = 1; i < mountains.size(); i++) {
		for(j = 0; j < MAXDOWN; j++) {
			min_cost = MAX;

			if(mountains[i].height - j >= 0) {
				if(mountains[i].height - j != mountains[i - 1].height) {
					if(min_cost > dp[i - 1][0]) {
						min_cost = dp[i - 1][0];
					}
				}

				if(mountains[i].height - j != mountains[i - 1].height - 1) {
					if(min_cost > dp[i - 1][1]) {
						min_cost = dp[i - 1][1];
					}
				}

				if(mountains[i].height - j != mountains[i - 1].height - 2) {
					if(min_cost > dp[i - 1][2]) {
						min_cost = dp[i - 1][2];
					}
				}
			}

			dp[i][j] = j * mountains[i].cost + min_cost;
		}
	}

	min_cost = MAX;

	for(i = 0; i < MAXDOWN; i++) {
		if(min_cost > dp[n - 1][i]) {
			min_cost = dp[n - 1][i];
		}
	}

	o << min_cost;
	o.close();
	return 0;
}
