#include <bits/stdc++.h>
using namespace std;

// numarul maxim de noduri
#define NMAX 1005
#define INF 110001

class Task {
public:
    void solve() {
        read_input();
        print_output(get_result());
    }

private:
    // n = numar de noduri, m = numar de muchii
    int n, m;

    // adj[i] = lista de adiacenta a nodului i
    vector<int> adj[NMAX];

    // cap[i][j] = capacitatea arcului i -> j
    int cap[NMAX][NMAX];

    void read_input() {
        ifstream fin("in");
        fin >> n >> m;
        memset(cap, 0, sizeof cap);
        for (int i = 1, x, y, c; i <= m; i++) {
            // x -> y de capacitate c
            fin >> x >> y >> c;
            adj[x].push_back(y);
            adj[y].push_back(x);

            // Presupunem existenta mai multor arce x -> y cu capacitati c1, c2, ...
            // Comprimam intr-un singur arc x -> y cu capacitate
            // cap[x][y] = c1 + c2 + ...
            cap[x][y] += c;
        }
        fin.close();
    }


    int bfs(int s, int t, vector<int>& parent) {
    	int cur, flow, new_flow;
	    queue<pair<int, int>> q;
	    
	    fill(parent.begin() + 1, parent.end(), -1);
	    parent[s] = -2;
	    q.push({s, INF});

	    while(!q.empty()){
	        cur = q.front().first;
	        flow = q.front().second;
	        q.pop();

	        for(int next : adj[cur]){
	            if(parent[next] == -1 && cap[cur][next]){
	                parent[next] = cur;
	                new_flow = min(flow, cap[cur][next]);

	                if (next == t){
	                    return new_flow;
	                }

	                q.push({next, new_flow});
	            }
	        }
	    }

	    return 0;
	}

    int get_result() {
        int s = 1, t = n, max_flow = 0, new_flow, cur, prev;
	    vector<int> parent(n + 1);

	    while (new_flow = bfs(s, t, parent)) {
	        max_flow += new_flow;
	        cur = t;

	        while (cur != s){
	            prev = parent[cur];
	            cap[prev][cur] -= new_flow;
	            cap[cur][prev] += new_flow;
	            cur = prev;
	        }
	    }

        return max_flow;
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
    auto* task = new (nothrow) Task(); // hint: cppreference/nothrow
    if (!task) {
        cerr << "new failed: WTF are you doing? Throw your PC!\n";
        return -1;
    }
    task->solve();
    delete task;
    return 0;
}
