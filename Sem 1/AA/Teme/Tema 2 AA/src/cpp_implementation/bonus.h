// Copyright 2020
// Authors: Radu Nichita, Matei Simtinică

#ifndef BONUS_H_
#define BONUS_H_

#include "task.h"

/*
 * Bonus Task
 * You have to implement 4 methods:
 * read_problem_data         - read the problem input and store it however you see fit
 * formulate_oracle_question - transform the current problem instance into a SAT instance and write the oracle input
 * decipher_oracle_answer    - transform the SAT answer back to the current problem's answer
 * write_answer              - write the current problem's answer
 */
class Bonus : public Task {
 private:
    int nr_familii;
    int nr_relatii;
    int **relatii;
    int *variabile_finale;

 public:
    void solve() override {
        read_problem_data();
        formulate_oracle_question();
        ask_oracle();
        decipher_oracle_answer();
        write_answer();
    }

    void read_problem_data() override {
        int i, j, k, l;
        std::ifstream f(in_filename);

        f >> nr_familii;          // Se citesc datele din fisierul de intrare si se aloca memorie
        f >> nr_relatii;            // pentru matricea de relatii.

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
    }

    void formulate_oracle_question() {
        int i, j, nr_clauze, greutate;
        std::ofstream o(oracle_in_filename);

        greutate = nr_familii + 1;              // Se calculeaza ponderile si numarul de clauze
        nr_clauze = nr_relatii + nr_familii;

        o << "p wcnf " << nr_familii << " " << nr_clauze << " " << greutate << "\n";


        for(i = 0; i < nr_familii; i++){         // Se fac clauze pentru propozitia: "Pentru fiecare
            for(j = 0; j < nr_familii; j++){     //  muchie, cel putin un nod de la capete sa fie in
                if(i < j && relatii[i][j] == 1){                                      // acoperire". 
                    o << greutate << " " << i + 1 << " " << j + 1 << " 0\n";
                }
            }
        }


        for(i = 0; i < nr_familii; i++){
            free(relatii[i]);                   // Se fac clauzele soft pentru minimazarea nodurilor
            o << "1 -" << i + 1 << " 0\n";      // din acoperire.
        }


        free(relatii);                      // Se dezaloca memorie pentru matricea de relatii.
    }

    void decipher_oracle_answer() {
        int i;
        std::ifstream f(oracle_out_filename);

        f >> nr_familii;            // Se citeste raspunsul oracolului si se aloca memorie pentru
        f >> i;                                                     // vectorul de solutii.
        variabile_finale = (int*) malloc(nr_familii *sizeof(int));

        for(i = 0; i < nr_familii; i++){
            f >> variabile_finale[i];
        }
    }

    void write_answer() override {
        int i;
        std::ofstream o (out_filename);

        for(i = 0; i < nr_familii - 1; i++){        // Se scriu in fisier familiile care trebuiesc
            if(variabile_finale[i] > 0){            // arestate.
                o << variabile_finale[i] << " ";
            }
        }

        if(variabile_finale[i] > 0)
            o << variabile_finale[i];

        free(variabile_finale);                    // Se elibereaza memorie din vectorul de solutii.
    }
};

#endif  // BONUS_H_
