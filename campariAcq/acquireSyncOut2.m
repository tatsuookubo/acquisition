function acquireSyncOut2

%% Trackball settings
%{
resolution  = 8200cpi
1 inch = 25.4mm
allow for gain

%}

set(0,'DefaultFigureWindowStyle','normal')


%% Set up outputs 
% Setup stimulus 
stim = PipStimulus;
stim.speaker = 2;
stim.probe = 'off';
stim.maxVoltage = 0.2;
stim.numPips = 15;
stim.startPadDur = 0.1;
stim.endPadDur = 0.1; 


% Setup shutter command pulse 
pulseCommand = zeros(length(stim.stimulus),1);
pulseStart = stim.startPadDur*stim.sampleRate + 1; 
pulseDur = stim.stimDur; % in seconds 
pulseEnd = pulseStart + pulseDur*stim.sampleRate-1; 
pulseCommand(pulseStart:pulseEnd) = 1;

%% Load settings
inChannelsUsed = 12;

%% Configure daq
% daqreset;
devID = 'Dev1';

%% Configure session
sess = daq.createSession('ni');
sess.Rate = 40E3;
sess.DurationInSeconds = stim.totalDur;

% Add analog input to read in sync output 
aI = sess.addAnalogInputChannel(devID,inChannelsUsed,'Voltage');
for i = 1:length(inChannelsUsed)
    aI(i).InputType = 'SingleEnded';
end

% Add analog output to send speaker command 
aO = sess.addAnalogOutputChannel(devID,0,'Voltage');

% Add digital output to send pulse command 
dO = sess.addDigitalChannel(devID,'port0/line4','OutputOnly');


%% Start session 
fprintf('\n*********** Acquiring Trial ***********\n')
sess.queueOutputData([stim.stimulus,pulseCommand]);
rawData = sess.startForeground;


%% Close daq objects
sess.stop;

%% Plot data
figure(1)
subplot(2,1,1)
plot(stim.stimulus)
hold on 
plot(pulseCommand,'r')
subplot(2,1,2)
plot(rawData)




end
