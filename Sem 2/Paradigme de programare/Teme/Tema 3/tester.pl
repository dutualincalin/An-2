
%
%%% ----------------------------------------
%% ----------------------------------------
%% Tester

testtimelimit(5). % in seconds

test_points(show). % uncomment to show points in non-vmchecker mode.
%test_points(hide) :- test_mode(vmchecker); \+ test_points(show).

test_mode(detailed).
test_mode(vmchecker). % uncomment to activate the vmchecker mode.
test_mode(quickcheck) :- \+ test_mode(vmchecker).

:-dynamic(punct/2).
:-dynamic(current/1).
%:-clean.

clean :- retractall(punct(_, _)), retractall(current(_)).


% -----------------

% runs vm tests
vmtest :- checkVm.
vmcheck :- checkVm.
checkVm :-
        clean,
        findall(T:Score, (tt(T, _), vmtest(T, Score)), Results),
        findall(Score, member(_:Score, Results), Scores),
        sum_list(Scores, S),
        format('Total: ~w~n', [S]),
        clean.

% entry point (for users) for individual vm tests.
vmtest(T) :-
        vmtest(T, Score),
        format('Total: ~w.', [Score]).

% performes a vm test, outputs score.
vmtest(T, Score) :-
        once(vmpoints(T, Pts)),
        tt(T, TestList),
        tests(TestList, Pts, T, Score).

% ---------------
% general testing

% unified entry point for testing; computes fractions, computes if
% exercise is not done, and starts per-test iteration.
tests(Tests, TotalPoints, Ex, Score) :- %trace,
    total_units(Tests, TF, Ck/AllCheck, UCk/AllUCk, Others/AllOthers),
    %format('Total units: ~w~n', [TF]),
    (   ( \+ test_mode(detailed) ; test_mode(quickcheck) ),
        isNotDone(Ck/AllCheck, UCk/AllUCk, Others/AllOthers), !,
        (   Ex == none, !
        ;   ( test_mode(vmchecker), !, format("+0.00 ~10t  ") ; true ),
            format("[~w] Nerezolvat.~n", [Ex])
        ),
        Score = 0
    ;   Unit is TotalPoints / TF,
        tests(Tests, Ex, 1, Unit, 0, Score)
    ), !.
tests(_, _, Ex, _) :- failure(Ex, 'INTERN: tests/4 failed').

isNotDone(0/TC, TU/TU, 0/TO) :- (TO > 0, !; TC > 0).
% otherwise, probably done

% iterates through tests, handles test index, generates test id, adds
% points
tests([], _, _, _, Points, Points) :- !.
tests([wait|R], Ex, Idx, Unit, PointsIn, PointsOut) :- !,
    tests(R, Ex, Idx, Unit, PointsIn, PointsOut).
tests([Fraction, T|R], Ex, Idx, Unit, PointsIn, PointsOut) :-
        number(Fraction), !, test(T, Ex, Idx, Fraction, Unit, PointsIn, PointsOut1),
        tests(R, Ex, Idx+1, Unit, PointsOut1, PointsOut).
tests([T|R], Ex, Idx, Unit, PointsIn, PointsOut) :-
        test(T, Ex, Idx, 1, Unit, PointsIn, PointsOut1),
        tests(R, Ex, Idx+1, Unit, PointsOut1, PointsOut).
tests(_, Ex, _, _, _, _) :- failure(Ex, 'INTERN: tests/6 failed').

total_units([], 0, 0/0, 0/0, 0/0).
total_units([wait, P, _|R], Tot, A, B, C) :-
    number(P), !, total_units([counted|R], TotR, A, B, C), Tot is TotR + P.
total_units([wait, _|R], Tot, CO/TCO, UO/TUO, OO/TOO) :- !,
    total_units(R, TotR, CO/TCO, UO/TUO, OO/TOO), Tot is TotR + 1.
total_units([P, T|R], Tot, A, B, C) :-
    number(P), !, total_units([counted, T|R], TotR, A, B, C), Tot is TotR + P.
total_units([counted, T|R], Tot, CO/TCO, UO/TUO, OO/TOO) :- !, %trace,
    test(T, dry, dry, _, _, 0, P),
    (   ( T = chk(_), ! ; T = ckA(_, _) ), !, TA = 1,
        (   P > 0, A = 1, !; A = 0 )
    ;   TA = 0, A = 0),
    (   ( T = uck(_), ! ; T = nsl(_, _, 0) ), !, TB = 1,
        (   P > 0, B = 1, !; B = 0 )
    ;   TB = 0, B = 0),
    (   T \= chk(_), T \= ckA(_, _), T \= uck(_), T \= ech(_, _), T \= nsl(_, _, 0), !,
        TD = 1, (   P > 0, D = 1, !; D = 0 )
    ;   TD = 0, D = 0),
    total_units(R, TotR, C/TC, U/TU, O/TO), Tot is TotR,
    CO is C+A, TCO is TC+TA, UO is U+B, TUO is TU+TB, OO is O+D, TOO is TO+TD.
total_units(TT, Tot, A, B, C) :-
    !, total_units([counted|TT], TotR, A, B, C), Tot is TotR + 1.

