function [y, fs] = merge_sound_files(file1, file2, alpha)
    [y1, fs1] = play_file(file1, false);
    [y2, fs2] = play_file(file2, false);
    
    if fs1 ~= fs2
       ex = MException('ex:ex', "can't add differently sampled audio files"); 
       throw(ex);
    end
    
    y = alpha*y1 + (1-alpha)*y2;
    fs = fs1;
end

