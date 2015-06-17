%% flexSoundExpt.m
% AVB 2015/06/09

%% Run at start of experiment
runTwoPhotonExpt('60H03',1)

%% Pip
    stim = PipStimulus;
    stim.startPadDur = 5; 
    stim.endPadDur = 5;
    stim.numPips = 20; 
for i = 1:5
    if i == 1
        getRoiNum;
    end
    acquireTwoPhotonTrial(stim);
end

%% Chirp
stim = Chirp;
getRoiNum;
acquireTwoPhotonTrial(stim);

%% Run at end of experiment
diary off