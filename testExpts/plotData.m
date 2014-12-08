function plotData(stim,meta,data)

stimTime = [1/stim.sampleRate:1/stim.sampleRate:stim.totalDur]';
figure() 
h(1) = subplot(3,1,1); 
plot(stimTime,stim.stimulus) 
ylabel('Voltage (V)') 
title('Sound Stimulus') 

sampTime = [1/meta.inRate:1/meta.inRate:stim.totalDur]';
h(3) = subplot(3,1,2); 
plot(sampTime,data.voltage) 
title('Voltage') 
ylabel('Voltage (mV)')

h(2) = subplot(3,1,3); 
plot(sampTime,data.current)
xlabel('Time (s)') 
title('Current') 
ylabel('Current (pA)') 

linkaxes(h,'x') 




