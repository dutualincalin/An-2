:- ensure_loaded('points3.pl'). 
:- ensure_loaded('utils.pl').
:- ensure_loaded('tester.pl').
:- ensure_loaded('input.pl').
:- ensure_loaded('solutie.pl').
:- ensure_loaded('integrame.pl').



tt(intrebari, [
       exp("integrama(0, W), intrebari(W, Q)",
           [set('Q', [((1, 1), 'Negativ', j, 0),
                      ((1, 1), 'Afirmativ', d, 1),
                      ((0, 2), 'Al doilea număr', j, 2),
                      ((0, 3), 'Primii 3 din artă', j, 3),
                      ((2, 0), 'Din care plouă', d, 4),
                      ((3, 0), 'Când nu îmi amintesc', d, 5)])]),
       exp("integrama(1, W), intrebari(W, Q), length(Q, N)", ['N', 9]),
       exp("integrama(2, W), intrebari(W, Q), length(Q, N)", ['N', 23]),
       exp("integrama(3, W), intrebari(W, Q), length(Q, N)", ['N', 10]),
       exp("integrama(2, W), id_intrebare(W, 'Cu Heliu', X)", ['X', 13]),
       exp("integrama(2, W), id_intrebare(W, X, 17)", ['X', 'Primele vocale'])
   ]).

tt(intrebari_nsol, [
       nsl("(integrama(0, W), intrebari(W, Q))", 'W', 1),
       nsl("(integrama(1, W), intrebari(W, Q))", 'W', 1),
       nsl("(integrama(2, W), intrebari(W, Q))", 'W', 1),
       nsl("(integrama(3, W), intrebari(W, Q))", 'W', 1)
   ]).

tt(completare, [
       exp("integrama(0, W), W = integ(A, B, C, D),
            completare(W, [('Afirmativ', 'DA')],
                                integ(A1, B1, C1, D1)),
            testSetMinus(C1, C, CDif), length(C1, N)",
          ['A1', val('A'), 'B1', val('B'), 'D1', val('D'),
           'N', 19, set('CDif', [((1, 2), 'D'), ((1, 3), 'A')])]),
       exp("integrama(0, W), W = integ(A, B, C, D),
            completare(W, [('Afirmativ', 'DA'),
                                    ('Al doilea număr', 'DOI'),
                                    ('Primii 3 din artă', 'ART'),
                                    ('Din care plouă', 'NOR')],
                                integ(A1, B1, C1, D1)),
            length(C1, N)",
          ['A1', val('A'), 'B1', val('B'), 'D1', val('D'),
           'N', 24]),
       exp("integrama(2, W), solutie(2, Sol),
           completare(W, Sol, integ(_, _, L, _)),
           length(L, N)",
           ['N', 108]),
       exp("integrama(2, W), solutie(2, Sol),
           completare(W, Sol, integ(_, _, L, _)),
           findall((X, Y), (member(((Y, X), C), L),
                            C \\= x, (X > 7 ; Y > 10)), Out)",
           ['Out', []])
   ]).

tt(completare_nsol, [
       nsl("(integrama(0, W), solutie(0, Sol),
           completare(W, Sol, W2))", 'W2', 1),
       nsl("(integrama(1, W), solutie(1, Sol),
           completare(W, Sol, W2))", 'W2', 1),
       nsl("(integrama(2, W), solutie(2, Sol),
           completare(W, Sol, W2))", 'W2', 1)
   ]).

tt(lungime, [
       exp("integrama(1, W), lungime_spatiu(W, '24 de ore', Lungime)",
           ['Lungime', 2]),
       exp("integrama(1, W), lungime_spatiu(W, 'Secetos', Lungime)",
           ['Lungime', 4]),
       exp("integrama(1, W), lungime_spatiu(W, 'ABCDEFG...', Lungime)",
           ['Lungime', 7]),
       exp("integrama(2, W), lungime_spatiu(W, 'Paravan pentru ploaie', Lungime)",
           ['Lungime', 7]),
       exp("integrama(2, W), lungime_spatiu(W, 'Scâncet', Lungime)",
           ['Lungime', 2]),
       exp("integrama(2, W), lungime_spatiu(W, 'Reptilă amazoniană', Lungime)",
           ['Lungime', 3]),
       exp("integrama(2, W), lungime_spatiu(W, 'de teracotă', Lungime)",
           ['Lungime', 4]),
       exp("integrama(2, W), lungime_spatiu(W, 'ionatan', Lungime)",
           ['Lungime', 3]),
       exp("integrama(3, W), lungime_spatiu(W, 'Mâncarea preferată a lui Popeye Marinarul', Lungime)",
           ['Lungime', 6]),
       exp("integrama(3, W), lungime_spatiu(W, 'Piatră prețioasă verde', Lungime)",
           ['Lungime', 7])
       ]).
