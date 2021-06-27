% Returns value array and sampling frequency.
% If sound is set to true also plays the provided file.
function [y, fs] = play_file(name, sound)
  [y, fs] = audioread(name);
  
  if sound
    a = audioplayer(y, fs);
    playblocking(a);
  end
end
