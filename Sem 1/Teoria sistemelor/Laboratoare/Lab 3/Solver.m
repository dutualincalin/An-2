% Pe langa functionalitatile cerute, am zis ca ar fi necesar sa afisez si
% graficele la exercitiile 1,2 si 5. Trebuie doar sa se ruleze, iar
% graficele vor fi afisate automat.

classdef Solver
    methods
        % 1
        function T = solve_1(self)
        % Find the parameter T of a first-order transfer function
        % with k = 1000 and settling time of 0.4 seconds on impulse
            s = tf('s');
            k = 10000;
            t_settle = 0.4;
            T = t_settle/4;
            H = k/(1 + T*s);
            figure;
            subplot(1,3,1);
            step(H);
            title('Ex 1: H');
            xlabel('timp');
            ylabel('Amplitudine');
            legend('H');
        end
        
% Explicatii: 
% y_t <= 2% * y_p ==> K * e^(-t/T) <= 2/100 * K ==> e^(-t/T) <= 1/50 ==>
% -t/T <= ln(1/50) ==> -t/T <= -3.91 ==> t >= T*3.91, deci prin aproximare
%  t ~ 4*T. De asemenea, daca K creste de 10 ori T nu are nevoie de
%  schimbari deoarece relatia fata de timpul de tranzitie este independenta
%  de alte variabile.
        

        % 2
        function w = solve_2(self)
        % Find the w parameter of a second-order transfer function
        % with zeta = 0.2 and a peak time of 0.4 seconds on step
            s = tf('s');
            z = 0.2;
            t_peak = 0.4;
            w = pi /(t_peak * sqrt(1 - z^2));
            H = w^2/(s^2 + 2*z*w*s + w^2);
            subplot(1,3,2);
            step(H);
            title('Ex 2: H');
            xlabel('timp');
            ylabel('Amplitudine');
            legend('H');
        end
        
% Explicatii:
% Se foloseste formula t_c = pi / (wn * sqrt(1 - tzeta^2)).
% Daca tzeta devine 0 atunci w_n = w_d ==> raspunsul este oscilant de
% amplitudine constanta. Cu cat tzeta creste, cu atat raspunsul final se
% amortizeaza mai mult pana cand tzeta ajunge la 1, caz in care avem
% raspuns aperiodic.
        
        % 3
        function t_rise = solve_3(self, w, zetas)
        % Compute the rise times of a second-order function
        % with given w for each value zeta in zetas
            s = tf('s');
            t_rise = zeros(1, length(zetas));
            for i = 1:length(zetas)
                t_rise(i) = (pi - atan(sqrt(1 - zetas(i) ^ 2)/zetas(i))) / (w * sqrt(1 - zetas(i) ^ 2));
            end
        end

% Explicatii:
% Se foloseste formula:
% t_rise = (pi - atan(sqrt(1 - zeta^2))) / (w * sqrt(1 - zeta^2))
        
        % 4
        function overshoots = solve_4(self, w, zetas)
        % Compute the overshoots of a second-order function
        % with given w for each value zeta in zetas
        % (don't convert to percents)
            s = tf('s');
            overshoots = zeros(1, length(zetas));
            for i = 1:length(zetas)
                overshoots(i) = exp(1)^((-1)*zetas(i)*pi/(sqrt(1 - zetas(i)^2)));
            end
        end
   
% Explicatii:
% Se foloseste formula: 
% overshoot = e^(-zeta*pi / sqrt(1 - zeta^2)).
        
        % 5
        function t_stationary = solve_5(self)
        % Compute the time it takes for the Iron Man suit to stop.
        % Time and input are provided.
            s = tf('s');
            w = 12;
            z = 0.2;
            H = w^2 / (s^2 + 2*w*z*s + w^2);
            t = [0:0.1:10];         % Use this time vector
            u = [t <= 3] - [t > 3]; % Use this as input
            y = lsim(H, u, t);
            subplot(1,3,3);
            plot(y);
            title('Ex 3: y');
            xlabel('timp(seconds)');
            ylabel('Raspunsul');
            legend('y');

            for i = 1:length(y)
                if (t(i) > 3)
                    if(y(i) < 0)
                        t_stationary = t(i);
                        break;
                    end
                end
            end
        end
        
% Explicatii: 
% Se calculeaza raspunsul y si apoi se verifica dupa cele 3 secunde
% cand se face o schimbare de semn atunci, in acel mic interval
% stim ca y ia valoarea 0. Valoarea aproximativa a timpului va fi
% returnata in t_stationary.
        
    end
end