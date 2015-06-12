function writeToRecordingNotebook(exptInfo)

%% Find which row to write to 
wbkname = 'recordingNotebook';
filename = ['C:\Users\Alex\Documents\Data\',wbkname,'.xlsx'];
[~,timestampCol,~] = xlsread(filename,'A:A');
numRows = length(timestampCol);
xlRange = ['A',num2str(numRows+1)];

%% Load data to write 
% Load fly data 
prefixCode  = exptInfo.prefixCode;
expNum      = exptInfo.expNum;
flyNum      = exptInfo.flyNum;
cellNum     = exptInfo.cellNum;
cellExpNum  = exptInfo.cellExpNum;

microCzarSettings;   % Loads settings

% Make numbers strings
eNum = num2str(expNum,'%03d');
fNum = num2str(flyNum,'%03d');
cNum = num2str(cellNum,'%03d');
cENum = num2str(cellExpNum,'%03d');

flyDataFilename = [dataDirectory,prefixCode,'\expNum',eNum,...
        '\flyNum',fNum,'\flyData'];
  
load(flyDataFilename)

% Load experiment details
[~, path, ~, idString] = getDataFileName(exptInfo);
settingsFileName = [path,idString,'exptData.mat'];
load(settingsFileName);

%% Convert date into text 
dateNumber = datenum(exptInfo.dNum,'yymmdd');
dateAsString = datestr(dateNumber,'yy-mm-dd');

%% Put data in array 
dataArray = {dateAsString,exptInfo.exptStartTime,FlyData.eclosionDate,FlyData.freenessLeft,FlyData.freenessRight,FlyData.notesOnDissection,...
    FlyData.line,exptInfo.cellType,exptInfo.hemisphere,exptInfo.prefixCode,exptInfo.expNum,exptInfo.flyNum,exptInfo.cellNum,...
    exptInfo.cellExpNum,exptInfo.stimSetNum,exptInfo.aim,exptInfo.worthAnalysing,exptInfo.notesOnRecording};

%% Close excel worksheet 
h = actxGetRunningServer('Excel.Application');
% Save changes before closing
h.WorkBooks.Item(wbkname).Save
h.WorkBooks.Item(wbkname).Close;
 

%% Write to excel file 
status = xlswrite(filename,dataArray,1,xlRange);
if status == 1; 
    disp('Write to recording notebook was successful')
else 
    disp('Did not write to recording notebook')
end