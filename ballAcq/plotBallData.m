function plotBallData(stim,rawData)

close all
set(0,'DefaultFigureWindowStyle','docked')


%% Decode
settings = ballSettings;
[procData.vel(:,1),procData.disp(:,1)] = findSeq(rawData(:,1),settings.xMinVal,settings.xMaxVal,settings,'X',stim);
[procData.vel(:,2),procData.disp(:,2)] = findSeq(rawData(:,2),settings.yMinVal,settings.yMaxVal,settings,'Y',stim);

stimStartInt = stim.startPadDur*stim.sampleRate +1; 

figure(1)
h(1) = subplot(5,2,1) ;
mySimplePlot(stim.timeVec,stim.stimulus)
title('Velocity and displacement vs. time')
set(gca,'XTick',[])
ylabel({'stim';'(V)'})
set(get(gca,'YLabel'),'Rotation',0,'HorizontalAlignment','right')
set(gca,'XColor','white')

h(2) = subplot(5,2,3);
mySimplePlot(stim.timeVec,procData.vel(:,1))
set(gca,'XTick',[])
ylabel({'Lateral Vel';'(mm/s)'})
set(get(gca,'YLabel'),'Rotation',0,'HorizontalAlignment','right')
moveXAxis(stim)
shadestimArea(stim) 

h(3) = subplot(5,2,5);
mySimplePlot(stim.timeVec,procData.vel(:,2))
set(gca,'XTick',[])
ylabel({'Forward Vel';'(mm/s)'})
set(get(gca,'YLabel'),'Rotation',0,'HorizontalAlignment','right')
shadestimArea(stim) 
moveXAxis(stim)

h(4) = subplot(5,2,7);
mySimplePlot(stim.timeVec,procData.disp(:,1))
set(gca,'XTick',[])
ylabel({'X Disp';'(mm)'})
set(get(gca,'YLabel'),'Rotation',0,'HorizontalAlignment','right')
shadestimArea(stim) 
moveXAxis(stim)

h(5) = subplot(5,2,9);
mySimplePlot(stim.timeVec,procData.disp(:,2))
ylabel({'Y Disp';'(mm)'})
set(get(gca,'YLabel'),'Rotation',0,'HorizontalAlignment','right')
line([stim.timeVec(1),stim.timeVec(end)],[0,0],'Color','k')
shadestimArea(stim) 
xlabel('Time (s)')
linkaxes(h(:),'x')



subplot(5,2,2:2:10)
dispSub(:,1) = procData.disp(:,1) - procData.disp(stimStartInt,1);
dispSub(:,2) = procData.disp(:,2) - procData.disp(stimStartInt,2);
plot(dispSub(:,1),dispSub(:,2))
hold on 
plot(dispSub(1,1),dispSub(1,2),'go')
text(dispSub(1,1),dispSub(1,2),'start','Color','g','FontSize',12);
plot(dispSub(end,1),dispSub(end,2),'ro')
text(dispSub(end,1),dispSub(end,2),'stop','Color','r','FontSize',12);
plot(0,0,'bo')
text(0,0,'stim start','Color','b','Fontsize',12);
axis square
axis equal
xMax = max(abs(dispSub(:,1)));
xlim([-xMax,xMax])
yMax = max(abs(dispSub(:,1)));
ylim([-yMax,yMax])
xlabel('X displacement (mm)')
ylabel('Y displacement (mm)')
title('X-Y displacement')

suptitle(stim.speakerOrder(stim.speaker))

end

function [velMm,disp] = findSeq(rawData,minVal,maxVal,settings,axis,stim)
%% LPF
rate = 2*(settings.cutoffFreq/settings.sampRate);
[kb, ka] = butter(2,rate);
smoothedData = filtfilt(kb, ka, rawData);

voltsPerStep = (maxVal - minVal)/(settings.numInts - 1);
seq = round((smoothedData - minVal)./voltsPerStep);
maxInt = settings.numInts -1;
seq(seq>maxInt) = maxInt;
seq(seq<0) = 0;
zeroVal = -1 + (settings.numInts + 1)/2;
seq = seq - zeroVal;

velMm = seq.*settings.mmPerCount;
disp = cumtrapz(stim.timeVec,velMm);

% Check discretisation
seqUnrounded = (rawData - minVal)./voltsPerStep;
seqUnrounded = seqUnrounded - zeroVal;
seqUnroundedSmoothed = (smoothedData - minVal)./voltsPerStep;
seqUnroundedSmoothed = seqUnroundedSmoothed - zeroVal;
%     figure
%     plot(seqUnrounded,'r')
%     hold on
%     plot(seqUnroundedSmoothed,'b')
%     hold on
%     plot(seq,'g')
%     title(['Check discretisation',axis,' axis'])



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