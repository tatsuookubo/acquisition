%% flexSoundExpt.m
% AVB 2015/06/09

%% Run at start of experiment
runTwoPhotonExpt('12B10',1)

%% AMTone
stim = AmTone;
stim.waveDur = 10;
stim.startPadDur = 5;
stim.endPadDur = 5;
stim.maxVoltage = 2; 
plot(stim)

%% Chirp
stim = Chirp;

%% Click
stim = ClickStimulus;
stim.numClicks = 10;
stim.ici = 2;
stim.maxVoltage = 2;
stim.startPadDur = 10;
stim.endPadDur = 10;

%% Courtship Song
stim = CourtshipSong;

%% No stimulus
stim = noStimulus;
stim.startPadDur = 60;
plot(stim)

%% Pip
stim = PipStimulus;
stim.startPadDur = 5; 
stim.endPadDur = 5; 
stim.numPips = 30; 
plot(stim)

%% Pulse Song
stim = PulseSong;

%% SineWave
stim = SineWave;

%% Run one trial
getRoiNum;
getBlockNum;
metaFileName = acquireTwoPhotonTrial(stim);
postMultTrialPlot(metaFileName)

%% Run 5 trials
for i = 1:5
    if i == 1
        getRoiNum;
        getBlockNum;
    end
    metaFileName = acquireTwoPhotonTrial(stim);
end
postMultTrialPlot(metaFileName)

%% Run at end of experiment
diary off