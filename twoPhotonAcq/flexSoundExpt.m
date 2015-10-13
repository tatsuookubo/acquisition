%% flexSoundExpt.m
% AVB 2015/06/09

%% Run at start of experiment
runTwoPhotonExpt('JO4',1)

%% AMTone
stim = AmTone;
stim.waveDur = 1;
stim.startPadDur = 1;
stim.endPadDur = 1;
stim.maxVoltage = 2;
plot(stim)

%% Pip
stim = PipStimulus;
stim.speaker = 2;
stim.numPips = 30;
stim.startPadDur = 3;
stim.endPadDur = 3;
stim.probe = 'left';
stim.maxVoltage = 0.5;
plot(stim)

%% Chirp
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
stim.startPadDur = 1;
stim.endPadDur = 1;
stim.numPips = 20;
stim.maxVoltage = 2;
plot(stim)

%% Pulse Song
stim = PulseSong;

%% SineWave
stim = SineWave;

%% Run one trial

getRoiNum;
getBlockNum;
metaFileName = acquireTwoPhotonTrial(stim);
figSuffix = 'Online';
setpref('scimPlotPrefs','newRoi',1)
postMultTrialPlot(metaFileName,figSuffix)
% postMultTrialPlotNumTrials(metaFileName,figSuffix)

%% Run 5 trials
for i = 1:3
    if i == 1
        getRoiNum;
        getBlockNum;
    end
    metaFileName = acquireTwoPhotonTrial(stim);
end
figSuffix = 'Online';
% setpref('scimPlotPrefs','newRoi',1)
postMultTrialPlot(metaFileName,figSuffix)
% postMultTrialPlotNumTrials(metaFileName,figSuffix)

%% Run at end of experiment
diary off