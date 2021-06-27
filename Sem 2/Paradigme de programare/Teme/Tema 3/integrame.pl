:- ensure_loaded('checker.pl').

%test_mode(detailed).

% Considerăm următoarele reprezentări:
%
% O integramă este reprezentată prin structura (compusul)
% integ(H, W, Lista, Vocab), unde:
% H este înălțimea integramei
% W este lățimea integramei
% Lista este o listă de tupluri (Poz, Valoare), unde
%   Poz este un tuplu (R, C) conținând rândul și coloana (0-based)
%   Valoare este una dintre:
%     x - dacă celula este neagră (nu poate fi completată cu litere)
%     o literă, dacă celula este completată cu o literă
%     o listă de întrebări, reprezentate ca tupluri (Text, Dir, ID), cu
%       Text - un literal, textul întrebării
%       Dir - una dintre valorile j sau d, indicând direcția întrebării
%       ID - un identificator numeric al întrebării
% Vocab este o listă de literali reprezentând cuvinte disponibile
% pentru a rezolva întrebarea.
%
% În ieșirea predicatului intrebări, o întrebare este reprezentată ca
% ((R, C), Text, Dir, ID), unde
% R este rândul căsuței cu întrebarea (0-based)
% C este coloana căsuței cu întrebarea (0-based)
% Text este textul întrebării (un literal)
% Dir este j sau d, reprezentând direcția în care trebuie să fie plasat
% răspunsul (jos sau dreapta)
% ID este un identificator numeric al întrebării.

% Puteți vizualiza integramele cu:
% integrama(0, W), print_integrama(W).
% integrama(1, W), print_integrama(W).
% integrama(2, W), print_integrama(W).
% integrama(3, W), print_integrama(W).
%
% Testați cu
% vmtest.
% Testați teste individuale (vedeți predicatul tt din checker.pl) cu
% vmtest(Test).
% de exemplu cu vmtest(intrebari).


