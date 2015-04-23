function [data,settings,stim,trialMeta,exptInfo] = acquireLDVTrial(stim,exptInfo,trialMeta,varargin)

fprintf('\n*********** Acquiring Trial ***********')

%% Get trial number
% Get filename
fileDir = ['C:\Users\Alex\Documents\Data\',exptInfo.prefixCode,'\expNum',num2str(exptInfo.expNum,'%03d'),...
    '\flyNum',num2str(exptInfo.flyNum,'%03d')];
fileName = [fileDir,'\',exptInfo.prefixCode,'_expNum',num2str(exptInfo.expNum,'%03d'),...
    '_flyNum',num2str(exptInfo.flyNum,'%03d'),'_flyExpNum',num2str(exptInfo.flyExpNum,'%03d'),'.mat'];
if exist(fileName,'file')
    load(fileName) 
    n = length(data) + 1; 
else 
    n = 1; 
end
fprintf(['\nTrial Number = ',num2str(n)]);

%% Trial time
trialMeta(n).trialStartTime = datestr(now,'HH:MM:SS');

%% Create stimulus if needed
if ~exist('stim','var')
    stim = noStimulus;
end

%% Load settings
settings = ldvSettings(stim);


%% Specify channels used 
inChannelsUsed  = 14;%1;
outChannelsUsed = 0;

%% Configure daq
% daqreset;
devID = 'Dev1';

%% Configure ouput session
sOut = daq.createSession('ni');
sOut.Rate = settings.sampRate.out;

% Analog Channels / names for documentation
sOut.addAnalogOutputChannel(devID,outChannelsUsed,'Voltage');
sOut.Rate = settings.sampRate.out;

% Add trigger
sOut.addTriggerConnection('External','Dev1/PFI3','StartTrigger');

%% Configure input session
sIn = daq.createSession('ni');
sIn.Rate = settings.sampRate.in;
sIn.DurationInSeconds = stim.totalDur;

aI = sIn.addAnalogInputChannel(devID,inChannelsUsed,'Voltage');
aI.InputType = 'SingleEnded';


% Add Trigger
sIn.addTriggerConnection('Dev1/PFI1','External','StartTrigger');




%% Run trials
sOut.queueOutputData([stim.stimulus]);
sOut.startBackground; % Start the session that receives start trigger first
rawData = sIn.startForeground;

%% Process raw data 
data(n).velocity = (settings.ldvGain.*rawData)';  % acquire voltage output from LDV and convert to velocity (channel ACH0)
velocity_subtracted = data(n).velocity - mean(data(n).velocity);
data(n).displacement = 10^3.*(1/(settings.sampRate.in).*cumsum(velocity_subtracted));  % displacement is integral of velocity (times 10^6 to get um from mm)


%% Only if saving data
% Convert stim object to structure for saving
warning('off','MATLAB:structOnObject')
Stim(n) = struct(stim);
save(fileName, 'data','settings','trialMeta','Stim','exptInfo');


%% Plot data
plotLDVData(data(n).velocity,data(n).displacement,stim,settings)




end

%% plotData
function plotLDVData(velocity,displacement,stim,settings)

figure(1); 

h(1) = subplot(3,1,1); 
stimTime = [1/stim.sampleRate:1/stim.sampleRate:stim.totalDur]';
plot(stimTime,stim.stimulus,'k','lineWidth',2); 
ylabel('stim');

h(2) = subplot(3,1,2); 
sampTime = [1/settings.sampRate.in:1/settings.sampRate.in:stim.totalDur]';
plot(sampTime,velocity,'k','lineWidth',1); 
ylabel('velocity (mm/s)');


h(3) = subplot(3,1,3); 
plot(sampTime,displacement,'k'); 
ylabel('displacement (um)');

xlabel('time (seconds)');

linkaxes(h,'x') 
% xlim([1 1.4])
% ylim([-2 2])

end