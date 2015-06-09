function settings = twoPhotonSettings(stim)

%% Parameters
% Samp Rate
settings.sampRate.out   = stim.sampleRate;
settings.sampRate.in    = stim.sampleRate;

% Break out box 
settings.bob.slowMirrorCh = 8;
settings.bob.fastMirrorCh = 9;
settings.bob.slowMirrorCol = 1; % The column of the input data matrix that contains the slow mirrow data 
settings.bob.fastMirrorCol = 2; % The column of the input data matrix that contains the fast mirrow data 
settings.bob.inChannelsUsed = 8:9;
settings.bob.triggerChIn = 'PFI6';
settings.bob.triggerChOut = 'PFI2';
settings.bob.aiType = 'SingleEnded';

settings.devID = 'Dev3';

%{

                setpref('AcquisitionHardware','rigDev','Dev3')
                setpref('AcquisitionHardware','modeDev','Dev4')
                setpref('AcquisitionHardware','gainDev','Dev4')
                setpref('AcquisitionHardware','triggerChannelIn','PFI6')
                setpref('AcquisitionHardware','triggerChannelOut','PFI2')

%}


