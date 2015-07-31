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
    sumData.xDisp(trialMeta.stimNum,:) = procData.disp(:,1);
    sumData.yDisp(trialMeta.stimNum,:) = procData.disp(:,2);
else
    load(fileName)
    if ~any(sumData.stimNum == trialMeta.stimNum)
        sumData.xDisp(trialMeta.stimNum,:) = NaN(size(procData.disp(:,1)'));
        sumData.yDisp(trialMeta.stimNum,:) = NaN(size(procData.disp(:,1)'));
    end
    [currTrialCounts,sumData.histCenters] = hist(procData.vel(:,2),bins);
    sumData.yVelCounts = sumData.yVelCounts + currTrialCounts;
    sumData.xDisp(trialMeta.stimNum,:) = nansum([sumData.xDisp(trialMeta.stimNum,:);procData.disp(:,1)']);
    sumData.yDisp(trialMeta.stimNum,:) = nansum([sumData.yDisp(trialMeta.stimNum,:);procData.disp(:,2)']);
end

sumData.stimNum(trialNum) = trialMeta.stimNum;
numTrials = sum(sumData.stimNum == trialMeta.stimNum); 
sumData.meanXDisp(trialMeta.stimNum,:) = sumData.xDisp(trialMeta.stimNum,:)./numTrials;
sumData.meanYDisp(trialMeta.stimNum,:) = sumData.yDisp(trialMeta.stimNum,:)./numTrials;

save(fileName, 'sumData');
