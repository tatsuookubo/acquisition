function switchSpeaker(spNum) 

% spNum = speaker number
% spNum = 0 All speakers off 
% spNum = 1 Fly's left 
% spNum = 2 Fly's middle 
% spNum = 3 Fly's right 

output = [0,0,0];

% Creat digital acquisition session and add channel
dOut = daq.createSession('ni');
dOut.addDigitalChannel('Dev1','port0/line0:2','OutputOnly')

% First switch all speakers off 
dOut.outputSingleScan([0,0,0])

% Switch one speaker on 
if spNum ~= 0
    output(spNum) = 1;
    dOut.outputSingleScan(output)
end

dOut.stop;

end