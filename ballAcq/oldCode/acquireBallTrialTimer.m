function data = acquireBallTrial

close all
fprintf('\n*********** Starting Trial ***********')

%% Close serial connection if already open 
newobjs = instrfind;
fclose(newobjs);

%% Create stimulus if needed
stim = PipStimulus; 
stim.startPadDur = 0; 
stim.endPadDur = 0; 
stim.numPips = 100; 

%% Load settings
settings = ballSettings(stim);

%% Configure session
s = daq.createSession('ni');
s.Rate = settings.sampRate.out;

% Add analog out channel (speaker)
s.addAnalogOutputChannel(settings.devID,0,'Voltage');
s.Rate = settings.sampRate.out;

ai = s.addAnalogInputChannel(settings.devID,settings.inChannelsUsed,'Voltage');
ai.InputType = 'SingleEnded';

%% Setup serial acquisition
s1 = serial(settings.serialPort);            % define serial port
s1.BaudRate=settings.baudRate;               % define baud rate
set(s1, 'terminator', 'LF');    % define the terminator for println

%% Setup timer
ballData = []; 
myTimer = timer('Period', 0.01, 'ExecutionMode', 'fixedRate','TasksToExecute',10);
myTimer.timerFcn =  @myTimerCallbackFcn;
myTimer.startFcn = @initTimer; 
% myTimer.timerFcn =  @myTimerCallbackFcn;

%% Send analog out
s.queueOutputData([stim.stimulus]);
rawData = s.startBackground;

%% Acquire ball data
fopen(s1);
disp('** Opened serial connection')

start(myTimer)
disp('** Started timer')

    function initTimer(src, event)
        w=fscanf(s1,'%s');
        disp('** Acquired first serial sample');
    end
 
    function myTimerCallbackFcn(src,event)
        ballData(end+1,:)=fscanf(s1,'%d%*[|]%d%*[|]%d');
        disp('** Acquiring subsequent samples');
    end

while myTimer.TasksExecuted < 10
end
        
delete(myTimer)
fclose(s1);

% try
%
%
%     triggerStart=tic;
%
%     % collect mouse data
%     elapsedTime = toc(triggerStart);
%     while elapsedTime < stim.totalDur;
%         disp(['Elapsed time ',num2str(elapsedTime)])
%         i=i+1;
%         ballData(i,:)=fscanf(s1,'%d%*[|]%d%*[|]%d');
%         elapsedTime = toc(triggerStart);
%     end
%     fclose(s1);
% catch exception
%     fclose(s1);
%     throw(exception)
% end

%% Close daq objects
s.stop;

%% Process data
data.xPos = ballData(:,1);
data.yPos = ballData(:,2);
data.time = ballData(:,3);

%% Save data
% if nargin ~= 0 && nargin ~= 1
%     % Get filename and save trial data
%     [fileName,path,trialMeta.trialNum] = getDataFileName(exptInfo);
%     fprintf(['\nTrial Number ', num2str(trialMeta.trialNum)])
%     fprintf(['\nStimNum = ',num2str(trialMeta.stimNum)])
%     if ~isdir(path)
%         mkdir(path);
%     end
%
%     % Convert stim object to structure for saving
%     warning('off','MATLAB:structOnObject')
%     Stim = struct(stim);
%     save(fileName, 'data','trialMeta','Stim','exptInfo');
%
%     % Save expt data
%     if trialMeta.trialNum == 1
%         [~, path, ~, idString] = getDataFileName(exptInfo);
%         settingsFileName = [path,idString,'exptData.mat'];
%         save(settingsFileName,'settings','exptInfo','preExptData');
%     end
% end

% %% Plot data
% plotBallDataOnline(stim,data)

end


