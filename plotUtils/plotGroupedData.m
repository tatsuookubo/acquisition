function plotGroupedData(prefixCode,expNum,flyNum,flyExpNum)

exptInfo.prefixCode     = prefixCode;
exptInfo.expNum         = expNum;
exptInfo.flyNum         = flyNum;
exptInfo.flyExpNum      = flyExpNum;

[~, path, ~, idString] = getDataFileName(exptInfo);
fileName = [path,idString,'groupedData.mat'];
load(fileName); 

numStim = length(GroupData);

for n = 1:numStim
    figure(n)
    setCurrentFigurePosition(2)

h(1) = subplot(3,1,1); 
plot(GroupStim(n).stimTime,GroupStim(n).stimulus) 
ylabel('Voltage (V)') 
title('Sound Stimulus') 

h(3) = subplot(3,1,2); 
plot(GroupData(n).sampTime,mean(GroupData(n).voltage)) 
title('Voltage') 
ylabel('Voltage (mV)')

h(2) = subplot(3,1,3); 
plot(GroupData(n).sampTime,mean(GroupData(n).current))
xlabel('Time (s)') 
title('Current') 
ylabel('Current (pA)') 

linkaxes(h,'x') 

    
end