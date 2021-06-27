// Copyright 2020
// Authors: Radu Nichita, Matei Simtinică

#ifndef TASK3_H_
#define TASK3_H_

#include "task.h"
#include "task1.h"
#include "task2.h"

/*
 * Task3
 * This being an optimization problem, the solve method's logic has to work differently.
 * You have to search for the minimum number of arrests by successively querying the oracle.
 * Hint: it might be easier to reduce the current task to a previously solved task
 */
class Task3 : public Task {
 private:
    std::string task2_in_filename;
    std::string task2_out_filename;
    int nr_familii;
    int nr_relatii;
    int **relatii;
    std::string sol_task2;
    int *solution;

 public:
    void solve() override {
        task2_in_filename = in_filename + "_t2";
        task2_out_filename = out_filename + "_t2";
        Task2 task2_solver = Task2();
        task2_solver.add_files(task2_in_filename, oracle_in_filename, oracle_out_filename, task2_out_filename);
        read_problem_data();
        reduce_to_task2();

        int k;

        for(k = nr_familii - 1; k > 0; k--){        // Se face cerere la oracol pana cand
            create_task2_file(k);                   // se gaseste o solutie falsa.
            task2_solver.solve();
            extract_answer_from_task2();

            if(sol_task2.compare("False") == 0){
                break;
            }
        }

        write_answer();
    }

    void read_problem_data() override {
        int i, j, k, l;
        std::ifstream f(in_filename);

        f >> nr_familii;          // Se citesc din fisierul de intrare toate datele de intrare si se
        f >> nr_relatii;          // aloca memorie pentru matricea de relatii si vectorul solutie.

        relatii = (int**) malloc(nr_familii * sizeof(int*));

        for(i = 0; i < nr_familii; i++){
            relatii[i] = (int*) malloc(nr_familii * sizeof(int));

            for(j = 0; j < nr_familii; j++){
                relatii[i][j] = 0;
            }
        }

        for(i = 0; i < nr_relatii; i++){
            f >> k;
            f >> l;
            relatii[k - 1][l - 1] = 1;
            relatii[l - 1][k - 1] = 1;
        }

        solution = (int*) malloc(nr_familii * sizeof(int));
    }

    void reduce_to_task2() {
        int i,j;
        std::ofstream o(task2_in_filename);

        for(i = 0; i < nr_familii; i++){
            for(j = 0; j < nr_familii; j++){        // Se va face graful invers al grafului
                if(relatii[i][j] == 0){             // problemei.
                    relatii[i][j] = 1;
                }

                else relatii[i][j] = 0;
            }
        }
    }

    void create_task2_file(int k){
        int i, j;
        std::ofstream o(task2_in_filename);

        o << nr_familii << " " << nr_familii * nr_familii - nr_relatii << " " << nr_familii - k << "\n";

        for(i = 0; i < nr_familii; i++){            // Se adauga in fisierul de intrare pentru task
            for(j = 0; j < nr_familii; j++){        // 2 datele noului graf astfel incat sa se
                if(i < j && relatii[i][j] == 1)         // rezolve problema nr_familii - k clica.
                    o << i + 1 << " " << j + 1 << "\n";
            }
        }

        o.close();
    }

    void extract_answer_from_task2() {
        int i;                                  // Se extrage solutia si in caz de adevar se retin
        std::ifstream f(task2_out_filename);    // datele solutiei in vectorul de solutii.
        f >> sol_task2;

        if(sol_task2.compare("True") == 0){
            for(i = 0; i < nr_familii; i++){   // Deoarece oracolul de apeleaza de mai multe ori vor
                solution[i] = 0;               // exista mai multe solutii, deci vectorul de solutii
            }                                  // trebuie resetat la gasirea unei noi solutii.

            while(f >> i){
                solution[i - 1] = 1;
            }
        }

        f.close();
    }

    void write_answer() override {
        int i;
        std::ofstream o(out_filename);
        
        for(i = 0; i < nr_familii - 1; i++){    // Raspunsul final la aceasta reducere sunt nodurile
            if(solution[i] == 0){               // care nu sunt prezente in vectorul de solutii.
                o << i + 1 << " ";
            }
        }

        if(solution[i] == 0){
                o << i + 1;
        }

        o.close();

        for(i = 0; i < nr_familii; i++){        // Se elibereaza memoria alocata pentru matricea de
            free(relatii[i]);                   // relatii si vectorul de solutii.
        }

        free(relatii);
        free(solution);
    };
};

#endif  // TASK3_H_
