function ballStimSet_005(exptInfo)
%%% wind and odor at the same time
%%% Tatsuo Okubo
%%% 2016/05/10

%% Archive this code
archiveExpCodeBall(exptInfo)

%% Set up and acquire with the stimulus set
tic
trialMeta.totalStimNum = 8; % total number of trial types
for k=1:trialMeta.totalStimNum
    In = inputdlg('Wind direction (1:0, 2:R 45, 3:R 90, 4:R 135, 5:180, 6:L 135 7:L 90 8:L 45)','Type trial type'); % type in trial type
    trialMeta.stimNum = eval(In{1});
    trialMeta.trialPerType = 10;
    for n=1:trialMeta.trialPerType
        trialMeta.pauseDur = 5*rand(1,1); % random pause duration
        pause on
        pause(trialMeta.pauseDur);
                
        trialMeta.windPre = 5; % [s] before wind on
        trialMeta.odorPre = 0; % [s] after wind on, before odor on
        trialMeta.odorDur = 5; % [s] pinch valve for odor delivery
        trialMeta.odorPost = 0; % [s] after odor off, before wind off
        trialMeta.windPost = 5; % [s] after wind off
        
        stim = olfactometerPulse(trialMeta);
        acquireBallTrial_TO(stim,exptInfo,trialMeta);
    end
end