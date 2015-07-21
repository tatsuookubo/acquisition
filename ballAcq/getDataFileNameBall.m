function [fullFileName, path, fileNamePreamble, trialNum] = getDataFileNameBall(exptInfo)

prefixCode  = exptInfo.prefixCode;
expNum      = exptInfo.expNum;
flyNum      = exptInfo.flyNum;
flyExpNum   = exptInfo.flyExpNum;

settings = ballSettings; 
dataDirectory = settings.dataDirectory;

% Make numbers strings
eNum = num2str(expNum,'%03d');
fNum = num2str(flyNum,'%03d');
fENum = num2str(flyExpNum,'%03d');

% Put together path name and fileNamePreamble
path = [dataDirectory,prefixCode,'\expNum',eNum,...
    '\flyNum',fNum,'\flyExpNum',fENum,'\'];

fileNamePreamble = [prefixCode,'_expNum',eNum,...
    '_flyNum',fNum,'_flyExpNum',fENum,'_'];

% Determine trial number
trialNum = 1;
while( size(dir([path,fileNamePreamble,'trial',num2str(trialNum,'%03d'),'.mat']),1) > 0)
    trialNum = trialNum + 1;
end

% Put together full file name
fullFileName = [path,fileNamePreamble,'trial',num2str(trialNum,'%03d'),'.mat'];