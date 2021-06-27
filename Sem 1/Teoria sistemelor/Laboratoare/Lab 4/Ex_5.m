% Sursa de inspiratie: https://en.wikipedia.org/wiki/Band-stop_filter
% Accesat la data de: 5.12.2020

function Ex_5
    clear all
    
    [y, fs] = merge_sound_files("./Terry Devine-King & Adam Drake - Rock The Halls.wav","./beep.wav", 45/50);
    
    figure;
    sgtitle("Ex 5: Bode si spectrul sunetului inainte si dupa filtrare");
    
    % Conform diagramei spectrului audio frecventa tiuitului este la
    % 16000 Hz
    
    w0 = 16000 * 2 * pi;
    wc = (16050 - 15950)* 2 * pi;
    
    s = tf('s');  
    H = (s^2 + w0^2)/(s^2 + wc*s + w0^2);
    
    subplot(1,3,1)
    bode(H);
    
    subplot(1,3,2);
    plot_fft(y,fs);
    
    play_signal(y, fs);
    
    y = apply_filter(H, y, fs);
    
    subplot(1,3,3);
    plot_fft(y,fs);
    
    play_signal(y, fs);
end