function runExpt(prefixCode,expNum,stimSetNum)

%% Get fly and experiment details from experimenter
newFly = input('New fly? ','s');
[flyNum, flyExpNum] = getFlyNum(prefixCode,expNum,newFly);

%% Run pre-expt routines (measure pipette resistance etc.) 
meta = preExptRoutine;

%% Run experiment with stimulus
contAns = input('Would you like to start the experiment? ','s');
if strcmp(contAns,'y')
    fprintf('**** Running Experiment ****\n')
    eval(['stimSet_',num2str(stimSetNum,'%03d'),...
        '(''',prefixCode,''',',num2str(expNum),',',num2str(flyNum),',',num2str(flyExpNum),',','meta',')'])
end

%% Backup data
makeBackup
