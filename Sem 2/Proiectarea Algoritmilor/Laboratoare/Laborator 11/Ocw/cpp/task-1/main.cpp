#include <bits/stdc++.h>
#include <vector>
using namespace std;

// numarul maxim de noduri
#define NMAX 200005

// Structura de date descrisa aici https://infoarena.ro/problema/disjoint.
class DisjointSet {
private:
    vector<int> parent, size;

public:
    // Se initializeaza n paduri
    DisjointSet(int n)
        : parent(n + 1)
        , size(n + 1) {
        for (int i = 1; i <= n; ++i) {
            // fiecare padure contine un nod initial
            parent[i] = i;
            size[i] = 1;
        }
    }

    // returneaza radacina arborelui din care face parte node
    int find_root(int node) {
        if (node == parent[node]) {
            return node;
        }
        return parent[node] = find_root(parent[node]);
    }

    // reuneste arborii lui root1 si root2 intr-un singur arbore
    void merge_forests(int root1, int root2) {
        if (size[root1] <= size[root2]) {
            size[root2] += size[root1];
            parent[root1] = root2;
        } else {
            size[root1] += size[root2];
            parent[root2] = root1;
        }
    }
};

class Task {
public:
    void solve() {
        read_input();
        print_output(get_result());
    }

private:
    // n = numar de noduri, m = numar de muchii
    int n, m;

    // (x, y, w) - muchie de la x la y de cost w
    typedef tuple<int, int, int> edge;

    // edges = toate muchiile din graf
    vector<edge> edges;

    void read_input() {
        ifstream fin("in");
        fin >> n >> m;
        for (int i = 1, x, y, w; i <= m; i++) {
            fin >> x >> y >> w;
            edges.push_back({x, y, w});
        }
        fin.close();
    }

    static bool costSort(edge e1, edge e2){
    	int a = get<2>(e1);
    	int b = get<2>(e2);
    	return (a < b);
    }

    int get_result() {
        //
        // TODO: Calculati costul minim al unui arbore de acoperire
        // folosind algoritmul lui Kruskal.
        //
        // Pentru a construi un tuple:
        // int a, b, c;
        // tuple<int, int, int> t = make_tuple(a, b, c);
        //
        // Pentru a accesa elementele dintr-un tuple, exista 2 variante:
        // tuple<int, int, int> t;
        // int a, b, c;
        // tie(a, b, c) = t;
        //
        // tuple<int, int, int> t;
        // int a = get<0>(t);
        // int b = get<1>(t);
        // int c = get<2>(t);
        //
        // Vi se da implementata structura de Paduri de multimi disjuncte.
        // Utilizare:
        // DisjointSet dj(n);
        // dj.find(x);
        // dj.reunion(x, y);
        //
    	// Kruskal(G(V, E), w)
    	// MuchiiAMA <- ∅;
    	// for each v in V do
		// MakeSet(v);	//fiecare nod e un arbore diferit
    	// sort(E);		//sortează muchiile în ordine crescătoare a costului
    	// for each (u,v) in E do
		// if (FindSet(u) != FindSet(v)) then	//capetele muchiei fac parte //din subarbori disjuncţi
		// MuchiiAMA = MuchiiAMA ∪ {(u, v)};	//adaugă muchia la arbore
		// Union(u, v);    //uneşte subarborii corespunzători lui u şi v
     	// return MuchiiAMA;

    	vector<edge> mintree;
    	int fst, snd, i;
    	DisjointSet dj(n);
    	sort(edges.begin(), edges.end(), costSort);

    	for(edge e : edges){
    		fst = get<0>(e);
    		snd = get<1>(e);
    		if(dj.find_root(fst) != dj.find_root(snd)) {
    			mintree.push_back(e);
    			dj.merge_forests(fst, snd);
    		}

    		if(mintree.size() == n - 1){
    			break;
    		}
    	}

    	int cost = 0;
    	for(edge e : mintree){
    		printf("%d - %d - %d\n", get<0>(e), get<1>(e), get<2>(e));
    		cost += get<2>(e);
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