tt(lungime_nsol, [
       nsl("(integrama(1, W), lungime_spatiu(W, '24 de ore', L))",
           'L', 1),
       nsl("(integrama(1, W), lungime_spatiu(W, 'Secetos', L))",
           'L', 1),
       nsl("(integrama(2, W), lungime_spatiu(W, 'Reptilă amazoniană', L))",
           'L', 1),
       nsl("(integrama(3, W), lungime_spatiu(W, 'Piatră prețioasă verde', L))",
           'L', 1),
       nsl("(integrama(0, W), lungime_spatiu(W, Q, X))", '(Q, X)', 6),
       nsl("(integrama(0, W), lungime_spatiu(W, Q, 3))", 'Q', 4),
       nsl("(integrama(1, W), lungime_spatiu(W, Q, X))", '(Q, X)', 9),
       nsl("(integrama(1, W), lungime_spatiu(W, Q, 3))", 'Q', 2),
       nsl("(integrama(1, W), lungime_spatiu(W, Q, 4))", 'Q', 2)
   ]).

tt(intersectie, [
       exp("integrama(1, W),
           intersectie(W, '24 de ore', Pos1,
                       'Secetos', Pos2)",
           ['Pos1', 1, 'Pos2', 2]),
       exp("integrama(1, W),
           intersectie(W, 'Ingineria Calculatoarelor', Pos1,
                       'Buchet de', Pos2)",
           ['Pos1', 0, 'Pos2', 4]),
       exp("integrama(1, W),
           intersectie(W, 'Teoria Sistemelor', Pos1,
                       'ABCDEFG...', Pos2)",
           ['Pos1', 0, 'Pos2', 6]),
       exp("integrama(2, W),
           intersectie(W, 'Paravan pentru ploaie', Pos1,
                       'ionatan', Pos2)",
           ['Pos1', 1, 'Pos2', 0]),
       exp("integrama(2, W),
           intersectie(W, 'Reptile care sâsâie', Pos1,
                       'Primele vocale', Pos2)",
           ['Pos1', 1, 'Pos2', 1]),
       exp("integrama(2, W),
           intersectie(W, 'Cu Heliu', Pos1,
                       'Cea mai puțin puternică piesă de șah', Pos2)",
           ['Pos1', 3, 'Pos2', 2]),
       exp("integrama(2, W),
           intersectie(W, 'Cea mai puțin puternică piesă de șah', Pos1,
                       'Cu Heliu', Pos2)",
           ['Pos1', 2, 'Pos2', 3]),
       exp("integrama(3, W),
           intersectie(W, 'Mâncarea preferată a lui Popeye Marinarul', Pos1,
                       'de spectacole', Pos2)",
           ['Pos1', 0, 'Pos2', 0]),
       exp("integrama(3, W),
           intersectie(W, 'de spectacole', Pos1,
                       'Diodă luminiscentă', Pos2)",
           ['Pos1', 2, 'Pos2', 0]),
       uck((integrama(2, W),
           intersectie(W, 'Sora mărului', _, 'Primele litere din alfabet', _))),
       uck((integrama(2, W),
           intersectie(W, 'Sora mărului', _, 'de teracotă', _))),
       uck((integrama(2, W),
           intersectie(W, 'Sora mărului', _, 'Piure, prăjit, la cuptor', _)))
   ]).
