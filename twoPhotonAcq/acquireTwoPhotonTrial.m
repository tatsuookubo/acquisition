function metaFileName = acquireTwoPhotonTrial(stim,trialMeta,varargin)

close all
fprintf('\n*********** Acquiring Trial ***********')

%% Trial time
trialMeta.trialStartTime = datestr(now,'HH:MM:SS');

%% Create stimulus if needed
if ~exist('stim','var')
    stim = noStimulus;
end

%% Create ScanImage trigger
extTrig = ones(size(stim.stimulus));
extTrig(1) = 0;
extTrig(end) = 0;

%% Load settings
settings = twoPhotonSettings(stim);

%% Configure session
s = daq.createSession('ni');
s.Rate = settings.sampRate.out;

% Add analog out channel (speaker)
s.addAnalogOutputChannel(settings.devID,0,'Voltage');
s.Rate = settings.sampRate.out;

% Add digital out channel (external trigger)
s.addDigitalChannel(settings.devID,settings.bob.trigOut,'OutputOnly');

% Add analog input channel (for acquiring mirror commands that scanImage
% sends)
s.addAnalogInputChannel(settings.devID,settings.bob.inChannelsUsed,'Voltage');
for i = 1+settings.bob.inChannelsUsed
    aI(i).InputType = settings.bob.aiType;
end


%% Run trial
s.queueOutputData([stim.stimulus extTrig]);
rawData = s.startForeground;

%% Process data
data.xMirror = rawData(:,settings.bob.xMirrorCol);
data.yMirror = rawData(:,settings.bob.yMirrorCol);
data.pockelsCellCommand = rawData(:,settings.bob.pockCol);

%% Close daq objects
s.stop;
pause(2)

%% Save data
if nargin ~= 0
    % Get preferences to save
    % Save prefs
    trialMeta.roiNum = getpref('scimSavePrefs','roiNum');
    trialMeta.roiDescrip = getpref('scimSavePrefs','roiDescrip');
    trialMeta.blockNum = getpref('scimSavePrefs','blockNum');
    trialMeta.blockDescrip = getpref('scimSavePrefs','blockDescrip');
    
    % Make filename and folder
    folder = getpref('scimSavePrefs','folder');
    basename = getpref('scimSavePrefs','basename');
    saveFolder = [folder,'\roiNum',num2str(trialMeta.roiNum,'%03d'),...
        '\blockNum',num2str(trialMeta.blockNum,'%03d'),'\'];
    if ~isdir(saveFolder)
        mkdir(saveFolder)
    end
    
    % Put image in correct roiNum folder and rename to include roiNum
    cd(folder)
    while isempty(dir('*tif'))
    end
    imageSearchResult = dir('*tif');
    currentImageName = imageSearchResult.name;
    trialNumStr = regexp(currentImageName,'(?<=_)\d*(?=.tif)','match');
    trialNum = str2num(char(trialNumStr));
    fprintf(['\nTrialNum = ',num2str(trialNum)])
    
    newImageName = [saveFolder,basename,'roiNum',num2str(trialMeta.roiNum,'%03d'),...
        '_blockNum',num2str(trialMeta.blockNum,'%03d'),...
        '_trialNum',num2str(trialNum,'%03d'),'_image.tif'];
    movefile(currentImageName,newImageName)
    
    metaFileName = [saveFolder,basename,'roiNum',num2str(trialMeta.roiNum,'%03d'),...
        '_blockNum',num2str(trialMeta.blockNum,'%03d'),...
        '_trialNum',num2str(trialNum,'%03d'),'.mat'];
    
    % Convert stim object to structure for saving
    warning('off','MATLAB:structOnObject')
    Stim = struct(stim);
    
    % Save data,trialMeta and Stim
    save(metaFileName,'data','trialMeta','Stim');
    
end

%% Save lastRoiNum
setpref('scimPlotPrefs','lastRoiNum',trialMeta.roiNum);
setpref('scimPlotPrefs','lastBlockNum',trialMeta.roiNum);


end
