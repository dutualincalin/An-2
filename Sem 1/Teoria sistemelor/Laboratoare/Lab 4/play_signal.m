function play_signal(y, fs)
    p = audioplayer(y, fs);
    playblocking(p);
end

