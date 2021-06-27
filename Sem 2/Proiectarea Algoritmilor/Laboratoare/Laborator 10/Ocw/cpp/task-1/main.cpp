#include <bits/stdc++.h>
using namespace std;

// numarul maxim de noduri
#define NMAX 50005

// valoare mai mare decat orice distanta din graf
#define INF (1 << 30)

class Task {
public:
    void solve() {
        read_input();
        print_output(get_result());
    }

private:
    // n = numar de noduri, m = numar de muchii
    int n, m;
    // adj[x] = lista de adiacenta a nodului x
    // perechea (y, w) semnifica muchie de la x la y de cost w: (x, y, w)
    vector<pair<int, int>> adj[NMAX];
    // nodul sursa
    int source;

    void read_input() {
        ifstream fin("in");
        fin >> n >> m >> source;
        for (int i = 1, x, y, w; i <= m; i++) {
            fin >> x >> y >> w;
            adj[x].push_back({y, w});
        }
        fin.close();
    }

    struct myComp {
		constexpr bool operator()( pair<int, int> const& a, pair<int, int> const& b)
        const noexcept{
	        return a.second < b.second;
	    }
	};

    vector<int> get_result() {
    	int i, node;

    	vector<int> d(n + 1, INF);
    	vector<int> P(n + 1, INF);
    	vector<bool> visited(n + 1, false);
	    d[source] = 0;
	    
	    priority_queue <pair<int, int>, vector<pair<int, int>>, myComp> q;

	    pair<int, int> spair;
	    spair.first = source;
	    spair.second = 0;
	    q.push(spair);


	    while(!q.empty()){
	    	node = (q.top()).first;
	    	q.pop();

	    	visited[node] = true;

	    	for(pair<int, int> muchie : adj[node]){
	    		int neigh = muchie.first;
	    		int cost = muchie.second;

	    		if(!visited[neigh] && d[neigh] > d[node] + cost){
	    			d[neigh] = d[node] + cost;
	    			P[neigh] = node;
	    			muchie.second = d[neigh];
				    q.push(muchie);
	    		}
	    	}
	    }

	    for(i = 1; i <= n; i++){
	    	if(d[i] == INF){
	    		d[i] = -1;
	    	}
	    }

        return d;
    }

    void print_output(vector<int> result) {
        ofstream fout("out");
        for (int i = 1; i <= n; i++) {
            fout << result[i] << " ";
        }
        fout << "\n";
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
