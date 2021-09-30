// Copyright 2020
// Authors: Radu Nichita, Matei Simtinică

#ifndef TASK2_H_
#define TASK2_H_

#include "task.h"
#include <fstream>

/*
 * Task2
 * You have to implement 4 methods:
 * read_problem_data         - read the problem input and store it however you see fit
 * formulate_oracle_question - transform the current problem instance into a SAT instance and write the oracle input
 * decipher_oracle_answer    - transform the SAT answer back to the current problem's answer
 * write_answer              - write the current problem's answer
 */
class Task2 : public Task {
 private:
    int nr_familii;
    int nr_relatii;
    int dim_extindere;
    int nr_variabile;
    int **relatii;
    int **codificari;
    int *variabile_finale;
    std::string exista_solutie;

 public:
    void solve() override {
        read_problem_data();
        formulate_oracle_question();
        ask_oracle();
        decipher_oracle_answer();
        write_answer();
    }

    void read_problem_data() override {
        int i, j, number = 1, k, l;
        std::ifstream f(in_filename);

        f >> nr_familii;                    // Se citesc datele din fisiere si se aloca doua matrice
        f >> nr_relatii;                    // pentru relatiile famiilor si pentru codificari.
        f >> dim_extindere;

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

        codificari = (int**) malloc(nr_familii * sizeof(int*));

        for(i = 0; i < nr_familii; i++){
        	codificari[i] = (int*) malloc(dim_extindere * sizeof(int));

        	for(j = 0; j < dim_extindere; j++){
        		codificari[i][j] = number;
        		number++;
        	}
        }

        f.close();
    }

    void formulate_oracle_question() {
        int i, j, k, l;
        std::ofstream o(oracle_in_filename);

        int nr_clauze = dim_extindere + nr_familii * ((dim_extindere) * (dim_extindere - 1) / 2);

        for(i = 0; i < nr_familii - 1; i++){            // Se calculeaza numarul total al clauzelor.
    		for(j = i + 1; j < nr_familii; j++){
    			if(relatii[i][j] == 0){
    				nr_clauze += (dim_extindere - 1) * dim_extindere;
    			}
    		}
    	}

        o << "p cnf " << nr_familii * dim_extindere << " " << nr_clauze <<"\n";


        for(i = 0; i < dim_extindere; i++){
        	for(j = 0; j < nr_familii - 1; j++){       // Se scriu clauzele pentru unicitatea celui
        		o << codificari[j][i] << " ";          // de al i-lea nod din clica.
        	}

        	o << codificari[j][i] << " 0\n";
    	}


    	for(i = 0; i < nr_familii; i++){            // Se scriu clauze pentru propozitia:"Niciun nod
    		for(j = 0; j < dim_extindere - 1; j++){       // nu poate fi al k-lea sau al s-lea nod".
    			for (k = j + 1; k < dim_extindere; k++){
    				o << codificari[i][j] * (-1) << " " << codificari[i][k] * (-1) << " 0\n";
    			}
    		}
    	}


    	for(i = 0; i < nr_familii - 1; i++){          // Se scriu clauzele pentru propozitia: "Daca
    		for(j = i + 1; j < nr_familii; j++){      // intre 2 noduri nu exista muchie atunci ele

    			if(relatii[i][j] == 0){               // nu pot fi in aceeasi clica".
    				
    				for(k = 0; k < dim_extindere; k++){
    					for(l = 0; l < dim_extindere; l++){
    				
    						if(k != l){
    							o << codificari[i][k] * (-1) << " " << 
                                codificari[j][l] * (-1) << " 0\n";
    						}
    					}
    				}
    			}
    		}
    	}


    	o.close();

        for(i = 0; i < nr_familii; i++){        // Se elibereaza memorie pentru matricele de
            free(relatii[i]);                   // relatii si codificari.
            free(codificari[i]);
        }

        free(relatii);
        free(codificari);

    }

    void decipher_oracle_answer() {
        int i;
        std::ifstream f(oracle_out_filename);

        f >>exista_solutie;                 // Se citeste din fisierul oracolului si se aloca un
        f >> nr_variabile;                  // vector pentru variabilele de codificare.

        variabile_finale = (int*) malloc(nr_variabile * sizeof(int));

        for(i = 0; i < nr_variabile; i++){
        	f >> variabile_finale[i];
        }

        f.close();
    }

    void write_answer() override {
        int i, j;
        std::ofstream o(out_filename);

        if(exista_solutie.compare("True") == 0){   // Pentru existenta unei solutii se va afisa
        	o << "True\n";                         // valoarea de adevar "True" si toate nodurile...

        	for(i = 0; i < nr_variabile; i = i + dim_extindere){   // din clica de marime
        		for(j = 0; j < dim_extindere; j++){                // dim_extindere.
        			if(variabile_finale[i + j] > 0){
        				o << (((variabile_finale[i + j] - 1) / dim_extindere) + 1) << " ";
        				break;
        			}
        		}
        	}
        }

    	else o << "False";              // Altfel se va afisa valoarea de adevar "False".

    	o.close();
        
        free(variabile_finale);         // Se elibereaza de memorie vectorul cu codificarile finale.
    }
};

#endif  // TASK2_H_
