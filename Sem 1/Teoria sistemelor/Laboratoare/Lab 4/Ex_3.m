function Ex_3
    clear all
    
    s = tf('s');
    H = s^2/(s^2 + 62.83*s + 394800);
    
    [y, fs] = play_file("./bass_test.wav", false);
    y1 = apply_filter(H, y, fs);
    
    figure;
    sgtitle("Ex 3: Diagrama Bode pentru H1 si spectrul sunetului dupa aplicarea lui H1");
    
    subplot(1,2,1);
    bode(H);

    subplot(1,2,2);
    plot_fft(y1, fs);
    
    wn = sqrt(394800);
    zeta = 62.83/(wn*2);
    
    % Parametrul gresit in functia de transfer a lui Dorel este zeta care
    % tinde catre 0 adica tinde catre regimul de rezonanta. Pentru a rezolva
    % aceasta problema luam un zeta care sa fie cat mai aproape de 1. De
    % exemplu:
    
    zeta2 = 0.93;
    H2 = s^2 / (s^2 + 2 * zeta2 * wn * s + wn ^ 2);
    
    y2 = apply_filter(H2, y, fs);
    
    figure;
    sgtitle("Ex 3: Diagrama Bode pentru H2 si spectrul sunetului dupa aplicarea lui H2");
    
    subplot(1,2,1);
    bode(H2);

    subplot(1,2,2);
    plot_fft(y2, fs);
end