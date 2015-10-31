function ballStimSet_003(exptInfo)

% Produces the default pip train while switching between all three speakers

%% Archive this code
archiveExpCodeBall(exptInfo)

%% Set up and acquire with the stimulus set
tic
trialMeta.totalStimNum = 1; 
while toc<3600
    trialMeta.pauseDur = rand(1,1);
    pause on 
    pause(trialMeta.pauseDur);
    trialMeta.stimNum = 1;
    stim = noStimulus;
    stim.startPadDur = 5;
    stim.endPadDur = 5;
    stim.speaker = 1; 
    trialMeta.outputCh = switchSpeakerBall(stim.speaker);
    acquireBallTrial(stim,exptInfo,trialMeta);
end

end
