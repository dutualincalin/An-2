
% integrama/2
% integrama(+Id, integ(-H, -W, -Lista, -Vocab))
% Primind un Id de integramă, predicatul preia datele integramei în
% structura integ(H, W, Lista, Vocab) și indexează întrebările.
% W este lățimea, H este înălțimea, Lista reprezintă listă de tupluri
% de tipul (index matrice, valoare), iar Vocab este vocabularul de
% cuvinte disponibil.
% Lista din ieșire este identică cu lista din integrama
% identificată cu Id, cu diferența că
% toate celulele cu întrebări au ca valoare o listă de
% tupluri de forma (Întrebare, Direcție (j sau d), Identificator).
integrama(ID, integ(H, W, ListaIndexed, Vocab)):-
    integrama(ID, H, W, Lista, Vocab),
    index(Lista, ListaIndexed, 0).
index([(Pos, (Text, Dir)) | CC], [(Pos, [(Text, Dir, Q_ID)]) | CCI], Q_ID) :-
    !, Q_ID1 is Q_ID + 1,
    index(CC, CCI, Q_ID1).
index([(Pos, QList) | CC], [(Pos, QListRes) | CCI], Q_ID) :-
    is_list(QList), !,
    sort(2, @>=, QList, QListSort),
    index(QListSort, Q_ID, QListRes, Q_IDRes),
    index(CC, CCI, Q_IDRes).
index([(Pos, X) | CC], [(Pos, X) | CCI], Q_ID) :- index(CC, CCI, Q_ID).
index([], [], _).
index([], Q_ID, [], Q_ID).
index([(Text, Dir) | QQ], Q_ID, [(Text, Dir, Q_ID) | QQI], Q_IDOut) :-
    Q_ID1 is Q_ID + 1,
    index(QQ, Q_ID1, QQI, Q_IDOut).

% print_integrama/1
% print_integrama(integ(+H, +W, +Lista, +Dict))
% Printează o integramă, sub formă de matrice care conține 'x', '_', caractere completate
% sau numere pentru întrebari, apoi printeaza un tabel, unde fiecărei întrebări
% îi este asociată o linie cu detalii.
print_integrama(integ(H, W, Lista, _)):-
    print_cells(H, W, Lista),
    write('\n\tID\tDIRECTIE\tINTREBARE\n'),
    forall(member((_, QList), Lista),
           forall(member(Q, QList), print_question(Q))).


% Întoarce în CELL valoarea de pe poziția (ROW, COL).
get_cell(ROW, COL, LIST, CELL) :- member(((ROW, COL), CELL), LIST), !.
get_cell(_, _, _, '-').

print_q_id([(_, j, Q_ID)]):- !, format('~+~d↓~16|', [Q_ID]).
print_q_id([(_, d, Q_ID)]):- !, format('~+~d→~16|', [Q_ID]).
print_q_id([(_, _, Q_ID), (_, _, Q_ID2)]):-
    format('~+~d↓,~d→~16|', [Q_ID, Q_ID2]).

print_cell(Y):- is_list(Y), !, print_q_id(Y).
print_cell(x):- !, format('~+█~16|').
print_cell(Y):- format('~+~w~16|', [Y]).

% Printează 'x' pentru căsuța inaccesibilă, '-' pentru spațiu
% și identificatori pentru căsute care contin întrebari.
print_cells(H, W, Q_LIST):-
    NC is W - 1, NR is H - 1,
    forall(between(0, NR, ROW),
           (forall(between(0, NC, COL),
                   (get_cell(ROW, COL, Q_LIST, CELL),
                    print_cell(CELL)
                   )),
            write('\n')
           )
           ).
print_question((C, DIR, Q_ID)) :-
     write('\t'), write(Q_ID),
     write('\t'), write(DIR), write('\t\t'),
     write(C), write('\n').




