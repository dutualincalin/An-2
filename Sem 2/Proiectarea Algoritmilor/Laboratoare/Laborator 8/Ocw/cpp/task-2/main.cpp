#include <bits/stdc++.h>
#include <stack>
#include <algorithm>
using namespace std;

class Task {
public:
    void solve() {
        read_input();
        print_output(get_result());
    }

private:
    // numarul maxim de noduri
    static constexpr int NMAX = (int)1e5 + 5; // 10^5 + 5 = 100.005

    // n = numar de noduri, m = numar de muchii/arce
    int n, m;

    // adj[node] = lista de adiacenta a nodului node
    // exemplu: daca adj[node] = {..., neigh, ...} => exista arcul (node, neigh)
    vector<int> adj[NMAX];

    void read_input() {
        ifstream fin("in");
        fin >> n >> m;
        for (int i = 1, x, y; i <= m; i++) {
            fin >> x >> y; // arc (x, y)
            adj[x].push_back(y);

        }
        fin.close();
    }

    void dfs(int node, stack<int> &stack, vector<int> &visited){
        int i;
        visited[node] = 1;

        for(i = 0; i < adj[node].size(); i++){
            if(visited[adj[node][i]] == 0){
                dfs(adj[node][i], stack, visited);
            }
        }


        stack.push(node);
    }

    vector<int> get_result() {
        // TODO: Faceti sortarea topologica a grafului stocat cu liste de adiacenta din adj.
        // *******
        // ATENTIE: nodurile sunt indexate de la 1 la n.
        // *******

        int i, j, node;
        vector<int> topsort;
        vector<int> visited(n + 1, 0);
        stack<int> s;

        for(i = 1; i <= n; i++){
            if(visited[i] == 0){
                dfs(i, s, visited);
            }
        }

        while(!s.empty()){
            topsort.push_back(s.top());
            s.pop();
        }

        return topsort;
    }

    void print_output(const vector<int>& topsort) {
        ofstream fout("out");
        for (auto node : topsort) {
            fout << node << ' ';
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
    auto* task = new (nothrow) Task(); // hint: cppreference/nothrow
    if (!task) {
        cerr << "new failed: WTF are you doing? Throw your PC!\n";
        return -1;
    }
    task->solve();
    delete task;
    return 0;
}
