function settings = ballSettings(stim)

%% Parameters
% Samp Rate
settings.sampRate.out   = stim.sampleRate;
settings.sampRate.in    = stim.sampleRate;

settings.devID = 'Dev1';

settings.serialPort = 'COM4';
settings.baudRate = 9600; 

settings.inChannelsUsed = 0;



