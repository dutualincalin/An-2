% O parte din acest cod a fost inspirata din fisierul l52.m creat la 
% laboratorul de TS.

% Pentru exercitiul 1 se va afisa in consola functia de transfer H, 
% valorile proprii ale matricei A_lon, polii functiei H si o valoare logica
% (1 sau 0) daca H e stabil respectiv daca nu este stabil.
function Ex
    close all
    clc
    
    % Exercitiul 1
    load('RCAM_lon.mat');
    H = ss(A_lon, B_lon, C_lon, D_lon);
    tf(H)
    
    disp("Relatia dintre polii matricei de transfer si spectrul matricei de stare A_lon");
    
    eig(A_lon)
    pole(H)
    
% Se observa egalitate intre polii lui H si valorile proprii ale lui A_lon.

% Se poate face mereu transformarea din model in pe stare în functie de
% transfer deoarece in formula H = C * ((s * I - A)^-1)* B + D matricea
% s * I - A trebuie sa fie inversabila si pare sa fie mereu inversabila.

    isstable(H)
    
% Sistemul este stabil deoarece totii polii au parte reala negativa.

    % Exercitiul 2
    xi = [2, 0, 20, 0];
    y = initial(H, xi);
    
    figure
    hold on;
    plot(y(:,1),'-r');
    plot(y(:,2),'-y');
    plot(y(:,3),'-b');
    title('Ex 2: Iesiri');
    legend('Rata de tangaj(grade)','Viteza pe OZ(m/s)', 'Viteza totala(m/s)');
    xlabel('timp(s)');
    hold off;
    
    % Exercitiul 3
    t = 0:0.01:50;
    init = double(t >= 0);
    u = [2 3]' * init;
    y = lsim(H, u, t);
    
    figure;
    hold on;
    plot(t,y(:,1),'-r');
    plot(t,y(:,2),'-y');
    plot(t,y(:,3),'-b');
    title('Ex 3: Iesirile');
    xlabel('timp(s)')
    legend('Rata de tangaj(grade)','Viteza pe OZ(m/s)', 'Viteza totala(m/s)');
    hold off;
    
    % Exercitiul 4
    y = lsim(H,u,t,xi);
    figure;
    hold on;
    plot(t,y(:,1),'-r');
    plot(t,y(:,2),'-y');
    plot(t,y(:,3),'-b');
    title('Ex 4: Iesirile');
    xlabel('timp(s)');
    legend('Rata de tangaj(grade)','Viteza pe OZ(m/s)', 'Viteza totala(m/s)');
    hold off;
    
% Pe baza graficelor se poate observa ca suma dintre raspunsul liber si
% raspunsul fortat este egala cu raspunsul total.
end