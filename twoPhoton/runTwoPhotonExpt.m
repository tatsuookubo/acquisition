function runTwoPhotonExpt(prefixCode,expNum,stimSetNum,varargin)

%% Get fly and experiment details from experimenter
newFly = input('New fly? ','s');
[flyNum, cellNum, cellExpNum] = getFlyNum(prefixCode,expNum,newFly,newCell);
fprintf(['Fly Number = ',num2str(flyNum),'\n'])
fprintf(['Cell Number = ',num2str(cellNum),'\n'])
fprintf(['Cell Experiment Number = ',num2str(cellExpNum),'\n'])

%% Set meta data
exptInfo.prefixCode     = prefixCode;
exptInfo.expNum         = expNum;
exptInfo.flyNum         = flyNum;
exptInfo.dNum           = datestr(now,'YYmmDD');
exptInfo.exptStartTime  = datestr(now,'HH:MM:SS');


%% Get fly details
if strcmp(newFly,'y')
    getFlyDetails(exptInfo)
end

%% Save expt info 

%% Save prefix code, expt number and fly number to preferences 

%% Run stim set if provided
if exist('stimSetNum','var')
    newROI = input('New roi? ','s');
    exptInfo.roiNum         = roiNum;
    exptInfo.stimSetNum     = stimSetNum;    
    contAns = input('Would you like to start the experiment? ','s');
    if strcmp(contAns,'y')
        fprintf('**** Running Experiment ****\n')
        eval(['twoPhotonStimSet_',num2str(stimSetNum,'%03d'),...
            '(','exptInfo,','preExptData',')'])
    end
end

%% 

%% Backup data
makeBackup
