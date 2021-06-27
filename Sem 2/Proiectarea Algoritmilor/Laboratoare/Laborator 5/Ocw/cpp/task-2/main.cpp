#include <bits/stdc++.h>
using namespace std;

// constanta modulo folosita in aceasta problema
#define MOD ((int)1e9 + 7)
// sau
// #define MOD 100.000.007
// (varianta 2 e mai ușor de busit, sesizați? :p)

class Task {
public:
    void solve() {
        read_input();
        print_output(get_result());
    }

private:
    int n;
    string expr;

    void read_input() {
        ifstream fin("in");
        fin >> n >> expr;
        expr = " " + expr; // adaugare caracter fictiv - indexare de la 1
        fin.close();
    }

    int get_result() {
        unsigned long i, l, total_ik, total_kj;
        unsigned long nOpds = n / 2 + 1;
        unsigned long nOpts = n / 2;
        unsigned long j, k;

        char* operands = (char*) malloc(nOpds * sizeof(char));
        char* operators = (char*) malloc(nOpts * sizeof(char));

        unsigned long **T = (unsigned long**) malloc(nOpds * sizeof(unsigned long*));
        unsigned long **F = (unsigned long**) malloc(nOpds * sizeof(unsigned long*));

        for(i = 0; i < nOpds; i++){
            T[i] = (unsigned long*) malloc(nOpds * sizeof(unsigned long));
            F[i] = (unsigned long*) malloc(nOpds * sizeof(unsigned long));

            for(j = 0; j < nOpds; j++){
                T[i][j] = 0;
                F[i][j] = 0;
            }
        }

        j = 0;
        k = 0;
        for(i = 1; i <= n; i++){
            if(expr[i] == 'T' || expr[i] == 'F'){
                operands[j] = expr[i];
                j++;
            }

            else{
                operators[k] = expr[i];
                k++;
            }
        }
        

        for(i = 0; i < nOpds; i++){
            if(operands[i] == 'T'){
                T[i][i] = 1;
                F[i][i] = 0;
            }

            else{
                T[i][i] = 0;
                F[i][i] = 1;
            }
        }

        for(l = 1; l < nOpds; l++) {
            for(i = 0; i < nOpds - l; i++){
                j = i+l;
                T[i][j] = F[i][j] = 0;

                for (k = i; k < j; k++){
                    total_ik = (T[i][k] + F[i][k])% MOD;
                    total_kj = (T[k+1][j] + F[k+1][j])% MOD;

                    if (operators[k] == '&') {
                        T[i][j] += (T[i][k] * T[k+1][j]);
                        F[i][j] += (total_ik *total_kj - T[i][k] * T[k+1][j]);
                    }

                    if (operators[k] == '|'){
                        F[i][j] += (F[i][k] * F[k+1][j]);
                        T[i][j] += (total_ik * total_kj - F[i][k] * F[k+1][j]);
                    }

                    if (operators[k] == '^'){
                        T[i][j] += (F[i][k] * T[k+1][j] + T[i][k] * F[k+1][j]);
                        F[i][j] += (T[i][k] * T[k+1][j] + F[i][k] * F[k+1][j]);
                    }
                }
            }
        }

        return (int)(T[0][nOpds-1] % MOD);
    
    }

    void print_output(int result) {
        ofstream fout("out");
        fout << result << '\n';
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
