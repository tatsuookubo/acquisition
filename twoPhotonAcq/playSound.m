function playSound(stim,varargin)

close all
fprintf('\n*********** Acquiring Trial ***********')

%% Create stimulus if needed
if ~exist('stim','var')
    stim = noStimulus;
end

%% Create ScanImage trigger
extTrig = ones(size(stim.stimulus));
extTrig(1) = 0;
extTrig(end) = 0;

%% Load settings
settings = twoPhotonSettings(stim);

%% Configure session
s = daq.createSession('ni');
s.Rate = settings.sampRate.out;

% Add analog out channel (speaker)
s.addAnalogOutputChannel(settings.devID,0,'Voltage');
s.Rate = settings.sampRate.out;

% Add digital out channel (external trigger)
s.addDigitalChannel(settings.devID,settings.bob.trigOut,'OutputOnly');


%% Run trial
s.queueOutputData([stim.stimulus extTrig]);
s.startForeground;

%% Close daq objects
s.stop;
pause(2)


end
