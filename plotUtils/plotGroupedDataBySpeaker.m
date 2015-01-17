function plotGroupedDataBySpeaker(prefixCode,expNum,flyNum,flyExpNum)

close all

exptInfo.prefixCode     = prefixCode;
exptInfo.expNum         = expNum;
exptInfo.flyNum         = flyNum;
exptInfo.flyExpNum      = flyExpNum;

[~, path, ~, idString] = getDataFileName(exptInfo);
fileName = [path,idString,'groupedData.mat'];
load(fileName);

numStim = length(GroupData);
Colors = {'r','g','b'};
count = 0; 
figure();
    
for n = 1:numStim
    count = count+1; 
    if count == 4
        figure();
        count = 1; 
    end
    setCurrentFigurePosition(2)
    
    h(1) = subplot(3,1,1);
    plot(GroupStim(n).stimTime,GroupStim(n).stimulus,Colors{count})
    hold on 
    ylabel('Voltage (V)')
    title('Sound Stimulus')
    
    h(3) = subplot(3,1,2);
    plot(GroupData(n).sampTime,mean(GroupData(n).voltage),Colors{count})
    hold on 
    title('Voltage')
    ylabel('Voltage (mV)')
    
    h(2) = subplot(3,1,3);
    plot(GroupData(n).sampTime,mean(GroupData(n).current),Colors{count})
    hold on 
    xlabel('Time (s)')
    title('Current')
    ylabel('Current (pA)')
    
    linkaxes(h,'x')
    
    
end