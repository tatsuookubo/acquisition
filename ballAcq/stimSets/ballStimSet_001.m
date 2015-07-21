function ballStimSet_001(exptInfo)

% Produces the default pip train while switching between all three speakers

%% Archive this code
archiveExpCode(exptInfo)

%% Set up and acquire with the stimulus set
rng('shuffle');
numberOfStimuli = 2;
trialsPerBlock = 20;
speakerNonRan = repmat(1:numberOfStimuli,1,trialsPerBlock/numberOfStimuli);
stimRan = speakerNonRan(randperm(trialsPerBlock));

count = 1;
FS = stoploop('Stop Experiment');
while ~FS.Stop()
    trialMeta.stimNum = stimRan(count);
    fprintf(['\nStimNum = ',num2str(trialMeta.stimNum)])
    stim = pickStimulus(trialMeta.stimNum);
    trialMeta.outputCh = switchSpeakerBall(stim.speaker);
    acquireBallTrial(stim,exptInfo,trialMeta);
    if count == trialsPerBlock
        count = 1;
        stimRan = speakerNonRan(randperm(trialsPerBlock));
    else
        count = count+1;
    end
end

FS.Clear() ;  % Clear up the box
clear FS ;

    function stim = pickStimulus(stimNum)
        switch stimNum
            case 1
                stim = PipStimulus;
                stim.speaker = 1;     % Left speaker       
            case 2
                stim = PipStimulus;
                stim.speaker = 3;       % Right speaker 
        end
    end

end
