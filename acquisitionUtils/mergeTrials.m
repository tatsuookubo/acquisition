function mergeTrials(prefixCode,expNum,flyNum,flyExpNum)

exptInfo.prefixCode     = prefixCode;
exptInfo.expNum         = expNum;
exptInfo.flyNum         = flyNum;
exptInfo.flyExpNum      = flyExpNum;

%% load raw data and process (filter, interpolate, calculate velocity)
[~,path] = getDataFileName(exptInfo);
cd(path)
fileNames = dir('*trial*.mat');
numTrials = length(fileNames);

stimSequence = [];
% load and process data
for n = 1:numTrials;
    clear data stim meta
    load([path,fileNames(n).name]);
    
    %     trialNum = trailMeta.trialNum;
    stimNum = meta.stimNum;
    
    figure(1) 
    subplot(2,1,1)
    plot(data.voltage)
    hold on 
    subplot(2,1,2) 
    plot(data.current) 

    
    keepTrial = input('Keep Trial? ','s');
    if strcmp(keepTrial,'y')
        stimSequence = [stimSequence, meta.stimNum];
        trialInd = sum(stimSequence == stimNum);
        GroupData(stimNum).current(trialInd,:) = data.current;
        GroupData(stimNum).voltage(trialInd,:) = data.voltage;
    end
        close all
    
    if any(stimSequence == stimNum)
    else
        GroupStim(stimNum).stimTime = [1/stim.sampleRate:1/stim.sampleRate:stim.totalDur]';
        GroupStim(stimNum).stimulus = stim.stimulus;
        GroupData(stimNum).sampTime = [1/meta.inRate:1/meta.inRate:stim.totalDur]';

    end
 
end

%% save processed data
[~, path, ~, idString] = getDataFileName(exptInfo);
saveFileName = [path,idString,'groupedData.mat'];
save(saveFileName,'GroupData','GroupStim');