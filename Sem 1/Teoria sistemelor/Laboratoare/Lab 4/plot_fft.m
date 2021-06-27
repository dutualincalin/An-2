% Plots the Single-Sided Amplitude Spectrum of a provided signal
% x axis - frequency (Hz)
% y axis - amplitude
% Arguments
%   - y - the signal
%   - fs - sampling frequency
% 
% Source - Matlab documentation
function plot_fft(y, fs, limits)
  L = length(y);
  T = 1/fs;
  t = (0:L-1)*T;
  
  Y = fft(y);
  P2 = abs(Y/L);
  P1 = P2(1:L/2+1);
  P1(2:end-1) = 2*P1(2:end-1);
  f = fs*(0:(L/2))/L;
  plot(f,P1);
  if exist('limits', 'var')
    xlim(limits)
  end
  title('Single-Sided Amplitude Spectrum')
  xlabel('f (Hz)')
  ylabel('|P1(f)|')
end
