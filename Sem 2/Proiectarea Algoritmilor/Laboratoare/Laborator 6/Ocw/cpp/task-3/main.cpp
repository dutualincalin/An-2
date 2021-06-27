#include <iostream>
#include <bits/stdc++.h>
#include <vector>
using namespace std;

class Task {
public:
    void solve() {
        read_input();
        print_output(get_result());
    }

private:
    int n;

    void read_input() {
        ifstream fin("in");
        fin >> n;
        fin.close();
    }

    void update_attacks(vector <vector<int>> &new_sah_attacks, int i, int j){
        int k, l;
        for(k = 0; k < n; k++){
            new_sah_attacks[i][k] = 1;
            new_sah_attacks[k][j] = 1;

            if(i < j && k + j - i < n){
                new_sah_attacks[k][k + j - i] = 1;
            }

            if(i > j && k + i - j < n){
                new_sah_attacks[k + i - j][k] = 1;
            }

            if(i == j)
                new_sah_attacks[k][k] = 1;
        }

        for(k = 0, l = n - 1; k < n, l >= 0; k++, l--){
            if(i + j > k + l && i + j - l < n){
                new_sah_attacks[i + j - l][l] = 1;
            }

            if(i + j < k + l && i + j - k >= 0){
                new_sah_attacks[k][i + j - k] = 1;
            }

            if(i + j == k + l){
                new_sah_attacks[k][l] = 1;
            }
        }
    }

    void sah(vector<int> &domain, vector<int> &solution, vector<int> &sol, vector <vector<int>> &sah_attacks, int placed){
        int i, j;

        if(placed == n){
            for(i = 0; i < n; i++){
                sol[i + 1] = solution[i] + 1;
            }

            return;
        }

        if(domain.size() == 0)
            return;

        for(i = 0; i < domain.size(); i++){     
            vector<int> new_solution(solution);

            new_solution.push_back(domain[i]);

            vector<int> new_domain;
            vector <vector<int>> new_sah_attacks(sah_attacks);

            update_attacks(new_sah_attacks, placed, domain[i]);

            if(placed + 1 != n){
                for(j = 0; j < n; j++){
                    if(new_sah_attacks[placed + 1][j] == 0){
                        new_domain.push_back(j);
                    }
                }
            }

            sah(new_domain,new_solution, sol, new_sah_attacks, placed + 1);

            if(sol[1] != 0){
                return;
            }   
        }

        return;
    }

    vector<int> get_result() {
        vector<int> sol(n + 1, 0);

        // TODO: Gasiti o solutie pentru problema damelor pe o tabla de dimensiune
        // n x n.
        //
        // Pentru a plasa o dama pe randul i, coloana j:
        //     sol[i] = j.
        // Randurile si coloanele se indexeaza de la 1 la n.
        //
        // De exemplu, configuratia (n = 5)
        // X----
        // --X--
        // ----X
        // -X---
        // ---X-
        // se va reprezenta prin sol[1..5] = {1, 3, 5, 2, 4}.
        int i;
        vector<int> domain, solution;
        vector <vector<int>> sah_attacks(n, vector<int>(n, 0));

        for(i = 0; i < n; i++){
            domain.push_back(i);
        }

        sah(domain, solution, sol, sah_attacks, 0);

        return sol;
    }

    void print_output(const vector<int>& result) {
        ofstream fout("out");
        for (int i = 1; i <= n; i++) {
            fout << result[i] << (i != n ? ' ' : '\n');
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
    auto* task = new (std::nothrow) Task(); // hint: cppreference/nothrow
    if (!task) {
        std::cerr << "new failed: WTF are you doing? Throw your PC!\n";
        return -1;
    }
    task->solve();
    delete task;
    return 0;
}
