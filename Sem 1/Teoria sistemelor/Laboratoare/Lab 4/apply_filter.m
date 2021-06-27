function y = apply_filter(tf, u, fs)
    t = 0:(1/fs):(10 - 1/fs);
    y = lsim(tf,u,t);
end