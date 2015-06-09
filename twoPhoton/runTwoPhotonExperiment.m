function runTwoPhotonExpt(prefixCode,expNum,stimSetNum)

%% Get fly and experiment details from experimenter
newFly = input('New fly? ','s');
newCell = input('New roi? ','s');
[flyNum, cellNum, cellExpNum] = getFlyNum(prefixCode,expNum,newFly,newCell);
fprintf(['Fly Number = ',num2str(flyNum),'\n'])
fprintf(['Cell Number = ',num2str(cellNum),'\n'])
fprintf(['Cell Experiment Number = ',num2str(cellExpNum),'\n'])

%% Set meta data
exptInfo.prefixCode     = prefixCode;
exptInfo.expNum         = expNum;
exptInfo.flyNum         = flyNum;
exptInfo.roiNum         = cellNum;
exptInfo.dNum           = datestr(now,'YYmmDD');
exptInfo.exptStartTime  = datestr(now,'HH:MM:SS'); 
exptInfo.stimSetNum     = stimSetNum; 

%% Get fly details 
if strcmp(newFly,'y')
    getFlyDetails(exptInfo)
end

%% Run experiment with stimulus
contAns = input('Would you like to start the experiment? ','s');
if strcmp(contAns,'y')
    fprintf('**** Running Experiment ****\n')
    eval(['stimSet_',num2str(stimSetNum,'%03d'),...
        '(','exptInfo,','preExptData',')'])
end

%% Get post experiment info and write to excel file 
if ~strcmp(prefixCode,'test')
    getPostExperimentInfo(exptInfo)
    writeToRecordingNotebook(exptInfo)
end

%% Backup data
makeBackup
