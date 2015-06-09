function [data,settings,stim,trialMeta,exptInfo] = acquireTwoPhotonTrial(stim,exptInfo,trialMeta,varargin)

fprintf('\n*********** Acquiring Trial ***********') 

%% Trial time 
trialMeta.trialStartTime = datestr(now,'HH:MM:SS'); 

%% Code stamp
exptInfo.codeStamp      = getCodeStamp(1);

%% Create stimulus if needed  
if ~exist('stim','var')
    stim = noStimulus; 
end

%% Load settings    
settings = twoPhotonSettings(stim); 

%% Configure ouput session
sOut = daq.createSession('ni');
sOut.Rate = settings.sampRate.out;

% Add analog out channel (speaker)
sOut.addAnalogOutputChannel(settings.devID,0,'Voltage');
sOut.Rate = settings.sampRate.out;

% Add digital out channel (external trigger)
sOut.addDigitalChannel(settings.devID,'port0/line0','OutputOnly');

extTrig = ones(size(stim.stimulus));
extTrig(1) = 0;
extTrig(end) = 0;


%% Run trial
sOut.queueOutputData([stim.stimulus extTrig]);
sOut.startForeground; 

%% Save data 
if nargin ~= 0 && nargin ~= 1
    % Get filename and save trial data
    [fileName,path,trialMeta.trialNum] = getDataFileName(exptInfo);
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
        [~, path, ~, idString] = getDataFileName(exptInfo);
        settingsFileName = [path,idString,'exptData.mat'];
        save(settingsFileName,'settings','exptInfo','preExptData'); 
    end
end

%% Close daq objects
sOut.stop;

%% Plot data
plotData(stim,settings,data)



end
