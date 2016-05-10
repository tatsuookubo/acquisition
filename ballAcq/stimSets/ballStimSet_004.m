function ballStimSet_004(exptInfo)
%%% Tatsuo Okubo
%%% 2016/05/08

%% Archive this code
archiveExpCodeBall(exptInfo)

%% Set up and acquire with the stimulus set
tic
trialMeta.totalStimNum = 4; % total number of trial types
for k=1:trialMeta.totalStimNum
    In = inputdlg('Wind direction (1:headwind, 2:R 90deg, 3:tailwind, 4:L 90deg)','Type trial type'); % type in trial type
    trialMeta.stimNum = eval(In{1});
    trialMeta.trialPerType = 10;
    for n=1:trialMeta.trialPerType
        trialMeta.pauseDur = 5*rand(1,1); % random pause duration
        pause on
        pause(trialMeta.pauseDur);
                
        trialMeta.windPre = 3; % [s] before wind on
        trialMeta.odorPre = 3; % [s] after wind on, before odor on
        trialMeta.odorDur = 3; % [s] pinch valve for odor delivery
        trialMeta.odorPost = 3; % [s] after odor off, before wind off
        trialMeta.windPost = 3; % [s] after wind off
        
        stim = olfactometerPulse(trialMeta);
        acquireBallTrial_TO(stim,exptInfo,trialMeta);
    end
end