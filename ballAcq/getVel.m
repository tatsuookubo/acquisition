function [vel,disp] = getVel(rawData,minVal,maxVal,settings,sampRate)

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

vel = seq.*settings.mmPerCount.*settings.sensorPollFreq;

disp = 1/sampRate .* cumtrapz(vel);

