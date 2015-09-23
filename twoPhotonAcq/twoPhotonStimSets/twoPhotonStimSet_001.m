function twoPhotonStimSet_001(trialMeta)

blockNum = newBlock;

% Probe experiment
%% Setup stimulus


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
    metaFileName = acquireTwoPhotonTrial(stim,trialMeta);
    if count == 5
        count = 1;
        stimCount = stimCount + 1;
        postMultTrialPlot(metaFileName,'Online')
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
                stim = PipStimulus;
                stim.speaker = 2;
                stim.numPips = 30;
                stim.startPadDur = 10;
                stim.endPadDur = 10;
                stim.probe = 'left';
                switchBlock(blockNum,'probe on left')
                stim.maxVoltage = 2; 
            case 2
                stim = PipStimulus;
                stim.speaker = 2;
                stim.numPips = 30;
                stim.startPadDur = 10;
                stim.endPadDur = 10;
                stim.probe = 'off';
                switchBlock(blockNum+1,'no probe')
                stim.maxVoltage = 2; 
            case 3
                stim = PipStimulus;
                stim.speaker = 2;
                stim.numPips = 30;
                stim.startPadDur = 10;
                stim.endPadDur = 10;
                stim.probe = 'right';
                switchBlock(blockNum+2,'probe on right')
                stim.maxVoltage = 2; 
        end
    end



end


