#include <iostream>
#include <fstream>
#include <vector>
using namespace std;

typedef struct{
	int greutate;
	int suma;
} Ingredient;

int main() {
	ifstream f("Ingrediente.in");
	int i, j, n, S;

	f >> n >> S;
	vector<Ingredient> lista(n + 1);

	for(i = 1; i <= n; i++){
		f >> lista[i].greutate >> lista[i].suma;
	}

	f.close();

	vector<vector<int> > dp(n + 1, vector<int>(S + 1, 0));

	for(i = 0; i <= n; i++){
		for(j = 0; j <= S; j++){
			if(i == 0 || j == 0){
				continue;
			}

			if(j < lista[i].suma){
				dp[i][j] = dp[i - 1][j];
				continue;
			}

			if(dp[i - 1][j] > lista[i].greutate){
				dp[i][j] = dp[i - 1][j];
			}

			else dp[i][j] = lista[i].greutate;

			if(dp[i][j] < dp[i-1][j - lista[i].suma] + lista[i].greutate){
				dp[i][j] = dp[i-1][j - lista[i].suma] + lista[i].greutate;
			}
		}
	}

    for(i = 0; i <=n; i++){
        for(j = 0; j <= S; j++){
            cout << dp[i][j] << " ";
        }
        cout << endl;
    }
	cout << "Numarul maxim de kilograme este " << dp[n][S] << endl;
}
