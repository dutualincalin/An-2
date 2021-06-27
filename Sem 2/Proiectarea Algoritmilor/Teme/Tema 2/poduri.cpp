#include <iostream>
#include <fstream>
#include <queue>

using namespace std;

#define MAX 2096

int main() {
	ifstream f("poduri.in");
	ofstream o("poduri.out");

	int i, j, n, m, sx, sy, l, c, dist = MAX;

	// citeste n si m impreuna cu coordonatele sursei
	f >> n >> m >> sx >> sy;

	// matricea de poduri(contine tipurile de poduri)
	vector<vector<char>> bridges(n + 2, vector<char>(m + 2, '+'));

	// matricea de distante
	vector<vector<int>> d(n + 2, vector<int> (m + 2, -1));

	// cozile pentru cooordonatele X respectiv Y
	queue<int> X, Y;

	// citirea de la input
	for(i = 1; i <= n; i++) {
		for(j = 1; j <= m; j++) {
			f >> bridges[i][j];
		}
	}

	// setarea nodului sursa
	d[sx][sy] = 0;
	X.push(sx);
	Y.push(sy);

	// cat timp ambele cozi nu sunt vide(e suficient sa verific una)
	while(!X.empty()) {
		// se scot coordonatele din cozi
		l = X.front();
		c = Y.front();

		// daca timpul podului e de tip orizontal
		if(bridges[l][c] == 'O') {
			// daca e la margine
			if((c == 1 || c == m) && d[l][c] + 1 < dist) {
				dist = d[l][c] + 1;
			}

			// verific vecinul de la stanga
			if(bridges[l][c - 1] != '.' && d[l][c - 1] == -1 && c - 1 != 0) {
				d[l][c - 1] = d[l][c] + 1;
				X.push(l);
				Y.push(c - 1);
			}

			// verific vecinul de la dreapta
			if(bridges[l][c + 1] != '.' && d[l][c + 1] == -1 && c + 1 != m + 1) {
				d[l][c + 1] = d[l][c] + 1;
				X.push(l);
				Y.push(c + 1);
			}
		}

		// daca timpul podului e de tip vertical
		if(bridges[l][c] == 'V') {
			// daca este la margine
			if((l == 1 || l == n) && d[l][c] + 1 < dist) {
				dist = d[l][c] + 1;
			}

			// verific vecinul de sus
			if(bridges[l - 1][c] != '.' && d[l - 1][c] == -1 && l - 1 != 0) {
				d[l - 1][c] = d[l][c] + 1;
				X.push(l - 1);
				Y.push(c);
			}

			// verific vecinul de jos
			if(bridges[l + 1][c] != '.' && d[l + 1][c] == -1 && l + 1 != n + 1) {
				d[l + 1][c] = d[l][c] + 1;
				X.push(l + 1);
				Y.push(c);
			}
		}

		// daca podul este de tip D
		if(bridges[l][c] == 'D') {
			// daca este la margine
			if((c == 1 || c == m || l == 1 || l == n) && d[l][c] + 1 < dist) {
				dist = d[l][c] + 1;
			}

			// vecinul din stanga
			if(bridges[l][c - 1] != '.' && d[l][c - 1] == -1 && c - 1 != 0) {
				d[l][c - 1] = d[l][c] + 1;
				X.push(l);
				Y.push(c - 1);
			}

			// vecinul din dreapta
			if(bridges[l][c + 1] != '.' && d[l][c + 1] == -1 && c + 1 != m + 1) {
				d[l][c + 1] = d[l][c] + 1;
				X.push(l);
				Y.push(c + 1);
			}

			// vecinul de sus
			if(bridges[l - 1][c] != '.' && d[l - 1][c] == -1 && l - 1 != 0) {
				d[l - 1][c] = d[l][c] + 1;
				X.push(l - 1);
				Y.push(c);
			}

			// vecinul de jos
			if(bridges[l + 1][c] != '.' && d[l + 1][c] == -1 && l + 1 != n + 1) {
				d[l + 1][c] = d[l][c] + 1;
				X.push(l + 1);
				Y.push(c);
			}
		}

		// se elimina nodul actual
		X.pop();
		Y.pop();
	}

	// se verifica daca s-au efectuat schimbari privind distantele
	// si se scrie in output rezultatul final
	if(dist == MAX) {
		o << -1;
	} else {
		o << dist;
	}

	return 0;
}
