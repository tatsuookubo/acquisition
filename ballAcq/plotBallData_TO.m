function plotBallData_TO(stim,rawData,trialMeta,exptInfo)
%%% plot ball data online
%%% Tatsuo Okubo
%%% 2016/05/08

close all
set(0,'DefaultFigureWindowStyle','docked')

subplot = @(m,n,p) subtightplot (m, n, p, [0.01 0.05], [0.1 0.01], [0.1 0.01]);
warning('off','MATLAB:legend:IgnoringExtraEntries')

%% Decode
settings = ballSettings;
[procData.vel(:,1),procData.disp(:,1)] = processBallData_TO(rawData(:,1),settings.xMinVal,settings.xMaxVal,settings,stim);
[procData.vel(:,2),procData.disp(:,2)] = processBallData_TO(rawData(:,2),settings.yMinVal,settings.yMaxVal,settings,stim);
sumData = sumBallData(procData,trialMeta,exptInfo);

figure(1)
h(1) = subplot(6,2,1) ;
mySimplePlot(stim.timeVec,stim.stimulus(:,1),'b'); % wind
hold on
mySimplePlot(stim.timeVec,stim.stimulus(:,2),'r'); % odor
title('Velocity and displacement vs. time')
set(gca,'XTick',[])
ylabel('Olfactometer')
set(get(gca,'YLabel'),'Rotation',0,'HorizontalAlignment','right')
set(gca,'XColor','white')
symAxisY

h(2) = subplot(6,2,3);
mySimplePlot(stim.timeVec,procData.vel(:,1))
set(gca,'XTick',[])
ylabel({'Lateral Vel';'(mm/s)'})
set(get(gca,'YLabel'),'Rotation',0,'HorizontalAlignment','right')
moveXAxis(stim)
shadestimArea(stim) 
symAxisY

h(3) = subplot(6,2,5);
mySimplePlot(stim.timeVec,procData.vel(:,2))
set(gca,'XTick',[])
ylabel({'Forward Vel';'(mm/s)'})
set(get(gca,'YLabel'),'Rotation',0,'HorizontalAlignment','right')
shadestimArea(stim) 
moveXAxis(stim)
symAxisY

h(4) = subplot(6,2,7);
mySimplePlot(stim.timeVec,procData.disp(:,1))
set(gca,'XTick',[])
ylabel({'X Disp';'(mm)'})
set(get(gca,'YLabel'),'Rotation',0,'HorizontalAlignment','right')
shadestimArea(stim) 
moveXAxis(stim)
symAxisY

h(5) = subplot(6,2,9);
mySimplePlot(stim.timeVec,procData.disp(:,2))
ylabel({'Y Disp';'(mm)'})
set(get(gca,'YLabel'),'Rotation',0,'HorizontalAlignment','right')
line([stim.timeVec(1),stim.timeVec(end)],[0,0],'Color','k')
shadestimArea(stim) 
xlabel('Time (s)')
linkaxes(h(:),'x')
symAxisY

subplot(6,2,2:2:6)
% define time points in the trial
% T1 = round((stim.startPadDur+stim.windPre)*settings.sampRate); % [samples]
% T2 = round((stim.startPadDur+stim.windPre+stim.odorPre)*settings.sampRate); % [samples]
% T3 = round((stim.startPadDur+stim.windPre+stim.odorPre+stim.odorDur)*settings.sampRate); % [samples]
% T4 = round((stim.startPadDur+stim.windPre+stim.odorPre+stim.odorDur+stim.odorPost)*settings.sampRate); % [samples]
% A1 = procData.disp(1:T1,:);
% A2 = procData.disp((T1+1):T2,:);
% A3 = procData.disp((T2+1):T3,:);
% A4 = procData.disp((T3+1):T4,:);
% A5 = procData.disp((T4+1):end,:);
% 
% plot(A1(1,1),A1(1,2),'ko')
% hold on
% text(A1(1,1),A1(1,2),'trial on','Color','k','FontSize',10);
% plot(A1(:,1),A1(:,2),'k:')
% 
% plot(A2(1,1),A2(1,2),'bo')
% text(A2(1,1),A2(1,2),'wind on','Color','b','FontSize',10);
% plot(A2(:,1),A2(:,2),'b:')
% 
% plot(A3(1,1),A3(1,2),'ro')
% text(A3(1,1),A3(1,2),'odor on','Color','r','FontSize',10);
% plot(A3(:,1),A3(:,2),'r-')
% 
% plot(A4(1,1),A4(1,2),'bo')
% text(A4(1,1),A4(1,2),'odor off','Color','b','FontSize',10);
% plot(A4(:,1),A4(:,2),'b-')
% 
% plot(A5(1,1),A5(1,2),'ko')
% text(A5(1,1),A5(1,2),'wind off','Color','b','FontSize',10);
% plot(A5(:,1),A5(:,2),'k:')

T1 = round((stim.startPadDur+stim.windPre)*settings.sampRate); % [samples]
T2 = round((stim.startPadDur+stim.windPre+stim.odorDur)*settings.sampRate); % [samples]
A1 = procData.disp(1:T1,:);
A2 = procData.disp((T1+1):T2,:);
A3 = procData.disp((T2+1):end,:);

plot(A1(1,1),A1(1,2),'ko')
hold on
text(A1(1,1),A1(1,2),'trial on','Color','k','FontSize',10);
plot(A1(:,1),A1(:,2),'k:')

plot(A2(1,1),A2(1,2),'ro')
text(A2(1,1),A2(1,2),'wind on','Color','r','FontSize',10);
plot(A2(:,1),A2(:,2),'r-')

plot(A3(1,1),A3(1,2),'bo')
text(A3(1,1),A3(1,2),'wind off','Color','b','FontSize',10);
plot(A3(:,1),A3(:,2),'b-')

symAxis
ylabel('Y displacement (mm)')
title('X-Y displacement')

subtightplot (6, 2, 11, [0.1 0.05], [0.1 0.01], [0.1 0.01]);
bar(sumData.histCenters,sumData.yVelCounts)
xlim([-20 20])
xlabel('Forward velocity (mm/s)')
ylabel('Counts')
set(get(gca,'YLabel'),'Rotation',0,'HorizontalAlignment','right')
box off;
set(gca,'TickDir','out')
axis tight

subtightplot (6, 2, 8:2:12, [0.1 0.05], [0.1 0.01], [0.1 0.01]);
uniqueStim = unique(sumData.stimNum);
numStim = length(uniqueStim);
colorSet = distinguishable_colors(trialMeta.totalStimNum,'w');
for i = 1:numStim
    stimPlotNum = uniqueStim(i);
    p(i) = plot(sumData.byStim(stimPlotNum).meanXDisp,sumData.byStim(stimPlotNum).meanYDisp,'Color',colorSet(stimPlotNum,:),'DisplayName',stim.description);
    hold on 
end
symAxis
xlabel('X displacement (mm)')
ylabel('Y displacement (mm)')
legend(p(:),'Location','best')
legend('boxoff')

%suptitle(stim.speakerOrder(stim.speaker))

end

function shadestimArea(stim) 
gray = [192 192 192]./255;
pipStarts = stim.startPadDur; 
pipEnds = stim.startPadDur + stim.stimDur;
Y = ylim(gca);
X = [pipStarts,pipEnds];
line([X(1) X(1)],[Y(1) Y(2)],'Color',gray);
line([X(2) X(2)],[Y(1) Y(2)],'Color',gray);
colormap hsv
alpha(.1)
end

function moveXAxis(stim)
set(gca,'XColor','white')
line([stim.timeVec(1),stim.timeVec(end)],[0,0],'Color','k')
end