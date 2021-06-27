#include <bits/stdc++.h>
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
            fin >> x >> y; // muchia (x, y)
            adj[x].push_back(y);
            adj[y].push_back(x);
        }
        fin.close();
    }

    int minim(int a, int b){
        if(a < b) return a;
        else return b;
    }

    void DFS(int node, vector<int> &parent, int timestamp, vector<int> &found, vector<int> &low_link, vector<int> &all_cvs) {
        
        int kids = 0;
        found[node] = low_link[node] = ++timestamp;

        for(int neigh : adj[node]){
            if(parent[neigh] != -1){
                if(neigh != parent[node]){
                    low_link[node] = minim(low_link[node], found[neigh]);
                }

                continue;
            }

            parent[neigh] = node;
            ++kids;
            DFS(neigh, parent, timestamp, found, low_link, all_cvs);
            low_link[node] = minim(low_link[node], low_link[neigh]);

	        if (parent[node] != node && low_link[neigh] >= found[node]) {
	        	all_cvs.push_back(node);
	        }
    
	        if(parent[node] == node && kids > 1){
	        	all_cvs.push_back(node);
	        }
	    }
    }

    vector<int> get_result() {
        //
        // TODO: Gasiti toate nodurile critice ale grafului neorientat stocat cu liste de adiacenta in adj.
        // Rezultatul se va returna sub forma unui vector cu toate punctele critice (ordinea nu conteaza).
        //
        // Indicație: Folosiți algoritmul lui Tarjan pentru CV.
        //

    	int i;
    	int timestamp = 0;
        vector<int> all_cvs;
        vector<int> parent(n + 1, -1);
        vector<int> found(n + 1, -1);
        vector<int> low_link(n + 1, -1);

        for(i = 1; i <= n; i++){
            if(parent[i] == -1){
                parent[i] = i;
                DFS(i, parent, timestamp, found, low_link, all_cvs);
            }
        }

        return all_cvs;
    }

    void print_output(const vector<int>& all_cvs) {
        ofstream fout("out");
        for (auto cv : all_cvs) {
            fout << cv << ' ';
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
