#include <bits/stdc++.h>
using namespace std;

struct Homework {
    int deadline;
    int score;

    Homework(int _deadline, int _score)
        : deadline(_deadline)
        , score(_score) { }
};

class Task {
public:
    void solve() {
        read_input();
        print_output(get_result());
    }

private:
    int n;
    vector<Homework> hws;

    void read_input() {
        ifstream fin("in");
        fin >> n;
        for (int i = 0, deadline, score; i < n; i++) {
            fin >> deadline >> score;
            hws.push_back(Homework(deadline, score));
        }
        fin.close();
    }

    int get_result() {
        int i, j;
        Homework *sorted_hw = (Homework *) malloc(n * sizeof(Homework));
        int *assigned_hw = (int *)malloc(n * sizeof(int));
        Homework aux = Homework(0 , 0);

        for(i = 0; i < n; i++){
            sorted_hw[i] = hws[i];
            assigned_hw[i] = 0;
        }

        for(i = 0; i < n; i++){
            for(j = 0; j < n; j++){

                if(sorted_hw[i].deadline > sorted_hw[j].deadline || (sorted_hw[i].deadline == sorted_hw[j].deadline && sorted_hw[i].score > sorted_hw[j].score)){
                    aux = sorted_hw[i];
                    sorted_hw[i] = sorted_hw[j];
                    sorted_hw[j] = aux;
                }
            }
        }

        for(i = 0; i < n; i++){
            printf("%d %d\n", sorted_hw[i].deadline, sorted_hw[i].score);
        }

        i = 0;
        int day;
        int punctaj_total = 0;
        int starting_availability = 0;
        int max_ind;

        day = sorted_hw[i].deadline;
        punctaj_total += sorted_hw[i].score;
        assigned_hw[i] = 1;
        starting_availability++;
        i++;

        while(i < n){
            if(sorted_hw[i].deadline == day && starting_availability == i){
            	i++;

            	while(sorted_hw[i].deadline == day){
            		i++;
            	}

            }

            else{
            	day = sorted_hw[i].deadline;

            	if(i == starting_availability){
            		
            		punctaj_total += sorted_hw[i].score;
            		assigned_hw[i] = 1;
            		starting_availability++;
            		i++;
            	}

            	else{
            		max_ind = starting_availability;

            		for(j = starting_availability + 1; j <= i; j++){
            			if(sorted_hw[j].score > sorted_hw[max_ind].score && assigned_hw[j] == 0){
            				max_ind = j;
            			}
            		}

            		punctaj_total += sorted_hw[max_ind].score;
            		assigned_hw[max_ind] = 1;
            		i++;

            		if(day == 1){
            			break;
            		}

            		while(sorted_hw[i].deadline == day){
            			i++;
            		}

            		while(assigned_hw[starting_availability] == 1){
            			starting_availability++;
            		}
            	}
        	}
        }

        return punctaj_total;
    }

    void print_output(int result) {
        ofstream fout("out");
        fout << result;
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
