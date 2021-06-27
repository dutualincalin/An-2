function [ y ] = ts_continous_conv( u,h,t )
    dt = t(2) - t(1);

    y = conv(u,h)*dt;
    y = y(1:length(t));

end