function mergeTrials

% (prefixCode,expNum,flyNum,flyExpNum)
% 
% exptInfo.prefixCode     = prefixCode;
% exptInfo.expNum         = expNum;
% exptInfo.flyNum         = flyNum;
% exptInfo.flyExpNum      = flyExpNum;

%% load raw data and process (filter, interpolate, calculate velocity)
% [~,path] = getDataFileName(exptInfo);
path = uigetdir;
cd(path)
fileNames = dir('*trial*.mat');
numTrials = length(fileNames);

stimSequence = [];
% load and process data
for n = 1:numTrials;
    clear data stim meta
    load([path,'\',fileNames(n).name]);
    
    %     trialNum = trailMeta.trialNum;
    stimNum = trialMeta.stimNum;
    
%     figure(1) 
%     subplot(2,1,1)
%     plot(data.voltage)
%     hold on 
%     subplot(2,1,2) 
%     plot(data.current) 
% 
%     
%     keepTrial = input('Keep Trial? ','s');
%     if strcmp(keepTrial,'y')

    if any(stimSequence == stimNum)
    else
        GroupStim(stimNum).stimTime = [1/Stim.sampleRate:1/Stim.sampleRate:Stim.totalDur]';
        GroupStim(stimNum).stimulus = Stim.stimulus;
        GroupData(stimNum).sampTime = [1/10e3:1/10e3:Stim.totalDur]';

    end
 
        stimSequence = [stimSequence, stimNum];
        trialInd = sum(stimSequence == stimNum);
        GroupData(stimNum).current(trialInd,:) = data.current;
        GroupData(stimNum).voltage(trialInd,:) = data.voltage;
%     end
%         close all
    

end

%% save processed data
% [~, path, ~, idString] = getDataFileName(exptInfo);
saveFileName = [path,'groupedData.mat'];
save(saveFileName,'GroupData','GroupStim');