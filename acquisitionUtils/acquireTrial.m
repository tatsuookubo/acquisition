function [data,meta,stim] = acquireTrial(pulseType,stim,prefixCode,expNum,flyNum,flyExpNum,meta,varargin)

if nargin == 0 || nargin == 1 || nargin == 7
else
    disp('Number of arguments must be 0, 1 or 7')
    return
end
    
if nargin == 0  
    stim = noStimulus; 
    pulseType = 'none';
elseif nargin == 1  
    stim = noStimulus; 
end


%% Parameters
meta.outRate    = stim.sampleRate;
meta.inRate     = 10E3;

meta.bob.currCh = 0;
meta.bob.voltCh = 1;
meta.bob.scalCh = 2;
meta.bob.gainCh = 3;
meta.bob.freqCh = 4;
meta.bob.modeCh = 5;

meta.bob.aiType = 'SingleEnded';

% Current input settings
meta.iSettings.betaRear   = 1; % Rear switch for current output set to beta = 100mV/pA
meta.iSettings.betaFront  = 1; % Front swtich for current output set to beta = .1mV/pA
meta.iSettings.sigCond.Ch = 1;
meta.iSettings.sigCond.gain = 10;
meta.iSettings.sigCond.freq = 5;
meta.iSettings.softGain   = 1000/(meta.iSettings.betaRear * meta.iSettings.betaFront * meta.iSettings.sigCond.gain);

% Voltage input settings
meta.vSettings.sigCond.Ch = 2;
meta.vSettings.sigCond.gain = 10;
meta.vSettings.sigCond.freq = 5;
meta.vSettings.softGain = 1000/(meta.vSettings.sigCond.gain * 10); % To get voltage in mV

% External current pulse command
meta.pulseAmp = 0.0394;
meta.pulseDur = 1;
meta.pulseStart = 1*meta.outRate + 1;
meta.pulseEnd = 2*meta.outRate;
meta.pulseCommand = zeros(size(stim.stimulus));
switch pulseType
    case 'none'
        meta.pulseAmp = 0;
    case 'i'
        meta.pulseAmp = 0.0394;
    case 'v'
        meta.pulseAmp = 5/6;
end        
meta.pulseCommand(meta.pulseStart:meta.pulseEnd) = meta.pulseAmp.*ones(meta.pulseDur*meta.outRate,1);


%% Parameters not saved
inChannelsUsed  = 0:5;


%% Configure daq
% daqreset;
devID = 'Dev1';

%% Configure ouput session
sOut = daq.createSession('ni');
sOut.Rate = meta.outRate;

% Analog Channels / names for documentation
aO = sOut.addAnalogOutputChannel(devID,0:1,'Voltage');

% Add trigger
sOut.addTriggerConnection('External','Dev1/PFI3','StartTrigger');


%% Configure input session
sIn = daq.createSession('ni');
sIn.Rate = meta.inRate;
sIn.DurationInSeconds = stim.totalDur;

aI = sIn.addAnalogInputChannel(devID,inChannelsUsed,'Voltage');
for i = 1+inChannelsUsed
    aI(i).InputType = meta.bob.aiType;
end

% Add Trigger
sIn.addTriggerConnection('Dev1/PFI1','External','StartTrigger');

%% Run trials
sOut.queueOutputData([stim.stimulus,meta.pulseCommand]);
fprintf('**** Starting acquisition ****\n')
sOut.startBackground; % Start the session that receives start trigger first
rawData = sIn.startForeground;


%% Decode telegraphed output
[meta.scSettings.gain, meta.scSettings.freq, meta.scSettings.mode] = decodeTelegraphedOutput(rawData,...
    meta.bob.gainCh+1,meta.bob.freqCh+1,meta.bob.modeCh+1);


%% Process and plot non-scaled data
% Process
data.voltage = meta.vSettings.softGain .* rawData(:,meta.bob.voltCh+1);
data.current = meta.iSettings.softGain .* rawData(:,meta.bob.currCh+1);


%% Process and plot scaled data
% Scaled output
switch meta.scSettings.mode
    % Voltage Clamp
    case {'Track','V-Clamp'}
        meta.scSettings.softGain = 1000/(meta.scSettings.gain);
        meta.scSettings.beta  = 0.1;
        meta.scSettings.gain;
        meta.scSettings.alpha = meta.scSettings.gain/meta.scSettings.beta;
        data.scaledCurrent = meta.scSettings.softGain .* rawData(:,meta.bob.scalCh+1);
        
    % Current Clamp
    case {'I=0','I-Clamp Normal','I-Clamp Fast'}
        meta.scSettings.softGain = 1000/(meta.scSettings.gain);
        data.scaledVoltage = meta.scSettings.softGain .* rawData(:,meta.bob.scalCh+1);
        
end


%% Only if saving data
if nargin == 7 
    % Set meta data
    meta.pre        = prefixCode;
    meta.expNum     = expNum;
    meta.flyNum     = flyNum;
    meta.flyExpNum  = flyExpNum;
    meta.codeStamp = getCodeStamp(1);

    % Get filename and save data
    [fileName,path] = getDataFileName(prefixCode, expNum, flyNum, flyExpNum);
    if ~isdir(path)
        mkdir(path);
    end
    save(fileName, 'data','meta','stim');
end

%% Close daq objects
sOut.stop;
sIn.stop;

%% Plot data
plotData(stim,meta,data)




end
