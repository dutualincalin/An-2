% Sursa de inspiratie: https://www.electronics-tutorials.ws/filter/filter_4.html
% URL accesat la data de 5.12.2020

function Ex_4
    clear all
    
    fmin = 1000;
    fmax = 5000;
    
    RC1 = 1/(2 * pi * fmax);
    RC2 = 1/(2 * pi * fmin);
    
    s = tf('s');
    Hj = 1/(RC1 * s + 1);
    Hs = s * RC2/(1 + s * RC2);
    
    k = 10^(5/20);

% Calculam functia de transfer a filtrului Band-Pass
    Hb = k * Hs * Hj;
    
    figure;
    sgtitle("Ex 4: Bode, FFT inainte si dupa aplicarea filtrului");
    
    subplot(1,3,1);
    bode(Hb);
    
    [y, fs] = play_file("./Terry Devine-King & Adam Drake - Rock The Halls.wav", true);
    
    subplot(1,3,2);
    plot_fft(y,fs);
    
    y = apply_filter(Hb, y, fs);
    
    subplot(1,3,3);
    plot_fft(y,fs);
    
    play_signal(y,fs);
    
end