#include <bits/stdc++.h>
#include <queue>
using namespace std;

// numarul maxim de noduri
#define NMAX 200005
#define INF 1000000

class Task {
public:
    void solve() {
        read_input();
        print_output(get_result());
    }

private:
    // n = numar de noduri, m = numar de muchii
    int n, m;

    // adj[i] = lista de adiacenta a lui i
    // (j, w) - exista muchie de la i la j de cost w
    vector<pair<int, int>> adj[NMAX];

    void read_input() {
        ifstream fin("in");
        fin >> n >> m;
        for (int i = 1, x, y, w; i <= m; i++) {
            fin >> x >> y >> w;
            adj[x].push_back({y, w});
            adj[y].push_back({x, w});
        }
        fin.close();
    }


    struct myComp {
        constexpr bool operator()( pair<int, int> const& a, pair<int, int> const& b)
        const noexcept{
            return a.second < b.second;
        }
    };

    int get_result() {
        //
        // TODO: Calculati costul minim al unui arbore de acoperire
        // folosind algoritmul lui Prim.
        //Prim(G(V,E), w, root)
        // 1.  MuchiiAMA <- ∅;
        // 2.  for each u in V do
        // 3.      d[u] = INF; //iniţial distanţele sunt infinit
        // 4.      p[u] = NIL; //şi nu există predecesori
        // 5.  d[root] = 0;    //distanţa de la rădăcină la arbore e 0
        // 6.  H = Heap(V,d);  //se construieşte heap-ul
        // 7.  while (H not empty) do  //cât timp mai sunt noduri neadăugate
        // 8.      u = GetMin(H);  //se selectează cel mai apropiat nod u
        // 9.      MuchiiAMA = MuchiiAMA ∪ {(u, p[u])};//se adaugă muchia care uneşte u cu un nod din arborele principal 
        // 10.     for each v in Adj(u) do
        //         //pentru toate nodurile adiacente lui u se verifică dacă
        //         //trebuie făcute modificări
        // 11.         if w[u][v] < d[v] then
        // 12.             d[v] = w[u][v];
        // 13.             p[v] = u;
        // 14.             Heapify(v, H);  //refacerea structurii de heap
        // 15. MuchiiAMA = MuchiiAMA \ {(root, p[root])};
        // 16. return MuchiiAMA;
        //

        int cost = 0;
        vector<pair <int, int>> mintree;
        pair<int, int> node, node_analizata, nodetree;
        std::priority_queue< pair<int, int>, vector<pair<int, int>>, myComp> minHeap;
        vector<int> d(n + 1, INF);
        vector<int> p(n + 1, 0);
        vector<int> selected(n + 1, 0);
        d[1] = 0;

        node.first = 1;
        node.second = 0;
        minHeap.push(node);

        while(!minHeap.empty()){
            node_analizata = minHeap.top();
            minHeap.pop();
            selected[node_analizata.first] = 1;

            nodetree.first = node_analizata.first;
            nodetree.second = d[node_analizata.first];

            mintree.push_back(nodetree);

            for(pair<int, int> adjnode : adj[node_analizata.first]){
                if(adjnode.second < d[adjnode.first] && selected[adjnode.first] == 0){
                    d[adjnode.first] = adjnode.second;
                    p[adjnode.first] = node_analizata.first;

                    node.first = adjnode.first;
                    node.second = d[adjnode.first];
                    minHeap.push(node);
                }
            }
        }

        mintree.erase(mintree.begin());

        for(pair<int, int> tpair : mintree){
        	cost += tpair.second;
        }

        return cost;
    }

    void print_output(int result) {
        ofstream fout("out");
        fout << result << "\n";
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
