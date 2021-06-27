#include <bits/stdc++.h>
using namespace std;

struct Object {
    int weight;
    int price;

    Object(int _weight, int _price)
        : weight(_weight)
        , price(_price) { }
};

class Task {
public:
    void solve() {
        read_input();
        print_output(get_result());
    }

private:
    int n, w;
    vector<Object> objs;

    void read_input() {
        ifstream fin("in");
        fin >> n >> w;
        for (int i = 0, weight, price; i < n; i++) {
            fin >> weight >> price;
            objs.push_back(Object(weight, price));
        }
        fin.close();
    }

    double get_result() {
       	double total_value = 0;
        Object *sorted_objs = (Object *) malloc(n * sizeof(Object));
        Object aux = Object(0, 0);
        int i, j;

        for(i = 0; i < n; i++){
            sorted_objs[i] = objs[i];
        }

        for(i = 0; i < n - 1; i++){
            for(j = i + 1; j < n; j++){

                if((double) ((double)sorted_objs[i].price / (double)sorted_objs[i].weight) < (double)((double)sorted_objs[j].price / (double)sorted_objs[j].weight)){
                    aux = sorted_objs[i];
                    sorted_objs[i] = sorted_objs[j];
                    sorted_objs[j] = aux;
                }
            }
        }

        int capacity = w;
        i = 0;

        while(capacity != 0){
            if(sorted_objs[i].weight < capacity){
                total_value += (double) sorted_objs[i].price;
                capacity -= sorted_objs[i].weight;
                i++;
            }

            else{
                total_value += (double)((double)((double)capacity/(double)sorted_objs[i].weight) * (double)sorted_objs[i].price);
                capacity = 0;
                break;
            }
        }

        return total_value;
    }

    void print_output(double result) {
        ofstream fout("out");
        fout << setprecision(4) << fixed << result;
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
    auto* task = new (std::nothrow) Task{}; // hint: cppreference/nothrow
    if (!task) {
        std::cerr << "new failed: WTF are you doing? Throw your PC!\n";
        return -1;
    }
    task->solve();
    delete task;
    return 0;
}
