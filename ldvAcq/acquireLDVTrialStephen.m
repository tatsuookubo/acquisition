function data = acquireLDVTrialStephen

fprintf('\n*********** Acquiring Trial ***********')

%% Hard coded parameters
inChannelsUsed  = 14;
duration = 10; % Seconds
sampRate = 10E3; 
devID = 'Dev1';
ldvGain = 5;          

%% Setup session
sIn = daq.createSession('ni');
sIn.Rate = sampRate;
sIn.DurationInSeconds = duration;

aI = sIn.addAnalogInputChannel(devID,inChannelsUsed,'Voltage');
aI.InputType = 'SingleEnded';


%% Run trials
rawData = sIn.startForeground;

%% Process raw data 
data(n).velocity = (ldvGain.*rawData)';  % acquire voltage output from LDV and convert to velocity (channel ACH0)
velocity_subtracted = data(n).velocity - mean(data(n).velocity);
data(n).displacement = 10^3.*(1/(settings.sampRate.in).*cumsum(velocity_subtracted));  % displacement is integral of velocity (times 10^6 to get um from mm)


%% Plot data
plotLDVData(data(n).velocity,data(n).displacement,sampRate,duration)


end

%% plotData
function plotLDVData(velocity,displacement,sampRate,duration)

figure(1); 

h(2) = subplot(2,1,1); 
sampTime = [1/sampRate.in:1/sampRate.in:duration]';
plot(sampTime,velocity,'k','lineWidth',1); 
ylabel('velocity (mm/s)');


h(3) = subplot(2,1,2); 
plot(sampTime,displacement,'k'); 
ylabel('displacement (um)');

xlabel('time (seconds)');

linkaxes(h,'x') 
% xlim([1 1.4])
% ylim([-2 2])

end