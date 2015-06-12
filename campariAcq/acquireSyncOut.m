function acquireSyncOut

%% Trackball settings 
%{
resolution  = 8200cpi 
1 inch = 25.4mm
allow for gain 

%}

set(0,'DefaultFigureWindowStyle','normal')
fprintf('\n*********** Acquiring Trial ***********\n') 

sensorRes  = 8200; 
mmConv = 25.4;


%% Load settings    
inChannelsUsed = 12;
     
%% Configure daq
% daqreset;
devID = 'Dev1';

%% Configure input session
sess = daq.createSession('ni');
sess.Rate = 10E3;
sess.DurationInSeconds = 3600;

aI = sess.addAnalogInputChannel(devID,inChannelsUsed,'Voltage');
for i = 1:length(inChannelsUsed)
    aI(i).InputType = 'SingleEnded';
end

dO = sess.addDigitalOutputChannel(devID,'port0/line0:2','OutputOnly');


sOut.queueOutputData([stim.stimulus,settings.pulse.Command]);
sOut.startBackground; % Start the session that receives start trigger first
rawData = sIn.startForeground;


%lh = sess.addlistener('DataAvailable', @(src,event) plot(event.TimeStamps, event.Data));
lh = sess.addlistener('DataAvailable', @plotData);

    function plotData(src,event) 
        
        figure(1)
        plot(event.TimeStamps, event.Data)
    end


%% Run trials
sess.NotifyWhenDataAvailableExceeds = 1e3 * 100;
% sess.IsNotifyWhenDataAvailableExceedsAuto

sess.startBackground;
sess.wait()



%% Close daq objects
delete(lh)
sess.stop;






end
