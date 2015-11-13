function playSound(stim,varargin)

close all
fprintf('\n*********** Acquiring Trial ***********')

%% Create stimulus if needed
if ~exist('stim','var')
    stim = noStimulus;
end

%% Load settings
settings = twoPhotonSettings(stim);

%% Configure session
s = daq.createSession('ni');
s.Rate = settings.sampRate.out;

% Add analog out channel (speaker)
s.addAnalogOutputChannel(settings.devID,0,'Voltage');
s.Rate = settings.sampRate.out;

%% Run trial
s.queueOutputData([stim.stimulus]);
s.startForeground;

%% Close daq objects
s.stop;

end
