function Ex_1(a,b)
    t = 0:0.01:5;
    u = zeros(1,length(t));

    for i = 1:length(t)
        if t(i) >= a 
           if t(i) <= b
            u(i) = 1;
           end
        end
    end

    figure
    plot(t,u)
    title("Exercitiul 1: Semnal de intrare dreptunghiular");
    xlabel('timp(s)');
    ylabel('acc(*100%)');
    legend('semnal');
end