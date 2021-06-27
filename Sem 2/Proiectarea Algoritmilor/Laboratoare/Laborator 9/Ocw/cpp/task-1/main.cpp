#include <bits/stdc++.h>
#include <stack>
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
            fin >> x >> y;
            adj[x].push_back(y); // arc (x, y)
        }
        fin.close();
    }

    int minim(int a, int b){
        if(a < b) return a;
        else return b;
    }

    void DFS(int node, vector<int> &parent, int timestamp, vector<int> &found, vector<int> &low_link, stack<int> &nodes_stack, vector<int> &inStack, vector<vector<int>> &all_sccs) {
        
        int i, x;
        found[node] = low_link[node] = ++timestamp;
        nodes_stack.push(node);
        inStack[node] = 1;

        for(int neigh : adj[node]){
            if(parent[neigh] != 0){
                if(inStack[neigh] == 1){
                    low_link[node] = minim(low_link[node], found[neigh]);
                }

                continue;
            }

            parent[neigh] = node;
            DFS(neigh, parent, timestamp, found, low_link, nodes_stack, inStack, all_sccs);
            low_link[node] = minim(low_link[node], low_link[neigh]);
        }

        if (low_link[node] == found[node]) {
            vector<int> new_scc;

            x = 0;

            while (x != node){
                x = nodes_stack.top();
                new_scc.push_back(x);
                nodes_stack.pop();
                inStack[x] = 0;
            }

            all_sccs.push_back(new_scc);
        }
    }

    vector<vector<int>> get_result() {
        //
        // TODO: Găsiți componentele tare conexe  (CTC / SCC) ale grafului orientat cu n noduri, stocat în adj.
        //
        // Rezultatul se va returna sub forma unui vector, fiecare element fiind un SCC (adică tot un vector).
        // * nodurile dintr-un SCC pot fi găsite în orice ordine
        // * SCC-urile din graf pot fi găsite în orice ordine
        //
        // Indicație: Folosiți algoritmul lui Tarjan pentru SCC.
        //
        int i, j;
        vector<vector<int>> all_sccs;
        vector<int> parent(n + 1, 0);
        vector<int> found(n + 1, -1);
        vector<int> low_link(n + 1, -1);
        vector<int> inStack(n + 1, 0);
        stack<int> nodes_stack;

        int timestamp = 0;

        for(i = 1; i <= n; i++){
            if(parent[i] == 0){
                parent[i] = i;
                DFS(i, parent, timestamp, found, low_link, nodes_stack, inStack, all_sccs);
            }
        }

        // for(i = 0; i < all_sccs.size(); i++){
        //     for(j = 0; j < all_sccs[i].size(); j++){
        //         cout << all_sccs[i][j] << " ";
        //     }

        //     cout << endl;
        // }
        
        return all_sccs;
    }

    void print_output(const vector<vector<int>>& all_sccs) {
        ofstream fout("out");
        fout << all_sccs.size() << '\n';
        for (const auto& scc : all_sccs) {
            for (auto node : scc) {
                fout << node << ' ';
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
