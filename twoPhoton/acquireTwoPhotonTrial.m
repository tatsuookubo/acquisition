function acquireTwoPhotonTrial(stim,trialMeta,varargin)

fprintf('\n*********** Acquiring Trial ***********') 

%% Trial time 
trialMeta.trialStartTime = datestr(now,'HH:MM:SS'); 

%% Create stimulus if needed  
if ~exist('stim','var')
    stim = noStimulus; 
end

%% Load settings    
settings = twoPhotonSettings(stim); 

%% Configure ouput session
sOut = daq.createSession('ni');
sOut.Rate = settings.sampRate.out;

% Add analog out channel (speaker)
sOut.addAnalogOutputChannel(settings.devID,0,'Voltage');
sOut.Rate = settings.sampRate.out;

% Add digital out channel (external trigger)
sOut.addDigitalChannel(settings.devID,settings.bob.trigOut,'OutputOnly');

extTrig = ones(size(stim.stimulus));
extTrig(1) = 0;
extTrig(end) = 0;


%% Run trial
sOut.queueOutputData([stim.stimulus extTrig]);
sOut.startForeground; 

%% Wait some time for scanImage to process 

%% Save data 
if nargin ~= 2
    % Get filenames
    folder = getpref('scimSavePrefs','folder');
    basename = getpref('scimSavePrefs','basename');
    roiNum = getpref('scimSavePrefs','roiNum');
    
    % Put image in correct roiNum folder and rename to include roiNum 
    
    
    % Convert stim object to structure for saving 
    warning('off','MATLAB:structOnObject')
    Stim = struct(stim);
    
    % Save data,trialMeta and Stim
    save(fileName, 'data','trialMeta','Stim');
    
end

%% Close daq objects
sOut.stop;

%% Plot data




end
