function twoPhotonStimSet_001(trialMeta)

% Probe experiment
%% Setup stimulus
stim = PipStimulus;
stim.speaker = 2;
stim.numPips = 30;
stim.startPadDur = 10;
stim.endPadDur = 10;

%% Set up and acquire with the stimulus set
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
    acquireTwoPhotonTrial(stim,trialMeta);
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

diary off
FS.Clear() ;  % Clear up the box
clear FS ;

    function stim = pickStimulus(stimNum)
        switch stimNum
            case 1
                stim.probe = 'left';
            case 2
                stim.probe = 'off';
            case 3
                stim.probe = 'right';
        end
    end



end


