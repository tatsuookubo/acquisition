function plotDataGroupedByStim(prefixCode,expNum,flyNum,cellNum,cellExpNum)

close all

%% Plot settings
set(0,'DefaultAxesFontSize', 16)
set(0,'DefaultFigureColor','w')
set(0,'DefaultAxesBox','off')

gray = [192 192 192]./255;
Colors = {'r','g','b'};



%% Plot
numStim = length(GroupData);


fig = figure();
setCurrentFigurePosition(2)

h(1) = subplot(3,1,1);
plot(GroupStim.stimTime,GroupStim.stimulus,'k')
hold on
ylabel('Voltage (V)')
%     title(['Stimulus = ',num2str(n),', ',char(speakers(count))])
set(gca,'Box','off','TickDir','out','XTickLabel','')

h(3) = subplot(3,1,2);
plot(GroupData.sampTime,mean(GroupData.voltage(1:5,:)),'k')
hold on
plot(GroupData.sampTime,mean(GroupData.voltage(6:10,:)),'r')
ylabel('Voltage (mV)')
set(gca,'Box','off','TickDir','out','XTickLabel','')

h(2) = subplot(3,1,3);
plot(GroupData.sampTime,mean(GroupData.current(1:5,:)),'k')
hold on
plot(GroupData.sampTime,mean(GroupData.current(6:10,:)),'r')
%     ylim([-40 -20])
xlabel('Time (s)')
ylabel('Current (pA)')
set(gca,'Box','off','TickDir','out')


linkaxes(h,'x')

% saveFilename = ['C:\Users\Alex\My Documents\TempFigs\GroupedFigure_',num2str(n)];
% print(fig,'-dmeta',saveFilename,'-r300')


end