tt(intersectie_sols, [
       nsl("(integrama(2, W), id_intrebare(W, T, 19),
            intersectie(W, T, X, T2, Z))", "(X, T2, Z)", 5),
       nsl("(integrama(2, W), id_intrebare(W, T, 0),
            intersectie(W, T, X, T2, Z))", "(X, T2, Z)", 4),
       nsl("(integrama(2, W), id_intrebare(W, T, 15),
            intersectie(W, T, X, T2, Z))", "(X, T2, Z)", 3),
       nsl("(integrama(0, W), intersectie(W, A, B, C, D))",
           "(A, B, C, D)", 16),
       nsl("(integrama(1, W), intersectie(W, A, B, C, D))",
           "(A, B, C, D)", 14),
       nsl("(integrama(2, W), intersectie(W, A, B, C, D))",
           "(A, B, C, D)", 70),
       nsl("(integrama(3, W), intersectie(W, A, B, C, D))",
           "(A, B, C, D)", 24)
   ]).

tt(candidates, [
       exp("integrama(0, W), solutii_posibile(W, Sols), intrebari(W, QL),
            W = integ(_, _, Lista, Dict), length(Sols, N)",
           ['N', 6]),
       ech("integrama(0, W), solutii_posibile(W, Sols), intrebari(W, QL),
            W = integ(_, _, Lista, Dict), member((Q, QS), Sols)",
           ['member((_, Q, _, _), QL)']),
       ech("integrama(0, W), solutii_posibile(W, Sols),
            member((Q, QS), Sols),
            Q \\= 'Afirmativ', Q \\= 'Negativ', member(Sol, QS)",
           ['length(Sol, N), N == 3']),
       ech("integrama(0, W), solutii_posibile(W, Sols),
            member((Q, QS), Sols), Q \\= 'Afirmativ', Q \\= 'Negativ'",
           ['length(QS, N), N == 4']),
       exp("integrama(1, W), solutii_posibile(W, Sols), intrebari(W, QL),
            W = integ(_, _, Lista, Dict), length(Sols, N)",
           ['N', 9]),
       ech("integrama(1, W), solutii_posibile(W, Sols), intrebari(W, QL),
            W = integ(_, _, Lista, Dict), member((Q, QS), Sols)",
           ['member((_, Q, _, _), QL)']),
       ech("integrama(1, W), solutii_posibile(W, Sols),
            member(('Buchet de', QS), Sols), member(Sol, QS)",
           ['length(Sol, N), N == 5'])
   ]).

tt(rezolvare, [
       wait, exp("integrama(1, W), rezolvare(W, Rezultat), solutie(1, Sol)",
           [set('Rezultat', val('Sol'))]),
       wait, exp("integrama(2, W), rezolvare(W, Rezultat), solutie(2, Sol)",
           [set('Rezultat', val('Sol'))]),
       wait, exp("integrama(3, W), rezolvare(W, Rezultat), solutie(3, Sol)",
           [set('Rezultat', val('Sol'))])
   ]).

tt(stress_test, [
       wait,
       exp("make_stress(1, W), rezolvare(W, Rezultat), solutie(1, Sol)",
           [set('Rezultat', val('Sol'))]),
       wait,
       exp("make_stress(2, W), rezolvare(W, Rezultat), solutie(2, Sol)",
           [set('Rezultat', val('Sol'))]),
       wait,
       exp("make_stress(3, W), rezolvare(W, Rezultat), solutie(3, Sol)",
           [set('Rezultat', val('Sol'))])
   ]).

tt(sols, [
       wait, nsl("(integrama(0, W), rezolvare(W, Rezultat))", 'Rezultat', 2),
       wait, nsl("(integrama(1, W), rezolvare(W, Rezultat))", 'Rezultat', 1),
       wait, nsl("(integrama(2, W), rezolvare(W, Rezultat))", 'Rezultat', 1),
       wait, nsl("(integrama(3, W), rezolvare(W, Rezultat))", 'Rezultat', 1)
   ]).


make_stress(ID, integ(H, W, List, Dict)) :-
        integrama(ID, integ(H, W, List, DictOrig)),
        stress_test(Lst),
        append(Lst, DictOrig, NewDict),
        sort(NewDict, Dict).

make_stress2(ID, integ(H, W, List, Dict)) :-
        integrama(ID, integ(H, W, List, DictOrig)),
        words2a(3, Lst),
        append(Lst, DictOrig, NewDict),
        sort(NewDict, Dict).



