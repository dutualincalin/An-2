% Dutu Alin Calin
% 323 CD

% Acest fisier reprezinta rezolvarea laboratorului 6 din cadrul materiei
% Teoria Sistemelor. Pentru executarea acestui fisier se poate rula comanda
% "Execute" de la consola. Se vor afisa pentru exercitiile 1, 3 si 4 cate
% un panou grafic cu cate 3 grafice care descriu pozitia, viteza si
% temperatura din habitaclu a masinii (sistemului). Pe axa Ox unitatea de
% masura este in secunde, iar pe axa Oy se considera unitatile de masura
% scrise in legenda.

function Execute
clear all
close all
clc

load('CAR_TSA.mat')
t = 0:0.01:50;
init = double(t >= 0);
fprintf("INFORMATII SISTEM:\nNumarul starilor pentru acest sistem este 3.\n\n");

% Exercitiul 1

% Se adauga intrarile
u1 = 100;
u2 = 24;
u = [u1 u2]' * init;
H = ss(A, B, C, D);
y = lsim(H, u, t);

figure;
hold on;
plot(t,y(:,1),'-g');
plot(t,y(:,2),'-r');
plot(t,y(:,3),'-b');
title('Ex 1: Iesirile');
xlabel('timp(s)')
legend('Pozitia(km)','Viteza(km/h)', 'Temperatura in habitaclu(*C)');
hold off;
disp("");

% Dupa generarea si analizarea graficului se constata ca:
% Dupa 25 de secunde masina ajunge este cu 638,89 de metri mai departe fata
% de pozitia sa initiala. De asemenea, temperatura din habitaclu ajunge la
% temperatura de referinta conform senzorului din masina dupa 39, 26 de
% secunde de la momentul setarii temperaturii de referinta.


% Exercitiul 2

disp("Exercitiul 2");

% Controlabilitate
R = ctrb(A,B);
r = rank(R);

% Observabilitate
Q = obsv(A,C);
q = rank(Q);

if (r == 3)
    fprintf("Sistemul este controlabil, rangul matricei de controlabilitate fiind %d.\n", r);
else
    fprintf("Sistemul nu este controlabil, rangul matricei de controlabilitate fiind %d.\n", r);
end

if (q == 3)
    fprintf("Sistemul este observabil, rangul matricei de observabilitate fiind %d.\n\n", q);
else
    fprintf("Sistemul nu este observabil, rangul matricei de observabilitate fiind %d.\n\n", q);
end

disp("");

% Dupa rularea programului si verificarea raspunsului din consola se poate
% afirma ca sistemul este controlabil si observabil deoarece rangul
% matricelor de controlabilitate si observabilitate este egal cu numarul
% starilor sistemului care in cazul nostru este egal cu 3.


% Exercitiul 3

disp("Exercitiul 3");

Bf = [0 0; 0 0 ; 0 0.33];
H = ss(A, Bf, C, D);
y = lsim(H, u, t);

figure;
hold on;
plot(t,y(:,1),'-g');
plot(t,y(:,2),'-r');
plot(t,y(:,3),'-b');
title('Ex 3: Iesirile');
xlabel('timp(s)')
legend('Pozitia(km)','Viteza(km/h)', 'Temperatura in habitaclu(*C)');
hold off;

% Controlabilitate
R = ctrb(A,Bf);
r = rank(R);

% Observabilitate
Q = obsv(A,C);
q = rank(Q);

if (r == 3)
    fprintf("Sistemul este controlabil, rangul matricei de controlabilitate fiind %d.\n", r);
else
    fprintf("Sistemul nu este controlabil, rangul matricei de controlabilitate fiind %d.\n", r);
end

if (q == 3)
    fprintf("Sistemul este observabil, rangul matricei de observabilitate fiind %d.\n\n", q);
else
    fprintf("Sistemul nu este observabil, rangul matricei de observabilitate fiind %d.\n\n", q);
end

% Conform graficului se observa ca masina nu isi schimba viteza si automat
% nici pozitia, deci este o problema cu acceleratia masinii( Probleme la
% motor, defectiune la planetara, cineva o ciordit pneurile :)) etc.). Deci
% avem un sistem care nu este controlabil, dar observabil din cauza
% acestei defectiuni.


% Exercitiul 4

disp("Exercitiul 4");
Cf = [1 0 0; 0 1 0 ; 0 0 0];
H = ss(A, B, Cf, D);
y = lsim(H, u, t);

figure;
hold on;
plot(t,y(:,1),'-g');
plot(t,y(:,2),'-r');
plot(t,y(:,3),'-b');
title('Ex 4: Iesirile');
xlabel('timp(s)')
legend('Pozitia(km)','Viteza(km/h)', 'Temperatura in habitaclu(*C)');
hold off;

% Controlabilitate
R = ctrb(A,B);
r = rank(R);

% Observabilitate
Q = obsv(A,Cf);
q = rank(Q);

if (r == 3)
    fprintf("Sistemul este controlabil, rangul matricei de controlabilitate fiind %d.\n", r);
else
    fprintf("Sistemul nu este controlabil, rangul matricei de controlabilitate fiind %d.\n", r);
end

if (q == 3)
    fprintf("Sistemul este observabil, rangul matricei de observabilitate fiind %d.\n\n", q);
else
    fprintf("Sistemul nu este observabil, rangul matricei de observabilitate fiind %d.\n\n", q);
end

% Conform graficului se observa ca senzorul de temperatura din habitaclul 
% masinii nu schimba temperatura citita. Daca se constata ca senzorul nu
% este defect atunci sistemul de climatizare al masinii are o defectiune.
% Deci avem un sistem care nu este observabil, dar controlabil datorita 
% acestei defectiuni.

end