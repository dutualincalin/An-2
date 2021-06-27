#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm>

using namespace std;

typedef struct {
	int cost;
	int min_value;			// structura pentru o actiune
	int max_value;
} stock;

int main() {
	ifstream f("stocks.in");
	ofstream o("stocks.out");

	int i, j, k, n, bani, max_loss, win, lose;

	// Citirea numarului de actiuni, a sumei de bani
	// disponibile si a maximului admis de pierderi;
	f >> n >> bani >> max_loss;

	vector <stock> stonks(n + 1);		// Stonks =))

	// Citirea datelor actiunilor
	for(i = 0; i < n ; i++) {
		f >> stonks[i + 1].cost >> stonks[i + 1].min_value >> stonks[i + 1].max_value;
	}

	f.close();

	// Declararea matricei 3d dp;
	vector<vector<vector<int>>> dp(n + 1
		, vector<vector<int>>(bani + 1, vector<int>(max_loss + 1, 0)));

	for(i = 0; i <= n; i++) {
		for(j = 0; j <= bani; j++) {
			for(k = 0; k <= max_loss; k++) {
				// Initializarea matricei;
				if(i == 0 || j == 0 || k == 0) {
					continue;
				}

				// Stabilirea castigului si pierderii actiunii curente;
				win = stonks[i].max_value - stonks[i].cost;
				lose = stonks[i].cost - stonks[i].min_value;

				// Se stabileste solutia in prima faza cu cea precedenta;
				dp[i][j][k] = dp[i - 1][j][k];

				// Pana sa ajungem la costul actiunii sau cand actiunea
				// are pierderi prea mari se trece la urmatoarea iteratie;
				if(j < stonks[i].cost ||  lose > max_loss) {
					continue;
				}

				// Se face comparatie intre solutia precedenta
				// si actuala actiune;
				if(dp[i][j][k] < win && k == lose) {
					dp[i][j][k] = win;
				}

				// Se verifica daca actiunea actuala se poate cumula cu alta
				// din punctul de vedere al pierderilor si se adauga la solutie
				// daca acest caz este cel mai bun.
				if(k - lose >= 0 &&
				   dp[i][j][k] < dp[i-1][j - stonks[i].cost][k - lose] + win) {
					dp[i][j][k] = dp[i-1][j - stonks[i].cost][k - lose] + win;
				}
			}
		}
	}

	int max = 0;

	// Se preia solutia ca fiind maximul
	for(k = 0; k <= max_loss; k++) {
		if(max < dp[n][bani][k]) {
			max = dp[n][bani][k];
		}
	}

	// Se scrie solutia in output
	o << max;
	o.close();
	return 0;
}
