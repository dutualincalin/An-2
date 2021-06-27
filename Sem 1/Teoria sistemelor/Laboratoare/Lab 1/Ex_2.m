function Ex_2
    clear all
    clc
    
    t = -2:0.01:5;
    u = zeros(1,length(t));

    for i = 1:length(t)
        if t(i) >= -1 
            if t(i) <= 1
                u(i) = 1 - abs(t(i));
            end
        end
    end
    
    figure
    plot(t,u)
    title("Exercitiul 2: Semnal de intrare triunghiular");
    xlabel('timp(s)');
    ylabel('acc(*100%)');
    legend('semnal');
end