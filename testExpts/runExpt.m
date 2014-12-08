function runExpt(prefixCode,expNum) 


%% Get fly and experiment details from experimenter 
newFly = input('New fly? ','s');
[flyNum, flyExpNum] = getFlyNum(prefixCode,expNum,newFly);

%% Archive this code 
archiveExpCode(prefixCode,expNum,flyNum,flyExpNum)

%% Run a trial in voltage clamp
fprintf('**** Running Voltage Clamp Trial ****\n')
zeroStim = noStimulus; 
acquireTrial(zeroStim,prefixCode,expNum,flyNum,flyExpNum,'n');
contAns = input('Would you like to run a trial in I=0? ','s');
if strcmp(contAns,'n')
    return
end

%% Run a trial in I=0
fprintf('**** Running I=0 Trial ****\n')
zeroStim = noStimulus; 
acquireTrial(zeroStim,prefixCode,expNum,flyNum,flyExpNum,'y');
contAns = input('Would you like to start the experiment? ','s');
if strcmp(contAns,'n')
    return
end

%% Generate stimulus 
fprintf('**** Running Experiment ****\n')
stim = PipStimulus;
trialsPerBlock = 18;
speakerNonRan = repmat(1:3,1,6);
speakerRan = speakerNonRan(randperm(trialsPerBlock));


%% Run experiment with stimulus
count = 1; 
for i = 1:1000000;
    stim.speaker = speakerRan(count);
    switchSpeaker(stim.speaker);    
    acquireTrial(stim,prefixCode,expNum,flyNum,flyExpNum,'y');
    if count == 18
        count = 1; 
        speakerRan = speakerNonRan(randperm(18));
    else
        count = count+1;
    end
end


%% Backup data 
makeBackup
