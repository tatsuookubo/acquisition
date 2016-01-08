%% Configure session
s = daq.createSession('ni');
s.Rate = 500000;
s.DurationInSeconds = 0.1; 

% Add analog input channel (for acquiring mirror commands that scanImage
% sends)
s.addAnalogInputChannel('Dev3',0,'Voltage');
aI(1).InputType = 'Differential';

%% Run trial
rawData = s.startForeground;

%% Process data
data = rawData(:,1);

%% Close daq objects
s.stop;

%% Plot
figure
plot(data)
