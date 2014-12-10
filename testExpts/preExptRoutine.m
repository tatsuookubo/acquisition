function preExptRoutine(prefixCode,expNum,flyNum,flyExpNum)


%% Run a trial in voltage clamp
contAns = input('Would you like to measure pipette resistance? ','s');
if strcmp(contAns,'y')
    fprintf('**** Measuring Pipette Resistance ****\n')
    zeroStim = noStimulus;
    acquireTrial(zeroStim,prefixCode,expNum,flyNum,flyExpNum,'n');
end

%% Run a trial in voltage clamp
contAns = input('Would you like to run a trial in Voltage Clamp? ','s');
if strcmp(contAns,'y')
    fprintf('**** Running Voltage Clamp Trial ****\n')
    zeroStim = noStimulus;
    acquireTrial(zeroStim,prefixCode,expNum,flyNum,flyExpNum,'n');
end


%% Run a trial in I=0
contAns = input('Would you like to run a trial in I=0? ','s');
if strcmp(contAns,'y')
    fprintf('**** Running I=0 Trial ****\n')
    zeroStim = noStimulus;
    acquireTrial(zeroStim,prefixCode,expNum,flyNum,flyExpNum,'n');
end