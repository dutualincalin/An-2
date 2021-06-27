function Ex_4
    clear all
    clc

    t = 0:0.01:60;
    h = 100./(3*exp(t/3));
    u1 = sin(100*t);
    u2 = zeros(1,length(t));
    
    for i = 1:length(t)
        if t(i)>= 0
            u2(i) = 1;
        end
    end

    u3  = u1 + u2;
    y3 = ts_continous_conv( u3,h,t );
    
    figure
    subplot(1,2,1)
    plot(t,u3);
    title('Semnalul de intrare');
    xlabel('timp(s)');
    ylabel('acc(*100%)');
    legend('semnal');
    
    subplot(1,2,2)
    plot(t,y3);
    title('Semnalul de iesire');
    xlabel('timp(s)');
    ylabel('viteza(m/s)');
    legend('semnal');
    
    sgtitle('Exercitiul 4');
    
    % Utilizand operatia de convolutie practic noi am transformat semnalul
    % de intrare reprezentat de graficul de intrare intr-un semnal de
    % iesire. Operatia de convolutie in discret este practic suma din
    % produsul functiei sistemului cu semnalul de intrare. Aceasta operatie
    % ii da practic sistemului caracterul de liniaritate.
end