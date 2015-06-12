function stimSet_008(exptInfo,preExptData)

% Probe off for 5 trials on for 5 trials with the same pip stimulus

%% Archive this code
archiveExpCode(exptInfo)

%% Set up and acquire with the stimulus set
numberOfStimuli = 1;
stimRan = randperm(numberOfStimuli);

pause on 
count = 1;
stimCount = 1; 
FS = stoploop('Stop Experiment');
while ~FS.Stop()
    trialMeta.stimNum = stimCount;
    stim = pickStimulus(trialMeta.stimNum);
    switchSpeaker(stim.speaker);
    if count == 1 
        fprintf(['\nMove probe to ',stim.probe,' antenna, then press Enter\n'])
        pause
    end
    acquireTrial('i',stim,exptInfo,preExptData,trialMeta);
    if count == 5
        count = 1;
        stimCount = stimCount + 1; 
    else
        count = count+1;
    end
    if stimCount == 4; 
        stimCount = 1; 
    end
end

FS.Clear() ;  % Clear up the box
clear FS ;

    function stim = pickStimulus(stimNum)
        switch stimNum
            case 1
                stim = PipStimulus;
                stim.speaker = 2;
                stim.probe = 'left';
            case 2
                stim = PipStimulus;
                stim.speaker = 2;
                stim.probe = 'off';
            case 3
                stim = PipStimulus;
                stim.speaker = 2;
                stim.probe = 'right';               
        end
    end


end
