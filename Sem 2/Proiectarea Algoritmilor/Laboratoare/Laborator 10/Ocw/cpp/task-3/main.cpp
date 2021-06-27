#include <bits/stdc++.h>
using namespace std;

// numarul maxim de noduri
#define NMAX 105
#define INF 10000

class Task {
public:
    void solve() {
        read_input();
        compute();
        print_output();
    }

private:
    // n = numar de noduri
    int n;

    // w[x][y] = costul muchiei de la x la y: (x, y, w[x][y])
    // (w[x][y] = 0 - muchia lipseste)
    int w[NMAX][NMAX];

    // d[x][y] = lungimea drumului minim de la x la y
    int d[NMAX][NMAX];

    void read_input() {
        ifstream fin("in");
        fin >> n;
        for (int x = 1; x <= n; x++) {
            for (int y = 1; y <= n; y++) {
                fin >> w[x][y];
            }
        }
        fin.close();
    }

    int mini(int a, int b){
        if(a != 0 && b != 0){
            if(a < b){
                return a;
            }

            return b;
        }

        else{
            if(a == 0){
                return a;
            }

            return b;
        }
    }

    void compute() {
        int i, j, k;

        for(i = 1; i <= n; i++){
            for(j = 1; j <= n; j++){
                if(w[i][j] == 0){
                    d[i][j] = INF;
                }

                else d[i][j] = w[i][j];
            }
        }

        for(k = 1; k <= n; k++){
            for(i = 1; i <= n; i++){
                for(j = 1; j <= n; j++){
                    d[i][j] = min(d[i][j], d[i][k] + d[k][j]);
                }
            }
        }

        for(i = 1; i <= n; i++){
            for(j = 1; j <= n; j++){
                if(d[i][j] == INF || i == j){
                    d[i][j] = 0;
                }
            }
        }
    }

    void print_output() {
        ofstream fout("out");
        for (int x = 1; x <= n; x++) {
            for (int y = 1; y <= n; y++) {
                fout << d[x][y] << ' ';
            }
            fout << '\n';
        }
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
    auto* task = new (nothrow) Task(); // hint: cppreference/nothrow
    if (!task) {
        cerr << "new failed: WTF are you doing? Throw your PC!\n";
        return -1;
    }
    task->solve();
    delete task;
    return 0;
}
