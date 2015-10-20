%% flexSoundExpt.m
% AVB 2015/06/09

%% Run at start of experiment
runTwoPhotonExpt('54H01',1)

%% AMTone
stim = AmTone;
stim.waveDur = 1;
stim.startPadDur = 1;
stim.endPadDur = 1;
stim.maxVoltage = 2;
plot(stim)

%% Ascending Chirp
stim = Chirp;
stim.maxVoltage = 0.5;
stim.endPadDur = 3;
plot(stim)

%% Descending chirp
stim = Chirp;
stim.startFrequency  = 1500;
stim.endFrequency    = 90;
stim.maxVoltage = 0.5;
stim.endPadDur = 3;
plot(stim)

%% Click
stim = ClickStimulus;
stim.numClicks = 10;
stim.ici = 2;
stim.maxVoltage = 2;
stim.startPadDur = 10;
stim.endPadDur = 10;

%% Courtship Song
stim = CourtshipSong;
stim.maxVoltage = 2;
plot(stim)

%% No stimulus
stim = noStimulus;
stim.startPadDur = 60;
plot(stim)

%% Pip
stim = PipStimulus;
stim.startPadDur = 3;
stim.endPadDur = 3;
stim.numPips = 30;
stim.maxVoltage = 1;
plot(stim)

%% Pulse Song
stim = PulseSong;

%% SineWave
stim = SineWave;

%% New ROI and new block 
newRoi; 
newBlock; 

%% Just new Block 
newBlock;

%% Run one trial 
metaFileName = acquireTwoPhotonTrial(stim);
figSuffix = 'Online';
postMultTrialPlot(metaFileName,figSuffix)

%% Run multiple trials
numTrials = 3; 
for i = 1:numTrials
    metaFileName = acquireTwoPhotonTrial(stim);
end
figSuffix = 'Online';
postMultTrialPlot(metaFileName,figSuffix)

%% Plot all blocks on same graph 
postMultBlockPlot(metaFileName,figSuffix)

%% Run at end of experiment
diary off