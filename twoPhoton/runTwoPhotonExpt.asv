function runTwoPhotonExpt(prefixCode,expNum,stimSetNum,varargin)

%% Get folder and basename
flyNum = getFlyNumTwoPhoton(prefixCode,expNum);

folder = [dataDirectory,prefixCode,'\expNum',eNum,...
    '\flyNum',flyNum];

if ~isdir(folder)
    mkdir(folder)
end

basename = [prefixCode,'_expNum',eNum,...
    '_flyNum',flyNum,'_'];

%% Set meta data
exptInfo.prefixCode     = prefixCode;
exptInfo.expNum         = expNum;
exptInfo.flyNum         = flyNum;
exptInfo.dNum           = datestr(now,'YYmmDD');
exptInfo.exptStartTime  = datestr(now,'HH:MM:SS');
exptInfo.codeStamp      = getCodeStamp(1);

%% Save folder and basename to matlab preferences
addpref('scimSavePrefs',{'folder','basename','roiNum'},{folder,basename,[]})

%% Set Dir and basename in ScanImage
input(['Set Dir in ScanImage to ''',folder,''' \nthen press Enter\n'])

clipboard('copy',basename);
input('Paste basename in ScanImage \nthen press Enter\n')

%% Save exptInfo
filename = [folder,'\',basename,'exptInfo'];
save(filename,'exptInfo')

%% Get and save fly details
if strcmp(newFly,'y')
    getFlyDetails(exptInfo)
end

%% Run stim set if provided
if exist('stimSetNum','var')
    trialMeta.stimSetNum = stimSetNum;
    getRoiNum;
    contAns = input('Would you like to start the experiment? ','s');
    if strcmp(contAns,'y')
        fprintf('**** Running Experiment ****\n')
        eval(['twoPhotonStimSet_',num2str(stimSetNum,'%03d'),...
            '(','trialMeta',')'])
    end
end

%% Run flexible experiment if no stimSet is provided
if ~exist('stimSetNum','var')
    edit flexSoundExpt;
end


