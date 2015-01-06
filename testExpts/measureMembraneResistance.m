function membraneResistance = measureMembraneResistance(data,meta)

    df = meta.outRate/meta.inRate; 
    
    % Access Resistance
    baselineStart = round(meta.pulseStart/df/2);
    baselineEnd = round(meta.pulseStart/df)-1;
    
    pulseEnd = round(meta.pulseEnd/df);
    pulseMid = pulseEnd - 1000; 
    
    baselineVoltage = mean(data.voltage(baselineStart:baselineEnd));
    baselineCurrent = mean(data.current(baselineStart:baselineEnd));
    
    steadyVoltage = mean(data.voltage(pulseMid:pulseEnd));
    steadyCurrent = mean(data.current(pulseMid:pulseEnd));
    
    voltDiff = steadyVoltage - baselineVoltage;
    currDiff = steadyCurrent - baselineCurrent;
    
    membraneResistance = voltDiff/currDiff;
    
    fprintf(['\nMembrane Resistance = ',num2str(membraneResistance),' MOhms\n\n'])

    