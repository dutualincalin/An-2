# Tema 2 AA

Nume: Dutu Alin Calin
Grupa: 323CD

## Introducere

Aceasta este rezolvarea temei 2 la Analiza Algoritmilor din anul universitar 
2020 - 2021.

## Cerinte si rezolvari

### Task 1

#### Metoda reducerii

Din enuntul problemei se poate deduce ca se poate aplica pe aceasta problema
k - colorare, unde nodurile sunt familiile si culorile sunt spionii. Stiind ca
oracolul este defapt SAT - solver, inseamna ca se va face reducerea problemei 
k - colorare la SAT.  

#### Codificare

Pentru codificare se va folosi o matrice in care liniile sunt familiile si 
coloanele sunt spionii. Teoretic, o variabila din aceasta matrice este de tip 
x_ij si se codifica cu propozitia: "Spionul j+1 este repartizat familiei i+1". 
Fiecare familie va avea un numar de variabile egal cu numarul spionilor. 

Pentru a putea folosi oracolul va trebui sa dam valori acestor variabile de 
codificare si se vor atribui in felul urmator: Pe linie avem x_00 = 1,
x_01 = 2, x_02 = 3 si asa mai departe, iar pe coloana x_10 = 1 + nr_spioni, 
x_20 = 1 + 2*nr_spioni, x_30 = 1 + 3*nr_spioni si asa mai departe.

#### Fisierul CNF

Pentru crearea fisierului CNF este nevoie si de creearea unor clauze care vor
ajuta oracolul sa aleaga solutia corecta. Pentru crearea clauzelor trebuie sa
se raspunda la urmatoarele propozitii: 
1) O familie poate avea un spion si numai unul;
2) Un spion poate fi trimis la 2 familii atata timp cat ele nu se inteleg;
3) Acelasi spion nu poate fi trimis la 2 familii care se inteleg;

Avand matricea codificarilor, pentru prima propozitie se va face pentru fiecare
familie(linie din matrice) sau-logic cu toate varibilele liniei asa cum sunt.

Pentru a doua propozitie pentru fiecare familie se iau toate variabilele si fac
clauze de cate 2 in toate combinatiile posibile sub forma "!x V !y".

Pentru ultima propozitie se iau nodurile muchiilor din graf si se creeaza
clauze luand de pe liniile corespunzatoare:"!x V !y" cu precizarea ca x si y
trebuie luate de pe aceeasi coloana deoarece ne referim la acelasi spion.

#### Interpretarea solutiei

Dupa apelarea oracolului se va genera fisierul solutie care contine valorile
matricei de codificare, insa unele din ele sunt pozitive, altele sunt negative.
Interpretarea solutiei este urmatoarea: Valoarea negativa inseamna ca propozitia
pe care o codifica este falsa, iar pentru valoare pozitiva, propozitia pe care o
codifica este adevarata. Avand acest rationament se observa ca fiecare familie
are cate un spion, iar verificand si celelalte constrangeri se observa
validitatea solutiei.

#### Complexitati

- Read_problem_data - avem complexitate θ(nr_familii * nr_spioni) din cauza 
celor 2 for-uri de la liniile 59 - 62.
- Formulate_oracle_question - avem complexitate θ(nr_familii * nr_spioni *
log(nr_spioni)) datorita secventei de la liniile 80 - 88.
- decipher_oracle_answer - θ(nr_variabile_finale) avand doar un for la 
linia 127.
- write_answer - θ(nr_variabile_finale * nr_spioni) de la liniile 142 - 143.

### Task 2

#### Metoda reducerii

Se poate asocia aceasta problema cu k - clica, deci pentru rezolvarea acestei 
cerinte este nevoie sa se faca o reducere de la k - clica la SAT.

#### Codificare

Pentru codificari se va crea o matrice a caror linii reprezinta numarul 
familiei, iar coloane reprezinta numarul familiei in clica. De exemplu pentru
x_ij avem propozitia "Familia i+1 este a j+1 familie din clica".

Pentru folosirea oracolului este nevoie de o codificare numerica care va fi
facuta in felul urmator: x_00 = 1, x_01 = 2, ..., x_10 = 1 + k, ...,
x_20 = 1 + 2*k, etc..

#### Fisierul CNF

Pentru fisierul CNF e nevoie de crearea clauzelor pentru k-clica.
Acestea trebuie sa respecte urmatoarele principii:
1) Un singur nod poate fi al i-lea nod;
2) Niciun nod nu poate fi si al i-lea si al j-lea nod in acelasi timp;
3) Daca intre 2 noduri nu exista o muchie atunci cele 2 noduri nu pot fi in
aceeasi muchie.

Pentru prima propozitie se va face cate o clauza de sau-logic cu toate
codificarile asa cum sunt pentru fiecare linie.

Pentru a doua propozitie se va face cate o clauza cu toate combinatiile
variabilelor pentru fiecare linie. Clauzele vor avea forma "!x V !y".

Pentu a 3-a propozitie trebuie luate toate muchiile grafului si avand nodurile
care nu au legatura se vor face pentru fiecare legatura un numar de clauze dupa
urmatoarea formula: Pentru oricare k != l si i < j se vor scrie clauze de forma
!x_ik V !x_jl, unde i, j reprezinta numarele familiilor si k si l pozitia 
familiei in clica.

#### Interpretarea solutiei

