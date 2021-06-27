#include <bits/stdc++.h>
#include <string.h>
using namespace std;

class Task {
public:
    void solve() {
        read_input();
        print_output(get_result());
    }

private:
    int n, k;
    string caractere;
    vector<int> freq;

    void read_input() {
        ifstream fin("in");
        fin >> n >> k;
        fin >> caractere;
        caractere = " " + caractere; // Adaugare element fictiv -
                                     // indexare de la 1.
        freq.push_back(-1); // Adaugare element fictiv - indexare de la 1.
        for (int i = 1, f; i <= n; i++) {
            fin >> f;
            freq.push_back(f);
        }
        fin.close();
    }

    void back(vector<char> domain, vector<char> &solution, vector<vector<char>> &all, int repeat){
        if(domain.size() == 0){
            if(count(all.begin(), all.end(), solution)){
                return;
            }

            else{
                all.push_back(solution);
                return;
            }
        }

        printf("%ld\n", all.size());

        int i, j;
        char aux;

        for(i = 0; i < domain.size(); i++){
            vector<char> new_domain(domain);
            vector<char> new_solution(solution);
            int new_repeat = repeat;

            if(new_repeat != k){
                if(new_domain[i] == new_solution[new_solution.size() - 1] || new_solution.size() == 0){
                    new_repeat++;
                }
                else new_repeat = 1;
            }

            else{
                if(new_domain[i] == new_solution[new_solution.size() - 1]){
                    j = i + 1;

                    while(new_domain[i] == new_domain[j] && j < domain.size()){
                        j++;
                    }

                    if(j == new_domain.size()){
                        return;
                    }

                    swap(new_domain[i], new_domain[j]);
                }

                new_repeat = 1;
            }

            new_solution.push_back(new_domain[i]);
            new_domain.erase(new_domain.begin() + i);
            back(new_domain, new_solution, all, new_repeat);
        }

        return;
    }

    vector<vector<char>> get_result() {
        vector<vector<char>> all;

        // TODO: Construiti toate sirurile cu caracterele in stringul caractere
        // (indexat de la 1 la n), si frecventele in vectorul freq (indexat de la 1 la n),
        // stiind ca nu pot fi mai mult de K aparitii consecutive ale
        // aceluiasi caracter.
        //
        // Pentru a adauga un nou sir:
        //     vector<char> sir;
        //     all.push_back(sir);
        //
        vector<char> domain;
        vector<char> solution;

        int i, j;
        for(i = 1; i <= n; i++){
            for(j = 0; j < freq[i]; j++)
            domain.push_back(caractere[i]);
        }

        back(domain, solution, all, 0);

        return all;
    }

    void print_output(const vector<vector<char>>& result) {
        ofstream fout("out");
        fout << result.size() << '\n';
        for (size_t i = 0; i < result.size(); i++) {
            for (size_t j = 0; j < result[i].size(); j++) {
                fout << result[i][j];
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
    auto* task = new (std::nothrow) Task(); // hint: cppreference/nothrow
    if (!task) {
        std::cerr << "new failed: WTF are you doing? Throw your PC!\n";
        return -1;
    }
    task->solve();
    delete task;
    return 0;
}
