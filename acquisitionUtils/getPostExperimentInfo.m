function getPostExperimentInfo(exptInfo)

% Load experiment details
[~, path, ~, idString] = getDataFileName(exptInfo);
settingsFileName = [path,idString,'exptData.mat'];
load(settingsFileName);

% Get new details
exptInfo.cellType = input('Cell type: ','s');
exptInfo.hemisphere = input('Hemisphere: ','s');
exptInfo.aim = input('Aim: ','s');
exptInfo.notesOnRecording = input('Notes on recording: ','s');
exptInfo.worthAnalysing = input('Worth analysing? ','s');

save(settingsFileName,'settings','exptInfo','preExptData'); 
