function [velMm,disp] = processBallData_TO(rawData,minVal,maxVal,settings,stim)

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
odorStartInt = (stim.startPadDur+stim.windPre+stim.odorPre)*stim.sampleRate +1; 
disp = disp - disp(odorStartInt,1); % define (0,0) as the x, y disp at odor onset for plotting purposes
end