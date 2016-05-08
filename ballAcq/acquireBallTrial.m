function acquireBallTrial(stim,exptInfo,trialMeta)
%%% modified by Tatsuo Okubo
%%% 2015/05/06

fprintf('\n*********** Acquiring Trial ***********') 

%% Trial time 
trialMeta.trialStartTime = datestr(now,'HH:MM:SS'); 
fprintf(['\nTrial start time: ',trialMeta.trialStartTime]);

%% Create stimulus if needed  
if ~exist('stim','var')
    stim = noStimulus; 
end

%% Load settings    
settings = ballSettings; 
     
%% Configure session
s = daq.createSession('ni');
s.Rate = settings.sampRate;
s.DurationInSeconds = stim.totalDur;

%% Add digital output channels (olfactometer)
%s.addAnalogOutputChannel(settings.devID,trialMeta.outputCh,'Voltage');
% trialMeta and not settings since speaker being used changes every trial

s.addDigitalChannel(settings.devID, {['Port0/Line' num2str(settings.outChannelsUsed(1))]}, 'OutputOnly'); % master valve (TO)
s.addDigitalChannel(settings.devID, {['Port0/Line' num2str(settings.outChannelsUsed(2))]}, 'OutputOnly'); % pinch valve (TO)

% Add analog input channels (sensor data)
aI = s.addAnalogInputChannel(settings.devID,settings.inChannelsUsed,'Voltage');
for i = 1+settings.inChannelsUsed
    aI(i).InputType = settings.aiType; % single-ended for all channels
end

%% Run trials
s.queueOutputData([stim.stimulus]); % output
rawData = s.startForeground; % acquire data

%% Close daq objects
s.stop;
s.stop;

%% Allocate data 
data.xVel = rawData(:,1);
data.yVel = rawData(:,2);

%% Only if saving data
if nargin ~= 0 && nargin ~= 1
    % Get filename and save trial data
    [fileName, path, fileNamePreamble, trialMeta.trialNum] = getDataFileNameBall(exptInfo);
    fprintf(['\nTrial Number ', num2str(trialMeta.trialNum)])
    fprintf(['\nStimNum = ',num2str(trialMeta.stimNum)])
    if ~isdir(path)
        mkdir(path);
    end
    % Convert stim object to structure for saving 
    warning('off','MATLAB:structOnObject')
    Stim = struct(stim); 
    save(fileName, 'data','trialMeta','Stim','exptInfo');
    
    % Save expt data 
    if trialMeta.trialNum == 1
        settingsFileName = [path,fileNamePreamble,'exptData.mat'];
        save(settingsFileName,'settings','exptInfo'); 
    end
end

%% Plot data
plotBallData(Stim,rawData,trialMeta,exptInfo) 
end