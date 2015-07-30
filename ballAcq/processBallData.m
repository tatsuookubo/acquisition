function [velMm,disp] = processBallData(rawData,minVal,maxVal,settings,stim)

%% LPF
rate = 2*(settings.cutoffFreq/settings.sampRate);
[kb, ka] = butter(2,rate);
smoothedData = filtfilt(kb, ka, rawData);

voltsPerStep = (maxVal - minVal)/(settings.numInts - 1);
seq = round((smoothedData - minVal)./voltsPerStep);
%seq = (smoothedData - minVal)./voltsPerStep;
maxInt = settings.numInts -1;
seq(seq>maxInt) = maxInt;
seq(seq<0) = 0;
zeroVal = -1 + (settings.numInts + 1)/2;
seq = seq - zeroVal;


velMm = seq.*settings.mmPerCount.*settings.sensorPollFreq;
disp = cumtrapz(stim.timeVec,velMm);
stimStartInt = stim.startPadDur*stim.sampleRate +1; 
disp = disp - disp(stimStartInt,1);


% Check discretisation
% seqUnrounded = (rawData - minVal)./voltsPerStep;
% seqUnrounded = seqUnrounded - zeroVal;
% seqUnroundedSmoothed = (smoothedData - minVal)./voltsPerStep;
% seqUnroundedSmoothed = seqUnroundedSmoothed - zeroVal;


%     figure
%     plot(seqUnrounded,'r')
%     hold on
%     plot(seqUnroundedSmoothed,'b')
%     hold on
%     plot(seq,'g')
%     title(['Check discretisation',axis,' axis'])



end