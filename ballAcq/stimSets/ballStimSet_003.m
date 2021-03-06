function ballStimSet_003(exptInfo)

% Produces the default pip train while switching between all three speakers

%% Archive this code
archiveExpCodeBall(exptInfo)

%% Set up and acquire with the stimulus set
tic
trialMeta.totalStimNum = 1; 
while toc<3600 % run for an hour (habituation)
    trialMeta.pauseDur = rand(1,1); % random pause duration
    pause on 
    pause(trialMeta.pauseDur);
    trialMeta.stimNum = 1;
    stim = noStimulus;
    stim.startPadDur = 5;
    stim.endPadDur = 5;
    stim.speaker = 1; 
    trialMeta.outputCh = switchSpeakerBall(stim.speaker); % output channel (either 0 or 1)
    acquireBallTrial(stim,exptInfo,trialMeta);
end

end
