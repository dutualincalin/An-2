#include <bits/stdc++.h>
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

    void back(vector<int> &domain, vector<int> &solution, vector<vector<int>> &solutions){
    	int i, j;

    	if(solution.size() != 0){
    		solutions.push_back(solution);
    	}

    	for(i = 0; i < domain.size(); i++){

    		vector<int> new_domain;

    		for(j = i + 1; j < domain.size(); j++){
    			new_domain.push_back(domain[j]);
    		}

    		vector<int> new_solution(solution);
    		new_solution.push_back(domain[i]);

    		back(new_domain, new_solution, solutions);
    	}
    }


    vector<vector<int>> get_result() {
        vector<vector<int>> all;
        vector<int> domain, solution;
        vector<int> solution1;
        all.push_back(solution1);

        int i;
        for (i = 1; i <= n; ++i){
        	domain.push_back(i);
        }

        back(domain, solution, all);



        return all;
    }

    void print_output(const vector<vector<int>>& result) {
        ofstream fout("out");
        fout << result.size() << '\n';
        for (size_t i = 0; i < result.size(); i++) {
            for (size_t j = 0; j < result[i].size(); j++) {
                fout << result[i][j] << (j + 1 != result[i].size() ? ' ' : '\n');
            }
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
