function Ex_5
    clear all
    clc

    t = 0:0.01:60;
    h = 100./(3*exp(t/3));
    u4 = zeros(1,length(t));
    
    for i = 1:length(t)
        if t(i) >= 3
            u4(i) = 1;
        end
    end
    
    y4 = ts_continous_conv( u4,h,t );
    
    figure
    subplot(1,2,1);
    plot(t,u4);
    title('Semnalul de intrare');
    xlabel('timp(s)');
    ylabel('acc(*100%)');
    legend('semnal');
    
    subplot(1,2,2);
    plot(t,y4);
    title('Semnalul de iesire');
    xlabel('timp(s)');
    ylabel('viteza(m/s)');
    legend('semnal');
    
    sgtitle('Exercitiul 5');
    
    % Am vazut graficul format de intrarea 1(t) si de
    % raspunsul de iesire al sistemului. Diferenta dintre acele grafice si
    % graficele curente este chiar intarzierea cu 3 secunde a apasarii
    % pedalei. In concluzie, daca se intarzie raspunsul de intrare cu 
    % t secunde, raspunsul de iesire va intarzia si el tot cu t secunde.
end

    