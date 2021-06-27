% README: Scrieti in consola Lab2. Dupa rularea comenzilor vor aparea
% graficele intr-o fereastra noua si rezolvarile cerintelor 1 si 2
% in consola. Raspunsul la exercitiul 3 se afla la finalul sectiunii
% exercitiului 3.

% Dutu Alin Calin
% 323 CD

function Lab2
    % Exercitiul 1
    
    H = tf(100,[2 1]);
    % H = 100/(2s+1)
    
    if(isstable(H) == 1)
        disp("1) Sistemul este stabil pentru ca nu are poli pozitivi, are doar polul negativ:");
        disp(pole(H));
        
    else
        disp("1) Sistemul este instabil deoarece are pol pozitiv");
    
    end
    
    
    % Exercitiul 2
    
    Hp = zpk([],[-0.5 2],100);
    % Hp = H' = 100/(2s - 1)(s - 2)
    % adaugam un pol pozitiv pentru a destabiliza sistemul
    
    disp("2) Adaug (s-2) la numitor pentru a destabiliza sistemul. Polii lui H' sunt:");
    disp(pole(Hp)');
    
    
    % Exercitiul 3
    
    figure;
    subplot(2,2,1);
    step(H);
    title('Ex 3: Raspunsul propulsorului stabil (H)');
    xlabel('timp');
    ylabel('Amplitudine')
    legend('H');
    
    subplot(2,2,2);
    step(Hp);
    title('Ex 3: Raspunsul propulsorului instabil (H'')');
    xlabel('timp');
    ylabel('Amplitudine');
    legend('H''');
    
    % Conform graficului pentru H' Iron Man ar sta vreo 20 de secunde
    % pana cand propulsorul va incepe sa aiba un raspuns, in urmatoarele
    % 10 secunde raspunsul va creste exponential si va fi atat de puternic
    % incat Iron Man va trece cu siguranta de atmosfera :)).
    
    
    %Exercitiul 4
    
    subplot(2,2,3);
    impulse(H);
    title('Ex 4: Raspunsul propulsorului folosit ofensiv');
    xlabel('timp');
    ylabel('Amplitudine');
    legend('H');
    
    
    %Exercitiul 5
    
    t = 0:0.01:10;
    u = zeros(1,length(t));
    
    % Se creeaza impulsul u conform cerintei 
    for i = 1:length(t)
        if t(i) > 0
            if t(i) < 1
                u(i) = 1;
            end
        end
        
        if t(i) > 2
            if t(i) < 3
                u(i) = 1;
            end
        end
        
        if t(i) > 4
            if t(i) < 5
                u(i) = 1;
            end
        end
    end
    
    subplot(2,2,4);
    lsim(H,u,t);
    title('Ex 5: Raspuns propulsor pornit si oprit succesiv');
    xlabel('timp');
    ylabel('Amplitudine');
    legend('H');
    
    sgtitle('Grafice');
end