Dupa apelarea oracolului se va genera fisierul solutie care contine valorile
matricei de codificare, insa unele din ele sunt pozitive, altele sunt negative.
Interpretarea solutiei este urmatoarea: Valoarea negativa inseamna ca propozitia
pe care o codifica este falsa, iar pentru valoare pozitiva, propozitia pe care o
codifica este adevarata. Avand acest rationament se observa care sunt familiile
din clica si care este pozitia lor in clica, iar verificand si celelalte
constrangeri se observa validitatea solutiei.

#### Complexitati

- Read_problem_data - avem complexitate θ(nr_familii^2) din cauza 
celor 2 for-uri de la liniile 48 - 50 pentru cazul in care nr_familii > 
dim_extindere si θ(nr_familii * dim_extindere) din cauza celor 2 for-uri de la
liniile 64 - 67 in caz contrar.
- Formulate_oracle_question - avem complexitate θ(nr_familii * log(nr_familii)*
dim_extindere^2) datorita secventei de la liniile 111 - 118.
- decipher_oracle_answer - θ(nr_variabile) avand doar un for la linia 151.
- write_answer - θ(nr_variabile_finale * nr_spioni) de la liniile 165 - 166.

### Task 3

#### Metoda reducerii

Pentru eliminarea retelei de mafioti asa cum este specificat in cerinta este
clar ca problema data se rezolva cu o reducere de la Vertex-Cover la SAT, insa
conform ceriintei, este necesara folosirea task-ului 2, deci reducerea care se
va face la acest task este de la Vertex-Cover la K-clica.

#### Fisier task 2

Pentru a face aceasta reducere trebuie facut inversul grafului problemei si
pentru acest graf inversat se va face (nr_familii - k) - clica adaugand toate
datele grafului in fisierul de intrare al task-ului 2. Se vor face mai multe
cereri la oracol pana se gaseste o clica de dimensiune maxima a grafului
inversat.

#### Interpretare solutiei

Gasind cu ajutorul task-ului 2 o clica de o anume dimensiune pentru graful
invers vom scrie in fisierul de output al task-ului 3 nodurile care nu sunt
in fisierul dat de task-ul 2 deoarece in acesta se afla nodurile de la
"extrema" retelei. Daca eliminam celelalte noduri din graf atunci aceste
"extremele" raman fara legaturi. Deci solutia acestui task sunt nodurile care
nu se gasesc in fisierul de la task-ul 2.

#### Complexitatea

- read_problem_data - θ(nr_familii ^ 2) de la for-ul de la liniile 61 - 64.
- reduce_to_task2 - θ(nr_familii ^ 2) de la for-ul de la liniile 83 - 84.
- create_task2_file - θ(nr_familii ^ 2) de la for-ul de la liniile 101 - 102.
- extract_answer_from_task2 - θ(nr_familii) de la for-ul de la linia 117.
- write_answer - θ(nr_familii) de la for-ul de la linia 145.

### Bonus

#### Metoda reducerii

Fiind aceeasi ca la task-ul 3 vom face reducerea de la Vertex-Cover la SAT
folosind hard si soft clauses.

#### Fisier WCNF

Pentru crearea fisierului pentru oracol sunt necesare clauze hard si clauze
soft. Clauzele hard trebuie sa respecte propozitia "Pentru fiecare muchie,
cel putin un nod de la capete trebuie sa fie in acoperire". Clauzele soft 
se ocupa de acoperirea minima in sensul ca SAT solver incearca sa maximizeze
suma ponderilor clauzelor soft si avem nevoie sa minimizam nodurile din 
acoperire, deci este necesara sa se atribuie o pondere pentru fiecare nod
astfel incat acesta sa nu aiba valoare de adevar. Astfel se maximizeaza
nodurile care NU sunt in acoperire, adica minimizeaza nodurile care sunt in
acoperire.

Pentru clauzele hard se vor lua nodurile fiecarei muchii si se vor creea cate
o clauza cu cele doua noduri ale fiecarei muchii. Ponderea acestui tip de
clauza este suma ponderilor clauzelor soft + 1, adica numarul nodurilor + 1. 

Pentru clauzele soft se vor lua toate nodurile grafului si se vor creea 
clauze de tipul !x. Ponderea acestor clauze va fi 1.

#### Interpretarea solutiei

In raspunsul oracolului se gasesc toate nodurile. O parte din ele sunt 
pozitive, celelalte sunt negative. Nodurile pozitive sunt nodurile solutie si
ele reprezinta familiile ce trebuiesc arestate.

#### Complexitate

- read_problem_data - θ(nr_familii^2) datorita for-urilor de la liniile 43 - 46. 
- formulate_oracle_question - θ(nr_familii^2) datorita for-urilor de la liniile
 68 - 69.
- decipher_oracle_answer - θ(nr_familii) datorita for-ului de la linia 95.
- write_answer - θ(nr_familii) datorita for-ului de la linia 104.

## Bibliografie

Inainte de a face reducerile m-am documentat de la link-urile de mai jos legat
de abordarea acestor cerinte, insa progamul este scris de mine.

1.
Udacity - Reduce 3-Colorability to SAT - Intro to Algorithms
Link: https://www.youtube.com/watch?v=HhFSgXbWiWY&t

2.
Lance Fortnow - Reduction to SAT
Link: https://blog.computationalcomplexity.org/2006/12/reductions-to-sat.html

3.
Vertex-Cover -> Clique
Link: https://www.clear.rice.edu/comp487/VC_Clique.pdf

4.
Joao Marques-Silva - MaxSAT and Related Optimization Problems
Link: https://es-static.fbk.eu/events/satsmtschool12/slides/1x04_SS12.pdf

Link-urile au fost accesate ultima oara la data de 12.01.2021.
