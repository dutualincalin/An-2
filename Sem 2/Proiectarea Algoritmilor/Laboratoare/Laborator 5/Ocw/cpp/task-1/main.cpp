#include <bits/stdc++.h>
#include <cmath>
using namespace std;

// constanta modulo folosita in aceasta problema
#define MOD ((int)1e9 + 7)
// sau
// #define MOD 100000007
// (varianta 2 e mai ușor de busit, sesizați? :p)

class Task {
public:
    void solve() {
        read_input();
        print_output(get_result());
    }

private:
    int n;
    vector<int> v;

    void read_input() {
        ifstream fin("in");
        fin >> n;
        v.push_back(-1); // adaugare element fictiv - indexare de la 1
        for (int i = 1, e; i <= n; i++) {
            fin >> e;
            v.push_back(e);
        }
        fin.close();
    }

    int get_result() {
    	int i;
    	int **dp = (int**) malloc((n + 1) * sizeof(int*));

    	for(i = 0; i <= n ; i++){
    		dp[i] = (int*)malloc(2* sizeof(int));
    		dp[i][0] = 0;
    		dp[i][1] = 0;
    	}

		for(i = 1; i <= n; i++){
	
		    if(v[i]%2==0){
		        dp[i][0] = (dp[i-1][0] * 2 + 1) % MOD;
		        dp[i][1] = (dp[i-1][1] * 2) % MOD;
		    }

		    else{
		        dp[i][0] = (dp[i-1][0] + dp[i-1][1]) % MOD;
		        dp[i][1] = (dp[i-1][1] + dp[i-1][0] + 1) % MOD;
		    }
    	}
	
    	return dp[n][0];
   	}

    void print_output(int result) {
        ofstream fout("out");
        fout << result;
        fout.close();
    }
};

// [ATENTIE] NU modifica functia main!
int main() {
    // * se aloca un obiect Task pe heap
    // (se presupune ca e prea mare pentru a fi alocat pe stiva)
    // * se apeleaza metoda solve()
    // (citire, rezolvare, printare)
    // * se distruge obiectul si se elibereaza memoria
    auto* task = new (std::nothrow) Task(); // hint: cppreference/nothrow
    if (!task) {
        std::cerr << "new failed: WTF are you doing? Throw your PC!\n";
        return -1;
    }
    task->solve();
    delete task;
    return 0;
}
