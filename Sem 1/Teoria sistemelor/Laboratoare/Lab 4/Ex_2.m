% Surse de inspiratie: https://en.wikipedia.org/wiki/Low-pass_filter
% URL accesat la data de 4.12.2020

function Ex_2
    clear all
    
% Stim ca frecventa de cut-off, fc = 100 Hz si ca fc = 1/(2 * pi * R * C) =>
% 100 = 1/(2 * pi * R * C) => 200 * pi = 1/(R * C) => R * C = 1/(200 * pi),
% deci putem alege de exemplu perechea ( 1,5 microF, 1,06 kOhm).

    RC = 1/(200 * pi);
    s = tf('s');
    H = s * RC/(1 + s * RC);
    [y, fs] = play_file("./bass_test.wav", true);
    
    figure;
    sgtitle("Ex 2: Bode si spectrul sunetului inainte si dupa aplicarea lui H");
    
    subplot(1,3,1);
    bode(H);
    
    subplot(1,3,2);
    plot_fft(y,fs);
    
    y = apply_filter(H, y, fs);
    
    subplot(1,3,3);
    plot_fft(y, fs);
    
    play_signal(y, fs);
end