% intrebari/2
% intrebari(integ(+H, +W, +Lista, +Vocab), -Lista_intrebari)
% Este adevărat atunci când Lista_intrebari este o lista de tupluri
% ((R, C), Text, Dir, ID), fiecare tuplu corespunzând unei întrebări din
% integramă (rândul, coloana, textul întrebării, direcția (j//d),
% identificatorul).
%
% BONUS: intrebari are o singură soluție (o singură listă) pentru o
% anumită integramă.

getQinfo(_, [], []).
getQinfo(_, x, []).
getQinfo(Pos, [(Text, Dir, Id) | Q], [(Pos, Text, Dir, Id) | Res]) :- getQinfo(Pos, Q, Res).

intrebari(integ(_, _, [], _), []).
intrebari(integ(H, W, [(Pos, Q) | L], Vocab), LI) :- intrebari(integ(H, W, L, Vocab), NLI), getQinfo(Pos, Q, Res), append(Res, NLI, LI).



% id_intrebare/2
% id_intrebare(+Integ, ?Intrebare, ?Q_ID)
% Este adevărat dacă în integrama reprezentată ca integ(...), Intrebare
% este un text iar Q_ID este un identificator care corespund aceleași
% întrebări.

id_intrebare(I, Q_Text, Q_ID) :- intrebari(I, LI), member((_, Q_Text, _, Q_ID), LI).



% completare/3
% completare(+Integ, +Sol, -Integrama)
% Predicatul produce Integrama, o structură de forma integ(...),
% pornind de la Integ, în care au fost completate celule conform cu
% soluția Sol.
% Soluția este reprezentată ca o listă de perechi (Întrebare, Răspuns),
% unde Întrebarea este textul unei întrebări, iar Răspuns este un cuvânt
% de completat; ambele sunt atomi (literali).
% De exemplu, o soluție parțială pentru integrama 0 poate fi:
% [('Din care plouă', 'NOR'), ('Al doilea număr', 'DOI')]
%
% BONUS: lungime_spatiu are o singură soluție pentru o anumită
% întrebare.
% Puteți testa manual predicatul cu o interogare de forma:
% integrama(0, W), solutie(0, Sol), completare(W, Sol, W2), print_integrama(W2).

rm_dupl([], []).
rm_dupl([Q | LR], [Q | NLR]) :- \+member(Q, LR), rm_dupl(LR, NLR).
rm_dupl([Q | LR], NLR) :- member(Q, LR), rm_dupl(LR, NLR).

set_rasp([], _, _, _, []).
set_rasp([Lit | Rasp], R, C, 'j', [((R, C), Lit) | LN] ) :- NR is R + 1, set_rasp(Rasp, NR, C, 'j', LN).
set_rasp([Lit | Rasp], R, C, 'd', [((R, C), Lit) | LN] ) :- NC is C + 1, set_rasp(Rasp, R, NC, 'd', LN).

set_pos(R, C, 'j', NR, C) :- NR is R + 1.
set_pos(R, C, 'd', R, NC) :- NC is C + 1.

set_new_list([], _, []).
set_new_list([(Q_text, A) | Sol], LI, NLR) :-
	set_new_list(Sol, LI, OLR),
	atom_chars(A, Raspuns),
	member(((R, C), Q_text, Dir, _), LI),
	set_pos(R, C, Dir, NR, NC),
	set_rasp(Raspuns, NR, NC, Dir, LR),
	append(OLR, LR, NLR).

completare(I, [], I).
completare(integ(H, W, OLQ, Vocab), Sol, integ(H, W, NLQ, Vocab)) :-
	intrebari(integ(H, W, OLQ, Vocab), LI),
	set_new_list(Sol, LI, LR),
	rm_dupl(LR, NLR),
	append(OLQ, NLR, NLQ).



% lungime_spatiu/3
% lungime_spatiu(integ(+H, +W, +Lista, +Vocab), +Intrebare, -Lungime)
% pentru Bonus:
% lungime_spatiu(integ(+H, +W, +Lista, +Vocab), ?Intrebare, ?Lungime)
%
% Returnează lungimea spațiului asociat întrebării date.
% Întrebarea este indicată prin textul ei. De exemplu:
% lungime_spatiu pentru integrama 0 și întrebarea 'Al doilea număr'
% trebuie să lege Lungime la 3.
%
% BONUS: lungime_spatiu are o singură soluție pentru o anumită
% întrebare.
% Puteți testa manual predicatul cu o interogare de forma:
% integrama(0, W), id_intrebare(W, Text, 3), lungime_spatiu(W, Text, X).

get_len(H, _, H, _, _, _, 0).
get_len(_, W, _, W, _, _, 0).
get_len(R, C, _, _, _, LQ, 0) :- member(((R, C), _), LQ).
get_len(R, C, H, W, 'j', LQ, NL) :- NR is R + 1, get_len(NR, C, H, W, 'j', LQ, L), NL is L + 1, !.
get_len(R, C, H, W, 'd', LQ, NL) :- NC is C + 1, get_len(R, NC, H, W, 'd', LQ, L), NL is L + 1, !.

lungime_spatiu(integ(H, W, LQ, Vocab), Q_text, L) :-
	intrebari(integ(H, W, LQ, Vocab), LI),
	member(((R, C), Q_text, Dir, _), LI),
	set_pos(R, C, Dir, NR, NC),
	get_len(NR, NC, H, W, Dir, LQ, L).



% intersectie/5
% intersectie(integ(+H, +W, +Lista, +Voc), +I1, -Poz1, +I2, -Poz2)
% pentru Bonus:
% intersectie(integ(+H, +W, +Lista, +Voc), ?I1, ?Poz1, ?I2, ?Poz2)
%
% Pentru o integramă și două întrebări date prin textul lor (I1 și I2),
% al căror răspunsuri se intersectează, întoarce în Poz1 indicele din
% răspunsul la I1 la care este intersecția, și în Poz2 indicele din
% răspunsul la I2 la care este intersecția. Indecșii incep de la 0.
%
% De exemplu, în integrama 0:
%  █       █       2↓      3↓      █
%  █       0↓,1→   -       -       █
%  4→      -       -       -       █
%  5→      -       -       -       █
%  █       █       █       █       █
%
%  Întrebările 'Primii 3 din artă' și 'Afirmativ' (3, respectiv 1) se
%  intersectează la pozițiile 0, respectiv 2 (va fi litera A, de la
%  ART, respectiv DA).

check_intersection(R1, C1, L1, 'j', R2, C2, L2, 'd', Poz1, Poz2) :- R1 < R2, C1 > C2 ,CR1 is R1 + L1, CR1 >= R2, CC2 is C2 + L2, CC2 >= C1, Poz1 is R2 - R1 - 1, Poz2 is C1 - C2 - 1, !.
check_intersection(R1, C1, L1, 'd', R2, C2, L2, 'j', Poz1, Poz2) :- R1 > R2, C1 < C2 ,CR2 is R2 + L2, CR2 >= R1, CC1 is C1 + L1, CC1 >= C2, Poz1 is C2 - C1 - 1, Poz2 is R1 - R2 - 1, !.

intersectie(integ(H, W, LQ, Voc), I1, Poz1, I2, Poz2):-
	intrebari(integ(H, W, LQ, Voc), LI),
	member(((R1, C1), I1, Dir1, _), LI),
	member(((R2, C2), I2, Dir2, _), LI),
	set_pos(R1, C1, Dir1, NR1, NC1),
	set_pos(R2, C2, Dir2, NR2, NC2),
	get_len(NR1, NC1, H, W, Dir1, LQ, L1),
	get_len(NR2, NC2, H, W, Dir2, LQ, L2),
	check_intersection(R1, C1, L1, Dir1, R2, C2, L2, Dir2, Poz1, Poz2).



% solutii_posibile/2
% solutii_posibile(integ(+H, +W, +Lista, +Vocabular), -Solutii)
% Formează o listă Solutii, conținând perechi de forma
% (Întrebare, Cuvinte), unde
% Întrebare este textul unei întrebări din integramă, iar Cuvinte este o
% listă de cuvinte sunt din Vocabular și au lungimea corectă pentru a fi
% răspuns la întrebare. Solutii conține câte o pereche pentru fiecare
% întrebare din integramă.
% Cuvintele sunt reprezentate ca liste de atomi, fiecare atom
% având lungime 1 (o singură literă).
% De exemplu, pentru integrama 0, Solutii conține 6 perechi, două dintre
% ele fiind:
% ('Afirmativ', [['D', 'A'], ['N', 'U']])
% ('Din care plouă',
% [['N','O','R'],['A','R','T'],['U','I','T'],['D','O','I']])

get_QAL([], _, []).
get_QAL([Str | Voc], Len, [Sep_Str | QAL]) :- get_QAL(Voc, Len, QAL), string_length(Str, Len_str), Len_str =:= Len, atom_chars(Str, Sep_Str).
get_QAL([Str | Voc], Len, QAL) :- get_QAL(Voc, Len, QAL), string_length(Str, Len_str), Len_str =\= Len.

get_all_sols(_ , [], []).
get_all_sols(integ(H, W, LQ, Voc), [((R, C), Text, Dir, _) | LI], [(Text, QAL)| Sols]) :- 
	get_all_sols(integ(H, W, LQ, Voc), LI, Sols),
	set_pos(R, C, Dir, NR, NC),
	get_len(NR, NC, H, W, Dir, LQ, Len),
	get_QAL(Voc, Len, QAL).

solutii_posibile(integ(H, W, LQ, Voc), Sols) :- 
	intrebari(integ(H, W, LQ, Voc), LI),
	get_all_sols(integ(H, W, LQ, Voc), LI, Sols).



% rezolvare/2
% rezolvare(+Integ, -Solutie)
% Rezolvare produce în Solutie soluția integramei Integ. Soluția este
% reprezentată ca o listă de perechi de literali, fiecare pereche
% conținând textul unei întrebări și cuvântul (ca literal) care este
% răspunsul la întrebare.
%
% BONUS: rezolvare nu oferă soluții duplicate - numărul de soluții ale 
% predicatului este chiar numărul de completări posibile ale integramei.

check_integram(integ(_, _, [], _)).
check_integram(integ(H, W, [(Poz, _) | LP], Vocab)) :- \+member((Poz, _), LP), check_integram(integ(H, W, LP, Vocab)).

setStates([], []).
setStates([(_, Text, _, _) | Qs], [(Text, []) | States]) :- setStates(Qs, States).

initial_state(I, States, PSols) :- intrebari(I, Qs), setStates(Qs, States), solutii_posibile(I, PSols).

atom_list([], []).
atom_list([(Q, LR) | List], [(Q, R) | NewList]) :- atom_list(List, NewList), atom_chars(R, LR).

set_NS([OQ | CurrentState], (Q, A), [OQ | NextState]) :- set_NS(CurrentState, (Q, A), NextState).
set_NS([(Q, []) | CurrentState], (Q, A), [(Q, A) | CurrentState]).

next_state(I, PSols, CurrentState, NextState) :- 
	member((Q, []), CurrentState), !,
	member((Q, QS), PSols),
	member(LA, QS), \+member((_, LA), CurrentState), atom_chars(A, LA),
	atom_list(CurrentState, AL),
	completare(I, [(Q, A) | AL], NI),
	check_integram(NI),
	set_NS(CurrentState, (Q, LA), NextState).

final_state(State) :- \+member((_, []), State).

search(_, _, [State| _], Solution) :- final_state(State), !, atom_list(State, Solution).
search(I, PSols, [CurrentState | Other], Solution) :-
	next_state(I, PSols, CurrentState, NextState),
	\+member(CurrentState, Other),
	search(I, PSols, [NextState, CurrentState|Other], Solution).

rezolvare(I, Solutie) :- initial_state(I, State, PSols), search(I, PSols, [State], Solutie).