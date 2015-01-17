function runExpt(prefixCode,expNum,stimSetNum)

%% Get fly and experiment details from experimenter
newFly = input('New fly? ','s');
[flyNum, flyExpNum] = getFlyNum(prefixCode,expNum,newFly);
fprintf(['Fly Number = ',num2str(flyNum),'\n'])
fprintf(['Fly Experiment Number = ',num2str(flyExpNum),'\n'])

%% Set meta data
exptInfo.prefixCode     = prefixCode;
exptInfo.expNum         = expNum;
exptInfo.flyNum         = flyNum;
exptInfo.flyExpNum      = flyExpNum;
exptInfo.dNum           = datestr(now,'YYmmDD');
exptInfo.exptStartTime  = datestr(now,'HH:MM:SS'); 

%% Run pre-expt routines (measure pipette resistance etc.)
contAns = input('Run preExptRoutine? ','s');
if strcmp(contAns,'y')
    [~, path, ~, ~] = getDataFileName(exptInfo);
    path = [path,'\preExptTrials'];
    if ~isdir(path)
        mkdir(path);
    end
    preExptData = preExptRoutine(exptInfo);
else
    preExptData = [];
end

%% Run experiment with stimulus
contAns = input('Would you like to start the experiment? ','s');
if strcmp(contAns,'y')
    fprintf('**** Running Experiment ****\n')
    eval(['stimSet_',num2str(stimSetNum,'%03d'),...
        '(','exptInfo,','preExptData',')'])
end

%% Backup data
makeBackup
