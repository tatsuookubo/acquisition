%% flexSoundExpt.m
% AVB 2015/06/09

%% Run at start of experiment
runTwoPhotonExpt('JO4',1)

%% AMTone
stim = AmTone;
stim.waveDur = 20; 
stim.startPadDur = 20; 
stim.endPadDur = 20;
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
plot(stim)

%% Pulse Song 
stim = PulseSong; 

%% SineWave 
stim = SineWave; 

%% Run one trial
getRoiNum;
acquireTwoPhotonTrial(stim);

%% Run 5 trials
for i = 1:10
    if i == 1
        getRoiNum;
    end
    acquireTwoPhotonTrial(stim);
end

%% Run at end of experiment
diary off