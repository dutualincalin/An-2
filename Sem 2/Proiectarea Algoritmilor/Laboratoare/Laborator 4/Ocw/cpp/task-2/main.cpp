#include <bits/stdc++.h>
using namespace std;

struct Result {
    int len;
    vector<int> subsequence;
};

class Task {
public:
    void solve() {
        read_input();
        print_output(get_result());
    }

private:
    int n, m;
    vector<int> v;
    vector<int> w;

    void read_input() {
        ifstream fin("in");
        fin >> n >> m;

        v.push_back(-1); // adaugare element fictiv - indexare de la 1
        for (int i = 1, e; i <= n; i++) {
            fin >> e;
            v.push_back(e);
        }

        w.push_back(-1); // adaugare element fictiv - indexare de la 1
        for (int i = 1, e; i <= m; i++) {
            fin >> e;
            w.push_back(e);
        }

        fin.close();
    }

    Result get_result() {
        Result result;
        result.len = 0;
        int i, j;
        int **d = (int**) malloc((n + 1) * sizeof(int*));

        for(i = 0; i <= n; i++){
            d[i] = (int*) malloc((m + 1) * sizeof(int));
        }

        for(i = 0 ; i <= n; i++){
            d[i][0] = 0;
        }

        for(i = 0; i <= m; i++){
            d[0][i] = 0;
        }

        for(i = 1 ; i <= n; i++){
            for(j = 1; j <= m; j++){

                if(v[i] == w[j]){
                    d[i][j] = 1 + d[i-1][j-1];
                }
                else{
                    d[i][j] = max(d[i-1][j], d[i][j-1]);
                }
            }
        }

        result.len = d[n][m];
        int *match = (int*) malloc (result.len * sizeof(int)); 

        int k = result.len - 1;
        i = n;
        j = m;

        while(d[i][j] != 0){

            if(k >= 0){

                if(d[i][j] == d[i-1][j]){
                    i--;
                    continue;
                }

                else
                    if(d[i][j] == d[i][j-1]){
                        j--;
                        continue;
                    }

                    else{
                        match[k] = v[i];
                        k--;
                        i--;
                        j--;
                        continue;
                    }
            }

                else{
                    break;
                }
        }

        result.subsequence.reserve(result.len);
        
        for(i = 0; i < result.len; i++){
            result.subsequence.push_back(match[i]);
        }

        return result;
    }

    void print_output(Result result) {
        ofstream fout("out");
        fout << result.len << '\n';
        for (int x : result.subsequence) {
            fout << x << ' ';
        }
        fout << '\n';
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
