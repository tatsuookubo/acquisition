function pipetteResistance = measurePipetteResistance


    data = acquireTrial;
    
    voltDiff = max(data.voltage) - min(data.voltage);
    currDiff = max(data.current) - min(data.current); 
    
    pipetteResistance = ((voltDiff*1e-3)/(currDiff*1e-12))/1e6;  
