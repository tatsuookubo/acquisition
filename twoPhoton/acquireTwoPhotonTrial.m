% function [data,settings,stim,trialMeta,exptInfo] = acquireTwoPhotonTrial(stim,exptInfo,preExptData,trialMeta,varargin)

stim = PipStimulus; 

fprintf('\n*********** Acquiring Trial ***********') 

% %% Trial time 
% trialMeta.trialStartTime = datestr(now,'HH:MM:SS'); 
% 
% %% Code stamp
% exptInfo.codeStamp      = getCodeStamp(1);
% 
% %% Create stimulus if needed  
% if ~exist('stim','var')
%     stim = noStimulus; 
% end

%% Load settings    
settings = twoPhotonSettings(stim); 

%% Configure ouput session
sOut = daq.createSession('ni');
sOut.Rate = settings.sampRate.out;

% Add Channels
sOut.addAnalogOutputChannel(settings.devID,0,'Voltage');
sOut.Rate = settings.sampRate.out;

% Add Trigger
sOut.addTriggerConnection('External',[settings.devID,'/',settings.bob.triggerChOut],'StartTrigger');

%% Configure input session
sIn = daq.createSession('ni');
sIn.Rate = settings.sampRate.in;
sIn.DurationInSeconds = stim.totalDur;

% Add Channels
aI = sIn.addAnalogInputChannel(settings.devID,settings.bob.inChannelsUsed,'Voltage');
for i = 1+inChannelsUsed
    aI(i).InputType = settings.bob.aiType;
end

% Add Trigger
sIn.addTriggerConnection([settings.devID,'/',triggerChannelIn],'External','StartTrigger');

%% Run trial
sOut.queueOutputData([stim.stimulus,settings.pulse.Command]);
sOut.startBackground; % Start the session that receives start trigger first
rawData = sIn.startForeground;


%% Process and plot non-scaled data
% Process
data.slowMirror = rawData(:,settings.bob.slowMirrorCh+1);
data.fastMirror = rawData(:,settings.bob.fastMirrorCh+1);


% %% Process scaled data
% % Scaled output
% switch trialMeta.mode
%     % Voltage Clamp
%     case {'Track','V-Clamp'}
%         trialMeta.scaledOutput.softGain = 1000/(trialMeta.scaledOutput.gain*settings.current.betaFront);
%         data.scaledCurrent = trialMeta.scaledOutput.softGain .* rawData(:,settings.bob.scalCh+1);
%         
%     % Current Clamp
%     case {'I=0','I-Clamp Normal','I-Clamp Fast'}
%         trialMeta.scaledOutput.softGain = 1000/(trialMeta.scaledOutput.gain);
%         data.scaledVoltage = trialMeta.scaledOutput.softGain .* rawData(:,settings.bob.scalCh+1);
%         
% end


% %% Only if saving data
% if nargin ~= 0 && nargin ~= 1
%     % Get filename and save trial data
%     [fileName,path,trialMeta.trialNum] = getDataFileName(exptInfo);
%     fprintf(['\nTrial Number ', num2str(trialMeta.trialNum)])
%     fprintf(['\nStimNum = ',num2str(trialMeta.stimNum)])
%     if ~isdir(path)
%         mkdir(path);
%     end
%     % Convert stim object to structure for saving 
%     warning('off','MATLAB:structOnObject')
%     Stim = struct(stim); 
%     save(fileName, 'data','trialMeta','Stim','exptInfo');
%     
%     % Save expt data 
%     if trialMeta.trialNum == 1
%         [~, path, ~, idString] = getDataFileName(exptInfo);
%         settingsFileName = [path,idString,'exptData.mat'];
%         save(settingsFileName,'settings','exptInfo','preExptData'); 
%     end
% end

%% Close daq objects
sOut.stop;
sIn.stop;

% %% Plot data
% plotData(stim,settings,data)




% end
