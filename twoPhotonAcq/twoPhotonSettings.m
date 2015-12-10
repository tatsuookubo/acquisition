function settings = twoPhotonSettings(stim)

%% Parameters
% Samp Rate
settings.sampRate.out   = stim.sampleRate;
settings.sampRate.in    = stim.sampleRate;

% Break out box 
settings.bob.trigOut = 'port0/line0';
settings.bob.aiType = 'SingleEnded';
settings.bob.xMirrorCh = 5;
settings.bob.yMirrorCh = 6;
settings.bob.pockCh = 7; 
settings.bob.piezoSensorCh = 4; 
settings.bob.inChannelsUsed = 4:7;
settings.bob.piezoSensorCol = 1;
settings.bob.xMirrorCol = 2; 
settings.bob.yMirrorCol = 3; 
settings.bob.pockCol = 4; 

settings.devID = 'Dev3';


