function getFlyDetails(exptInfo,basename,dataDirectory)

%% Ask user for input
FlyData.line = input('Line: ','s');
FlyData.freenessLeft = input('Freeness of left antenna: ','s');
FlyData.freenessRight = input('Freeness of right antenna: ','s');
FlyData.notesOnDissection = input('Notes on dissection: ','s');

% Get eclosion date
h = uicontrol('Style', 'pushbutton', 'Position', [20 150 100 70]);
uicalendar('DestinationUI', {h, 'String'});
waitfor(h,'String'); 
FlyData.eclosionDate = get(h,'String');
close all

%% Get filename
prefixCode  = exptInfo.prefixCode;
expNum      = exptInfo.expNum;
flyNum      = exptInfo.flyNum;

% Make numbers strings
eNum = num2str(expNum,'%03d');
fNum = num2str(flyNum,'%03d');

dataDirectory = getpref('scimSavePrefs','dataDirectory');
path = [dataDirectory,prefixCode,'\expNum',eNum,...
        '\flyNum',fNum];

if ~isdir(path)
    mkdir(path)
end
filename = [path,'\',basename,'flyData'];

%% Save
save(filename,'FlyData')