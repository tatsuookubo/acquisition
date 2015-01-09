function [holdingCurrent,accessResistance,membraneResistance,inputResistance] = measureAccessResistance

    [data,meta] = acquireTrial('v');
    df = meta.outRate/meta.inRate; 
    
    holdingCurrent = mean(data.current(1:round(meta.pulseStart/df)-1));
    
    % Access Resistance
    voltDiff = max(data.voltage) - min(data.voltage);
    baselineStart = round(meta.pulseStart/df/2);
    baselineEnd = round(meta.pulseStart/df)-1;
    baselineCurrent = mean(data.current(baselineStart:baselineEnd));
    peakCurrent = max(data.current(baselineEnd:round(meta.pulseEnd/df)));
    currDiff = peakCurrent - baselineCurrent;
    accessResistance = voltDiff/currDiff;
    
    % Membrane Resistance 
    pulseEnd = round(meta.pulseEnd/df);
    pulseMid = pulseEnd - 1000; 
    steadyCurrent = mean(data.current(pulseMid:pulseEnd));
    currDiff = steadyCurrent - baselineCurrent;
    membraneResistance = voltDiff/currDiff;
    
    inputResistance = accessResistance + membraneResistance; 
    