function settings = ballSettings(stim,varargin)

%% Acquisition settings
if exist('stim','var')
    settings.sampRate   = stim.sampleRate;
end
settings.devID = 'Dev1';
settings.inChannelsUsed = 0:1;

%% Processing settings
settings.xMinVal = 0.0490;
settings.xMaxVal = 4.8516;
settings.yMinVal = 0.0500;
settings.yMaxVal = 4.4616;
settings.numInts = 271;
settings.cutoffFreq = 1000;

settings.sensorRes  = 8200;
settings.mmConv = 25.4;
settings.mmPerCount = settings.mmConv/settings.sensorRes;

settings.dataDirectory = 'C:\Users\Alex\Documents\Data\ballData';

