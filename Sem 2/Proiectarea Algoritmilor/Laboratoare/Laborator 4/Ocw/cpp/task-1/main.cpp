#include <bits/stdc++.h>
using namespace std;

class Task {
public:
    void solve() {
        read_input();
        print_output(get_result());
    }

private:
    int n, S;
    vector<int> v;

    void read_input() {
        ifstream fin("in");
        fin >> n >> S;
        v.push_back(-1); // adaugare element fictiv - indexare de la 1
        for (int i = 1, e; i <= n; i++) {
            fin >> e;
            v.push_back(e);
        }
        fin.close();
    }

    int get_result() {
        int i, j;
        int *d = (int *) malloc((S + 1) * sizeof(int*));

        d[0] = 0;

        for(i = 1; i <= S; i++){
            d[i] = S + 1;
        }

        for(i = 1; i <= S; i++){
            for(j = 1; j <= n; j++){
                if(i - v[j] >= 0){
                    d[i] = min(d[i - v[j]] + 1, d[i]);
                }
            }
        }

        if(d[S] == S+1)
            return -1;

        return d[S];
        // TODO: Aflati numarul minim de monede ce poate fi folosit pentru a obtine
        // suma S. Tipurile monedelor sunt stocate in vectorul v, de dimensiune n.
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
