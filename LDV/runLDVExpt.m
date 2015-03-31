function runLDVExpt(prefixCode,expNum,flyNum,flyExpNum,stimSetNum)

close all 

%% Set meta data
exptInfo.prefixCode     = prefixCode;
exptInfo.expNum         = expNum;
exptInfo.flyNum         = flyNum;
exptInfo.flyExpNum      = flyExpNum; 
exptInfo.dNum           = datestr(now,'YYmmDD');
exptInfo.exptStartTime  = datestr(now,'HH:MM:SS'); 
exptInfo.stimSetNum     = stimSetNum; 

%% Make directory 
dataDir = ['C:\Users\Alex\Documents\Data\',prefixCode,'\expNum',num2str(expNum,'%03d'),...
    '\flyNum',num2str(flyNum,'%03d')];
if ~isdir(dataDir)
    mkdir(dataDir)
end

%% Run experiment with stimulus
eval(['ldvStimSet_',num2str(stimSetNum,'%03d'),...
        '(','exptInfo',')'])