test(T, NEx, Idx, Fraction, Unit, PointsIn, PointsOut) :-
        (   NEx == dry, !, Ex = dry, TimeLimit = 0.1
        ;   testtimelimit(TimeLimit),
            IdxI is Idx + 96, char_code(CEx, IdxI),
            (   NEx == none, !, swritef(Ex, '%w|', [CEx])
            ;   swritef(Ex, '[%w|%w]', [NEx, CEx]))
        ),
        swritef(MTime, 'limita de %w secunde depasita', [TimeLimit]),
        (   catch(
                catch(call_with_time_limit(TimeLimit, once(test(Ex, T))),
                      time_limit_exceeded,
                      except(Ex, MTime)
                     ),
                Expt,
                (   swritef(M, 'exceptie: %w', [Expt]), except(Ex, M))
            ),
            !, success(Ex, Fraction, Unit, Points),
            PointsOut is PointsIn + Points
        ; PointsOut = PointsIn).
test(_, Ex, Idx, _, _, _, _) :- failure(Ex/Idx, 'INTERN: test/7 failed').

success(dry, _, _, 1) :- !.
success(Ex, Fraction, Unit, Score) :-
    Score is Fraction * Unit,
    %format('~w ~w ~w ~w~n', [Ex, Fraction, Unit, Score]),
    (   test_mode(vmchecker), !,
        format('+~2f ~10t  ~w Corect.~n', [Score, Ex])
    ;
    (   test_points(show),
        format('~w[OK] Corect. +~2f.~n', [Ex, Score])
    ;   format('~w[OK] Corect.~n', [Ex])
    )).
failure(dry, _) :- !, fail.
failure(Ex, M) :-
        (   test_mode(vmchecker), !,
            format('+0.00 ~10t  ~w ~w~n', [Ex, M]), fail
        ;   format('~w[--] ~w~n', [Ex, M]), fail).
except(dry, _) :- !, fail.
except(Ex, M) :-
        (   test_mode(vmchecker), !,
            format('+0.00 ~10t ~w Exception: ~w~n', [Ex, M]), fail
        ;   format('~w[/-] ~w~n', [Ex, M]), fail).

test(Ex, chk(P)) :- !, testCall(Ex, P).
test(Ex, uck(P)) :- !, testCall(Ex, \+ P).
test(Ex, exp(Text, ExpList)) :- !,
    read_term_from_atom(Text, P, [variable_names(Vars)]),
    testCall(Ex, P, Text), testExp(Ex, Text, Vars, ExpList).
test(_, ckA(_, [])) :- !.
test(Ex, ckA(Pred, [Test|Tests])) :- !,
    swritef(S, '%w(%w)', [Pred, Test]),
    read_term_from_atom(S, P, []),
    testCall(Ex, P, S), test(Ex, ckA(Pred, Tests)).
test(_, ech(_, [])) :- !.
test(Ex, ech(Text, [Cond|Conds])) :- !,
    swritef(S, '%w|%w', [Text, Cond]),
    read_term_from_atom(S, P|Q, [variable_names(Vars)]),
    forall(P, (
               swritef(Msg, '%w pentru soluția %w a predicatului %w', [Cond, Vars, Text]),
               testCall(Ex, Q, Msg))),
    test(Ex, ech(Text, Conds)).
test(Ex, nsl(Text, Tmplt, N)) :- !,
    swritef(S, 'findall(%w, %w, TheList)', [Tmplt, Text]),
    read_term_from_atom(S, P, [variable_names(Vars)]),
    testCall(Ex, P, S), testNSols(Ex, Text, Vars, N).
test(Ex, sls(Text, Tmplt, Sols)) :- !,
    swritef(S, 'findall(%w, %w, TheList)', [Tmplt, Text]),
    read_term_from_atom(S, P, [variable_names(Vars)]),
    testCall(Ex, P, S), testSols(Ex, Text, Vars, Sols).
test(Ex, sSO(Text, Tmplt, Sols)) :- !,
    swritef(S, 'setof(%w, %w, TheList)', [Tmplt, Text]),
    read_term_from_atom(S, P, [variable_names(Vars)]),
    testCall(Ex, P, S), testSols(Ex, Text, Vars, Sols).
test(Ex, _) :- failure(Ex, 'INTERN: Test necunoscut').

% Pentru exercițiul Ex, evaluează clauza Do, dată ca termen.
% Opțional, în mesajul de eroare interogarea poate fi afișată ca
% parametrul Text.
testCall(Ex, Do) :- swritef(Text, '%q', [Do]), testCall(Ex, Do, Text).
testCall(Ex, Do, Text) :-
        catch((call(Do), !
              ;   !, swritef(M, 'Interogarea %w a esuat.', [Text]), failure(Ex, M)
              ), Exc,
              (swritef(M, 'Interogarea %w a produs exceptie: %w', [Text, Exc]),
              except(Ex, M))
             ).

