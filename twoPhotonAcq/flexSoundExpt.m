%% flexSoundExpt.m
% AVB 2015/06/09

%% Run at start of experiment
runTwoPhotonExpt('beads',1)

%% Pip 
stim = PipStimulus;
getRoiNum; 
acquireTwoPhotonTrial(stim); 

%% Chirp 
stim = Chirp;
getRoiNum; 
acquireTwoPhotonTrial(stim); 

%% Run at end of experiment 
diary off 