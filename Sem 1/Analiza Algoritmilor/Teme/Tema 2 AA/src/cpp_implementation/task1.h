// Copyright 2020
// Authors: Radu Nichita, Matei Simtinică

#ifndef TASK1_H_
#define TASK1_H_

#include "task.h"
#include <fstream>
#include <cstring>
#include <string>

/*
 * Task1
 * You have to implement 4 methods:
 * read_problem_data         - read the problem input and store it however you see fit
 * formulate_oracle_question - transform the current problem instance into a SAT instance and write the oracle input
 * decipher_oracle_answer    - transform the SAT answer back to the current problem's answer
 * write_answer              - write the current problem's answer
 */
class Task1 : public Task {
 private:
    int nr_familii;
    int nr_relatii;
    int nr_spioni;
    int **relatii;
    int **variabile;
    int nr_var_finale;
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
        int i, j, number = 1;
        std::ifstream f(in_filename);

        f >> nr_familii;		// Se citesc datele din fisierul de intrare si se aloca memorie
        f >> nr_relatii;		// pentru matricele de relatii si codificare
        f >> nr_spioni;

        relatii = (int**) malloc(nr_relatii * sizeof(int*));

        for(i = 0; i < nr_relatii; i++){
        	relatii[i] = (int*) malloc(2 * sizeof(int));

        	f >> relatii[i][0];
        	f >> relatii[i][1];
        }

        variabile = (int**) malloc(nr_familii * sizeof(int*));

        for(i = 0; i < nr_familii; i++){
        	variabile[i] = (int*) malloc(nr_spioni * sizeof(int));

        	for(j = 0; j < nr_spioni; j++){
        		variabile[i][j] = number;
        		number++;
        	}
        }

        f.close();
    }

    void formulate_oracle_question() {
    	int i, j, k;											// Se calculeaza numarul de clauze
        int nr_clauze = nr_familii + (nr_familii * nr_spioni
        				* (nr_spioni - 1))/2 + nr_relatii * nr_spioni;

        std::ofstream o(oracle_in_filename);

        o << "p cnf " << nr_familii * nr_spioni << " " << nr_clauze <<"\n"; 
        

        for(i = 0; i < nr_familii; i++){		// Se creeaza clauzele pentru propozitia: 
        	for(j = 0; j < nr_spioni; j++){		// "O familie poate avea un spion si numai unul."
        		o << variabile[i][j] << " ";	
        	}

        	o << "0\n";

        	for(j = 0; j < nr_spioni - 1; j++){		// Aici se intampla la fel ca mai sus
        		for(k = j + 1; k < nr_spioni; k++){
        			o << variabile[i][j]*(-1) << " " << variabile[i][k]*(-1) << " 0\n";
        		}
        	}
        }

        for(i = 0; i < nr_relatii; i++){	   // Se creeaza clauze pentru propozitia:"Acelasi spion
        	for(j = 0; j < nr_spioni; j++){							    // nu poate fi trimis la 2
        		o << variabile[relatii[i][0] - 1][j] * (-1) << " " 		// familii care se inteleg"
        		<< variabile[relatii[i][1] - 1][j] * (-1) << " 0\n";
        	}
        }

        o.close();

        for(i = 0; i < nr_relatii; i++){		// Se elibereaza memorie pentru matricele de relatii
            free(relatii[i]);					// si variabile.
        }

        for(i = 0; i < nr_familii; i++){
            free(variabile[i]);
        }

        free(relatii);
        free(variabile);
    }

    void decipher_oracle_answer() {
    	int i;
    	std::ifstream f(oracle_out_filename);
    	
    	f >> exista_solutie;		// Se citeste raspunsul oracolului si se aloca memorie
    	f >> nr_var_finale;			// pentru vectorul de solutii.
    	
    	variabile_finale = (int*) malloc(nr_var_finale * sizeof(int));

    	for(i = 0; i < nr_var_finale; i++){
    		f >> variabile_finale[i];
    	}

    	f.close();
    }

    void write_answer() override {
        int i, j;
        std::ofstream o(out_filename);

        if(exista_solutie.compare("True") == 0){		// Daca exista solutie se scrie in output
        	o << "True\n";								// valoarea de adevar "True" alaturi de ...

        	for(i = 0; i < nr_var_finale; i = i + nr_spioni){	// numarul spionilor in ordinea
        		for(j = 0; j < nr_spioni; j++){					// familiilor pe care ii spioneaza.
        			if(variabile_finale[i + j] > 0){
        				o << (((variabile_finale[i + j] -1) % nr_spioni) + 1) << " ";
        				break;
        			}
        		}
        	}
        }

    	else o << "False";			  // In caz contrar se va scrie doar valoarea de adevar "False".

    	o.close();

        free(variabile_finale);			// Se elibereaza memoria vectorului de solutii.
    }
};

#endif  // TASK1_H_
