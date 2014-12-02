function acquireTrial(stim,prefixCode,expNum,flyNum,flyExpNum)

%% Meta data 
meta.pre        = prefixCode; 
meta.expNum     = expNum; 
meta.flyNum     = flyNum; 
meta.flyExpNum  = flyExpNum; 


%% Parameters 
meta.outRate    = stim.sampleRate; 
meta.inRate     = 10E3; 
meta.dur        = stim.stimulusDur;

meta.bob.currCh = 0;
meta.bob.voltCh = 1;
meta.bob.scalCh = 2; 
meta.bob.gainCh = 3; 
meta.bob.freqCh = 4; 
meta.bob.modeCh = 5; 

meta.bob.aiType = 'SingleEnded'; 

% Current output settings
meta.iSettings.betaRear   = 100; % Rear switch for current output set to beta = 100mV/pA 
meta.iSettings.betaFront  = 0.1; % Front swtich for current output set to beta = .1mV/pA 
meta.iSettings.sigCond.Ch = 1; 
meta.iSettings.sigCond.gain = 1;
meta.iSettings.sigCond.freq = 5; 
meta.iSettings.softGain   = 1000/(meta.iSettings.betaRear * meta.iSettings.betaFront * meta.iSettings.sigCond.gain); 

% Voltage output settings 
meta.vSettings.sigCond.Ch = 2; 
meta.vSettings.sigCond.gain = 10;
meta.vSettings.sigCond.freq = 5; 
meta.vSettings.softGain = 1000/(meta.vSettings.sigCond.gain * 10); % To get voltage in mV 




%% Parameters not saved
inChannelsUsed  = 0:5;

%% Asign filename
% Use dataCzar function
[fileName,path] = getDataFileName(prefixCode, expNum, flyNum, flyExpNum);
if ~isdir(path)
    mkdir(path);
end

%% Configure daq
fprintf('**** Initializing DAQ ****\n')
close all force;
% daqreset;
devID = 'Dev1';

%% Configure ouput session
sOut = daq.createSession('ni');
sOut.Rate = meta.outRate;

% Analog Channels / names for documentation
aO = sOut.addAnalogOutputChannel(devID,0,'Voltage');

% Add trigger 
sOut.addTriggerConnection('External','Dev1/PFI3','StartTrigger');


%% Configure input session
sIn = daq.createSession('ni');
sIn.Rate = meta.inRate;
sIn.DurationInSeconds = meta.dur;

aI = sIn.addAnalogInputChannel(devID,inChannelsUsed,'Voltage');
for i = 1+inChannelsUsed
aI(i).InputType = meta.bob.aiType;
end

% Add Trigger
sIn.addTriggerConnection('Dev1/PFI1','External','StartTrigger'); 

%% Run trials
sOut.queueOutputData([stim.stimulus]);
fprintf('**** Starting acquisition ****\n')
sOut.startBackground; % Start the session that receives start trigger first 
rawData = sIn.startForeground;




%% Plot
% outputTime = 1/outRate:1/outRate:stimDur;
% inputTime  = 1/inRate:1/inRate:stimDur;
% h(1) =  subplot(2,1,1); 
% plot(outputTime',stim.stimulus+1,'r') 
% title('Sound Stimulus') 
% h(2) = subplot(2,1,2);
% plot(inputTime',data)
% title('Voltage')
% linkaxes(h,'x') 

%% Decode telegraphed output 
[meta.scSettings.gain, meta.scSettings.freq, meta.scSettings.mode] = decodeTelegraphedOutput(rawData,...
    meta.bob.gainCh+1,meta.bob.freqCh+1,meta.bob.modeCh+1);


%% Process and plot non-scaled data
% Process
data.voltage = meta.vSettings.softGain .* rawData(:,meta.bob.voltCh+1);
data.current = meta.iSettings.softGain .* rawData(:,meta.bob.currCh+1);

fprintf('\n mean current = ')
mean(data.current) 
fprintf('\n mean voltage = ')
mean(data.voltage) 

% Plot 
figure() 
h(1) = subplot(3,1,1); 
plot(stim.stimulus) 
h(2) = subplot(4,1,2); 
plot(data.voltage)
title(['voltage, softGain = ',num2str(meta.vSettings.softGain)])
ylabel('mV') 
ylimV = ylim; 
h(4) = subplot(4,1,4); 
plot(data.current,'r')
title(['current, softGain = ',num2str(meta.iSettings.softGain)]) 
ylabel('pA') 
ylimI = ylim; 

%% Process and plot scaled data
% Scaled output
switch meta.scSettings.mode 
    % Voltage Clamp
    case {'Track','V-Clamp'}
        meta.scSettings.softGain = 1000/(meta.scSettings.gain);
        meta.scSettings.beta  = 0.1;
        meta.scSettings.gain
        meta.scSettings.alpha = meta.scSettings.gain/meta.scSettings.beta;
        data.scaledCurrent = meta.scSettings.softGain .* rawData(:,meta.bob.scalCh+1); 
        h(3) = subplot(4,1,3); 
        plot(data.scaledCurrent,'r')
        title(['scaled current, softGain = ',num2str(meta.scSettings.softGain)])
        ylabel('pA')   
        ylim(ylimI);
%         linkaxes(hI,'y')
%         h = [hV,hI];
%         linkaxes(h,'x')
         fprintf('\n mean scaled current = ')
mean(data.scaledCurrent)  

    fprintf('\n gain = x%4.1f\n freq = %d kHz\n mode = %s\n',meta.scSettings.alpha,meta.scSettings.freq,meta.scSettings.mode) 
    % Current Clamp 
    case {'I=0','I-Clamp Normal','I-Clamp Fast'}
        meta.scSettings.softGain = 1000/(meta.scSettings.gain);
        data.scaledVoltage = meta.scSettings.softGain .* rawData(:,meta.bob.scalCh+1); 
        h(3) = subplot(4,1,3);
        plot(data.scaledVoltage)
        title(['scaled voltage, softGain = ',num2str(meta.scSettings.softGain)])
        ylabel('mV') 
        ylim(ylimV); 
%         linkaxes(hV,'y')
%         h = [hV,hI];

fprintf('\n mean scaled voltage = ')
mean(data.scaledVoltage) 
    fprintf('\n gain = x%4.1f\n freq = %d kHz\n mode = %s\n',meta.scSettings.gain,meta.scSettings.freq,meta.scSettings.mode) 
end
       linkaxes(h,'x')
       
     plotData(stim,meta,data)

%% Save data 
save(fileName, 'data','meta','stim');






%% Close daq objects 
sOut.stop;
sIn.stop;
end
