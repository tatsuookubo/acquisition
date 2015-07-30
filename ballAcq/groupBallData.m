function groupedData = groupBallData(procData,trialMeta,exptInfo)

trialNum = trialMeta.trialNum;
[~, path, fileNamePreamble, ~] = getDataFileNameBall(exptInfo);
fileName = [path,fileNamePreamble,'groupedData.mat'];

if trialNum ~= 1
    load(fileName)
end

groupedData.xVel(trialNum,:) = procData.vel(:,1);
groupedData.yVel(trialNum,:) = procData.vel(:,2);
groupedData.xDisp(trialNum,:) = procData.disp(:,1);
groupedData.yDisp(trialNum,:) = procData.disp(:,2);
groupedData.stimNum(trialNum) = trialMeta.stimNum;

save(fileName, 'groupedData');
