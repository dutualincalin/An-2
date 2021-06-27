function Ex_3
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
    
    y1 = ts_continous_conv( u1,h,t );
    y2 = ts_continous_conv( u2,h,t );
    
    u21 = zeros(1,length(t));
    
    for i = 1:length(t)
        if t(i)>= 0
            u21(i) = 0.5;
        end
    end
    
    y21 = ts_continous_conv( u21,h,t );
    
    figure
    subplot(1,2,1);
    plot(t,y1);
    title('Iesirea semnalului de intrare de tip sin(wt)');
    xlabel('timp(s)');
    ylabel('viteza(m/s)');
    legend('semnal');
    
    subplot(1,2,2);
    plot(t,y2);
    
    hold on
    plot(t,y21);
    legend('semnal(100% acc)','semnal(50% acc)')
    title('Iesirea semnalelor de intrare de tip 1(t)');
    xlabel('timp(s)');
    ylabel('viteza(m/s)');
    
    sgtitle('Exercitiul 3');
    
    % Incepand de la momentul t=0s viteza masinii creste brusc pana la 
    % momentul t~20s dupa care se indreapta spre 100m/s si 50m/s pentru 
    % cazul in care pedala se apasa pana jos respectiv pentru cazul in 
    % care se apasa la jumatate.
end