function sumData = sumBallData(procData,trialMeta,exptInfo)

%% Get summmary data filename 
trialNum = trialMeta.trialNum;
[~, path, fileNamePreamble, ~] = getDataFileNameBall(exptInfo);
fileName = [path,fileNamePreamble,'onlineSumData.mat'];

%% Histogram settings
bins = -10:0.5:40;

%% Process and save data
if trialNum == 1
    [sumData.yVelCounts,sumData.histCenters] = hist(procData.vel(:,2),bins);
    sumData.byStim(trialMeta.stimNum).xDisp(:,1) = procData.disp(:,1);
    sumData.byStim(trialMeta.stimNum).yDisp(:,1) = procData.disp(:,2);
else
    load(fileName)
    if ~any(sumData.stimNum == trialMeta.stimNum)
        sumData.byStim(trialMeta.stimNum).xDisp = NaN(size(procData.disp(:,1)));
        sumData.byStim(trialMeta.stimNum).yDisp = NaN(size(procData.disp(:,1)));
    end
    [currTrialCounts,sumData.histCenters] = hist(procData.vel(:,2),bins);
    sumData.yVelCounts = sumData.yVelCounts + currTrialCounts;
    sumData.byStim(trialMeta.stimNum).xDisp = nansum([sumData.byStim(trialMeta.stimNum).xDisp,procData.disp(:,1)],2);
    sumData.byStim(trialMeta.stimNum).yDisp = nansum([sumData.byStim(trialMeta.stimNum).yDisp,procData.disp(:,2)],2);
end

sumData.stimNum(trialNum) = trialMeta.stimNum;
numTrials = sum(sumData.stimNum == trialMeta.stimNum); 
sumData.byStim(trialMeta.stimNum).meanXDisp = sumData.byStim(trialMeta.stimNum).xDisp./numTrials;
sumData.byStim(trialMeta.stimNum).meanYDisp = sumData.byStim(trialMeta.stimNum).yDisp./numTrials;

save(fileName, 'sumData');
