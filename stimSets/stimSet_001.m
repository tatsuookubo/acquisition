function stimSet_001(prefixCode,expNum,flyNum,flyExpNum)

%% Archive this code
archiveExpCode(prefixCode,expNum,flyNum,flyExpNum)

%% Set up and acquire with the stimulus set 
stim = PipStimulus;
trialsPerBlock = 18;
speakerNonRan = repmat(1:3,1,6);
speakerRan = speakerNonRan(randperm(trialsPerBlock));

count = 1;
FS = stoploop('Stop Experiment');
while ~FS.Stop()
    
    stim.speaker = speakerRan(count);
    switchSpeaker(stim.speaker);
    acquireTrial(stim,prefixCode,expNum,flyNum,flyExpNum,'y');
    if count == 18
        count = 1;
        speakerRan = speakerNonRan(randperm(18));
    else
        count = count+1;
    end
end

FS.Clear() ;  % Clear up the box
clear FS ;