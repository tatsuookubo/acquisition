%% Setup stim
stim = PipStimulus; 
stim.maxVoltage = 1; 
stim.numPips = 60; 

%% Configure session
s = daq.createSession('ni');
s.Rate = 40000;
s.DurationInSeconds = 0.1; 

% Add analog out channel (speaker)
s.addAnalogOutputChannel('Dev3',0,'Voltage');

% Add analog input channel (for acquiring mirror commands that scanImage
% sends)
s.addAnalogInputChannel('Dev3',0,'Voltage');
aI(1).InputType = 'Differential';

%% Run trial
s.queueOutputData(stim.stimulus);
rawData = s.startForeground;

%% Process data
data = rawData(:,1);

%% Close daq objects
s.stop;

%% Plot
figure
plot(data)