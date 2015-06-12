function mergeTrials(exptInfo,varargin)

%% Get path
if nargin == 0
    path = uigetdir;
else
    [~,path] = getDataFileName(exptInfo);
end

%

%% Calculate number of trials
cd(path)
fileNames = dir('*trial*.mat');
numTrials = length(fileNames);
stimSequence = [];

%%  Group data
for n = 1:numTrials;
    % Load file
    clear data Stim exptInfo trialMeta
    load([path,'\',fileNames(n).name]);
    
    % Load overall experiment data
    if n == 1
        [~, path, ~, idString] = getDataFileName(exptInfo);
        settingsFileName = [path,idString,'exptData.mat'];
        load(settingsFileName)
    end
    
    
    % Create stimulus matrix
    stimNum = trialMeta.stimNum;
    if any(stimSequence == stimNum)
    else
        GroupStim(stimNum).stimTime = [1/Stim.sampleRate:1/Stim.sampleRate:Stim.totalDur]';
        GroupStim(stimNum).stimulus = Stim.stimulus;
        GroupData(stimNum).sampTime = [1/settings.sampRate.in:1/settings.sampRate.in:Stim.totalDur]';
        
    end
    
    % Create data matrix
    stimSequence = [stimSequence, stimNum];
    trialInd = sum(stimSequence == stimNum);
    GroupData(stimNum).current(trialInd,:) = data.current;
    GroupData(stimNum).voltage(trialInd,:) = data.voltage;
    
    
end

%% save processed data
saveFileName = [path,'groupedData.mat'];
save(saveFileName,'GroupData','GroupStim');