testExp(_, _, _, []) :- !.
testExp(Ex, Text, Vars, [v(Var) | Rest]) :- !,
    (   getVal(Var, Vars, V), !,
        (   var(V), !, testExp(Ex, Text, Vars, Rest) ;
            swritef(M, 'Interogarea %w leaga %w (la valoarea %w) dar nu ar fi trebuit legata.',
                    [Text, Var, V]), failure(Ex, M)
        )
    ;
    swritef(M, 'INTERN: Interogarea %w nu contine variabila %w.', [Text, Var]),
    failure(Ex, M)
    ).
testExp(Ex, Text, Vars, [set(Var, val(SetS)) | Rest]) :- !,
    (   getVal(SetS, Vars, ValSet), !,
        testExp(Ex, Text, Vars, [set(Var, ValSet) | Rest])
    ;
    swritef(M, 'INTERN: Interogarea %w nu contine variabila %w.', [Text, SetS]),
    failure(Ex, M)
    ).
testExp(Ex, Text, Vars, [set(Var, Set) | Rest]) :- !,
    (   getVal(Var, Vars, V), !,
        testSet(Ex, Text, 'intoarce', V, Set),
        testExp(Ex, Text, Vars, Rest)
    ;
    swritef(M, 'INTERN: Interogarea %w nu contine variabila %w.', [Text, Var]),
    failure(Ex, M)
    ).
testExp(Ex, Text, Vars, [setU(Var, Set) | Rest]) :- !,
    (   getVal(Var, Vars, V), !,
        testSetU(Ex, Text, 'intoarce', V, Set),
        testExp(Ex, Text, Vars, Rest)
    ;
    swritef(M, 'INTERN: Interogarea %w nu contine variabila %w.', [Text, Var]),
    failure(Ex, M)
    ).
testExp(Ex, Text, Vars, [cond(Cond) | Rest]) :- !,
    swritef(S, "(%w, %w)", [Text, Cond]),
    read_term_from_atom(S, P, []),
    (
        call(P), !, testExp(Ex, Text, Vars, Rest)
        ;
        swritef(M, 'Dupa interogarea %w conditia %w nu este adevarata.', [Text, Cond]),
        failure(Ex, M)
    ).
testExp(Ex, Text, Vars, [Var, val(ValS) | Rest]) :- !,
    (   getVal(ValS, Vars, Val), !,
        testExp(Ex, Text, Vars, [Var, Val | Rest])
    ;
    swritef(M, 'INTERN: Interogarea %w nu contine variabila %w.', [Text, ValS]),
    failure(Ex, M)
    ).
testExp(Ex, Text, Vars, [Var, Val | Rest]) :- !,
    (   getVal(Var, Vars, V), !,
        (   V == Val, !, testExp(Ex, Text, Vars, Rest) ;
            swritef(M, 'Interogarea %w leaga %w la %w in loc de %w.',
                    [Text, Var, V, Val]), failure(Ex, M)
        )
    ;
    swritef(M, 'INTERN: Interogarea %w nu contine variabila %w.', [Text, Var]),
    failure(Ex, M)
    ).
testExp(Ex, _, _, [X | _]) :- !,
        swritef(M, 'INTERN: element necunoscut pentru exp: %w', [X]),
        failure(Ex, M).
testExp(Ex, _, _, X) :- !,
        swritef(M, 'INTERN: format gresit pentru exp: %w', [X]),
        failure(Ex, M).

testNSols(Ex, Text, Vars, N) :-
    (   getVal('TheList', Vars, V), length(V, NSols), !,
        (   NSols =:= N, !
        ;   swritef(M, 'Numarul de solutii pentru %w este %w in loc de %w.',
                    [Text, NSols, N]), failure(Ex, M)
        )
    ;   failure(Ex, 'INTERNAL: nu avem variabila TheList sau aceasta nu este lista.')
    ).

testSols(Ex, Text, Vars, Sols) :-
    (   getVal('TheList', Vars, V), !,
        testSet(Ex, Text, 'are ca solutii', V, Sols)
    ;   failure(Ex, 'INTERNAL: nu avem variabila TheList sau aceasta nu este lista.')
    ).

testSetU(Ex, Text, TypeText, SetG, SetE) :- sort(SetG, SetGUnique),
    testSet(Ex, Text, TypeText, SetGUnique, SetE).
testSet(Ex, Text, TypeText, SetG, SetE) :-
    msort(SetG, SetGSorted), msort(SetE, SetESorted),
    (   SetGSorted == SetESorted, ! ;
        testSetMinus(SetG, SetE, TooMuch),
        testSetMinus(SetE, SetG, TooLittle),
        (   TooMuch == [], TooLittle == [], !,
            M1 = 'vezi duplicate'
        ;   swritef(M1, '%w sunt in plus, %w lipsesc', [TooMuch, TooLittle])
        ),
        swritef(M,
                'Interogarea %w %w %w dar se astepta %w (%w)',
                [Text, TypeText, SetG, SetE, M1]), failure(Ex, M)
    ).

testSetMinus(From, ToRemove, Result) :-
        findall(E, (member(E, From), \+ member(E, ToRemove)), Result).

getVal(Var, [Var=Val | _], Val) :- !.
getVal(Var, [_ | Vars], Val) :- getVal(Var, Vars, Val).
