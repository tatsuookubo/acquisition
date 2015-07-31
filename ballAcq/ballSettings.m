function settings = ballSettings

%% Acquisition settings
settings.sampRate = 40e3;
settings.devID = 'Dev1';
settings.inChannelsUsed = 0:1;

%% Processing settings
settings.xMinVal = 0.0490;
settings.xMaxVal = 4.8516;
settings.yMinVal = 0.0500;
settings.yMaxVal = 4.4616;
settings.numInts = 271;
settings.cutoffFreq = 50;
settings.aiType = 'SingleEnded';

settings.sensorRes  = 8200;
settings.mmConv = 25.4;
settings.mmPerCount = settings.mmConv/settings.sensorRes;
settings.sensorPollFreq = 100; 

settings.dataDirectory = 'C:\Users\Alex\Documents\Data\ballData\';

