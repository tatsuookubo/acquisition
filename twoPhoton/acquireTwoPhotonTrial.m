function acquireTwoPhotonTrial(stim,trialMeta,varargin)

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
s.addAnalogInputChannel(devID,settings.bob.inChannelsUsed,'Voltage');
for i = 1+settings.bob.inChannelsUsed
    aI(i).InputType = settings.bob.aiType;
end


%% Run trial
s.queueOutputData([stim.stimulus extTrig]);
rawData = s.startForeground;

%% Process data 
data.xMirror = rawData(:,settings.bob.xMirrorCol);
data.yMirror = rawData(:,settings.bob.yMirrorCol);

%% Save data
if nargin ~= 2
    % Get filenames
    folder = getpref('scimSavePrefs','folder');
    basename = getpref('scimSavePrefs','basename');
    trialMeta.roiNum = getpref('scimSavePrefs','roiNum');
    saveFolder = [folder,'\roiNum',num2str(trialMeta.roiNum,'%03d'),'\'];
    
    % Put image in correct roiNum folder and rename to include roiNum
    cd(folder)
    while isempty(dir('*tif'))
    end
    imageSearchResult = dir('*tif');
    currentImageName = imageSearchResult.name;
    trialNumStr = regexp(currentImageName,'(?<=basename)\d*(?=.tif)','match');
    trialNum = str2num(char(trialNumStr));
    
    newImageName = [saveFolder,basename,'roiNum',num2str(trialMeta.roiNum,'%03d'),...
        '_trialNum',num2str(trialNum,'%03d'),'_image.tif'];
    movefile(currentImageName,newImageName)
    
    metaFileName = [saveFolder,basename,'roiNum',num2str(trialMeta.roiNum,'%03d'),...
        '_trialNum',num2str(trialNum,'%03d'),'.mat'];
    
    % Convert stim object to structure for saving
    warning('off','MATLAB:structOnObject')
    Stim = struct(stim);
    
    % Save data,trialMeta and Stim
    save(metaFileName, 'data','trialMeta','Stim');
    
end

%% Close daq objects
s.stop;

%% Plot data
plotTwoPhotonDataOnline(newImageName,metaFileName)



end
