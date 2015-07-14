function plotBallDataOnline(stim,data) 

procTime = (data.time - data.time(1))./1000;

figure(1) 
subplot(3,1,1)
myplot(stim.timeVec,stim.stimulus) 
subplot(3,1,2) 
myplot(procTime,data.xPos)
subplot(3,1,3)
myplot(procTime,data.yPos)
