% Nume: Dutu Alin Calin
% Grupa: 323 CD

function Execute
clear all
close all
clc

% Exercitiul 1
    fprintf('Exercitiul 1\n\n')
    s = tf('s');
    H = 1 / (0.7 * s^2 + 0.1 * s + 0.3);
    
    
% Punctul a)
fprintf('a)')

% Avand in vedere forma actuala, va fi necesara o transformare a lui H
% la forma K * wn^2 / (s^2 + 2* tzeta * wn * s + wn^2), deci o se va 
% scoate ca factor comun 0.7 din numitor si se va pune la numarator. 
% Deci, H(s) = (1/7)/(s^2 + 1/7 *s + 3/7) => H(s) =  1.4285/
% (s^2 + 0.1428 * s + 0.4285). Deci aplicand formula de mai sus vom 
% avea Wn ^ 2 = 0.4285. Pulsatia naturala este:

    Wn = sqrt(0.4285);

% Tot din formula pentru sisteme de ordin 2 il vom scoate si pe tzeta.
% Se ajunge la ecuatia: 2 * tzeta * wn = 0.1428. Iar tzeta este:

    tzeta = 0.1428/(2 * Wn);
    
    fprintf('Pulsatia naturala a functiei de transfer este %d si tzeta este %d\n\n', Wn , tzeta);
    
    
% Punctul b
    fprintf('b)')
    
% Pentru stabilitate trebuie sa se calculeze polii functiei de transfer
% care se obtin egaland numitorul cu 0, adica 0.7 * s^2 + 0.1 * s + 0.3
% = 0 => delta = b ^ 2 - 4*a*c = 0.1 ^ 2 - 4 * 0.7 * 0.3 = - 0.83.
% x1,2 = (-b +/- sqrt(delta) * j)/2a = (- 0.1 +/- j * 0.911) / 2 * 0.7
% => x1 = - 0.071 + j * 0.65 si x2 = - 0.071 - j * 0.65. Se constata ca
% polii au partea reala negativa, deci se afla in C_, deci sistemul
% este stabil. Pentru verificare vom apela si functia pole(H) care
% arata rezultate identice.
    
    pole(H)
    
% Pentru suprareglaj avem formula din teorie:

    sigma = exp( - pi * tzeta / sqrt(1 - tzeta^2));
    fprintf('Suprareglajul este %d\n\n', sigma);
    
% Conform formulei precedente suprareglajul poate fi considerat o functie
% care depinde de tzeta (sigma = f(tzeta)).


% Punctul c

% Pentru a obtine amplificarea maxima trebuie ca regimul sa fie oscilant
% asta insemnand ca tzeta trebuie sa fie egal cu 0, adica pulsatia
% amortizata Wd = Wn * sqrt(1 - tzeta^2) sa fie egala cu pulsatia naturala
% (Wd = Wn), deci Wd = 6.545991e-01.

    Wd = Wn;
    t = 0:0.01:20;
    u = sin(Wd*t);
    figure;
    lsim(H,u,t);
    title('Ex 1, c): Raspunsul sistemului H la o intrare armonica sin(wt)');
    
% In grafic, graficul de culoare gri este al input-ului si cel de culoare 
% albastra este al output-ului.


% Punctul d

    figure;
    bode(H);
    title('Ex 1, d): Diagrama Bode pentru sistemul H');

% Conform diagramei Bode, sistemul H este un filtru trece jos de ordin 2
% deoarece se observa din grafic ca filtreaza frecvente mai inalte de o
% frecventa de cut-off. De asemenea se observa ca este de ordin 2 pentru ca
% se observa o mica cocoasa pe grafic care corespunde cu tzeta-ul calculat
% la punctul a).


% Exercitiul 2
fprintf('\nExercitiul 2\n\n')
A = [-51,15,8;12,10,2;-8,12,-80];
B = [0.2,0;0.4,1;0,0];
C = [1,4,0;0,15,0];
D = [0,0;0,0];
H = ss(A, B, C, D);


% Punctul a)

% Pentru aflarea numarului de stari ne putem uita la numarul de 
% linii/coloane al matricei A care este 3, deci numarul de stari este 3. 
% Pentru numarul de iesiri ne uitam la numarul de coloane al matricei b 
% care este 2, deci numarul de intrari este 2. Pentru numarul de iesiri ne
% uitam la numarul de coloane al matricei C care este 3, deci numarul de
% iesiri este 3.

    [m ,~] = size(A);
    nr_stari = m;
    
    [~ ,n] = size(B);
    nr_intrari = n;
    
    [~ ,n] = size(C);
    nr_iesire = n;


% Punctul b)
fprintf('b)')

% Pentru verificarea stabilitatii trebuie sa ne uita la valorile proprii 
% ale functiei H si sa vedem daca toate valorile sunt in C_.

    eig(H)
    
% Se observa ca o valoare nu este in C_, deci sistemul nu este stabil. In
% plus nu se poate determina un timp tranzitoriu deoarece datorita
% instabilitatii sistemul nu are regim stationar.


% Punctul c)
fprintf('c)')

% Pentru stabilirea controlabilitatii trebuie sa calculam matricea de
% controlabilitate care se calculeaza astfel:
    
    R = ctrb(A,B);
    r = rank(R);
    
% Se va verifica daca rangul matricei R este egal cu numarul starilor si in
% caz afirmativ atunci sistemul este controlabil si in caz contrar
% necontrolabil

    if (r == nr_stari)
        fprintf("Sistemul este controlabil, rangul matricei de controlabilitate fiind %d.\n", r);
    else
        fprintf("Sistemul nu este controlabil, rangul matricei de controlabilitate fiind %d.\n", r);
    end

% Pentru stabilirea observabilitatii trebuie sa calculam matricea de
% observabilitate care se calculeaza astfel:
    
    Q = obsv(A,C);
    q = rank(Q);

% Se va verifica daca rangul matricei Q este egal cu numarul starilor si in
% caz afirmativ atunci sistemul este observabil si in caz contrar 
% neobservabil.

    if (q == nr_stari)
        fprintf("Sistemul este observabil, rangul matricei de observabilitate fiind %d.\n\n", q);
    else
        fprintf("Sistemul nu este observabil, rangul matricei de observabilitate fiind %d.\n\n", q);
    end
end