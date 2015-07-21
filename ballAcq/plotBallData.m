function plotBallData(stim,rawData) 

close all

%% Decode
settings = ballSettings; 
[procData.vel(:,1),procData.disp(:,1)] = findSeq(rawData(:,1),settings.xMinVal,settings.xMaxVal,settings,'X',stim); 
[procData.vel(:,2),procData.disp(:,2)] = findSeq(rawData(:,2),settings.yMinVal,settings.yMaxVal,settings,'Y',stim); 

figure
h(1) = subplot(3,1,1) ;
plot(stim.timeVec,stim.stimulus)
title('Velocity vs. time')
h(2) = subplot(3,1,2);
plot(stim.timeVec,procData.vel(:,1))
h(3) = subplot(3,1,3);
plot(stim.timeVec,procData.vel(:,2))
linkaxes(h(:))

figure
plot(procData.disp(:,1),procData.disp(:,2))
title('X-Y displacement') 

figure
h1(1) = subplot(3,1,1) ;
plot(stim.timeVec,stim.stimulus)
title('Displacement vs. time')
h1(2) = subplot(3,1,2);
plot(stim.timeVec,procData.disp(:,1))
h1(3) = subplot(3,1,3);
plot(stim.timeVec,procData.disp(:,2))
linkaxes(h1(:))


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
    figure
    plot(seqUnrounded,'r')
    hold on 
    plot(seqUnroundedSmoothed,'b')
    hold on 
    plot(seq,'g')
    title(['Check discretisation',axis,' axis'])



end
