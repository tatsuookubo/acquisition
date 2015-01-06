function meta = preExptRoutine


%% Measure pipette resistance 
contAns = input('Would you like to measure pipette resistance? ','s');
if strcmp(contAns,'y')
    meta.pipetteResistance = measurePipetteResistance;
    fprintf(['\nPipette Resistance = ',num2str(meta.pipetteResistance),' MOhms\n\n'])
end

%% Measure seal resistance 
contAns = input('Would you like to measure seal resistance? ','s');
if strcmp(contAns,'y')
    meta.sealResistance = measurePipetteResistance;
    fprintf(['\nSeal Resistance = ',num2str(meta.sealResistance),' MOhms\n\n'])
end

%% Measure access and membrane resistance and holding current
disp('Switch off seal test, stay in voltage clamp')
contAns = input('Would you like to measure access resistance? ','s');
if strcmp(contAns,'y')
    [meta.holdingCurrent, meta.initialAccessResistance, meta.initialMembraneResistance] = measureAccessResistance;
    fprintf(['\nHolding Current = ',num2str(meta.holdingCurrent),' pA\n'])
    fprintf(['Access Resistance = ',num2str(meta.initialAccessResistance),' MOhms\n'])
    fprintf(['Membrane Resistance = ',num2str(meta.initialMembraneResistance),' MOhms\n\n'])
end


%% Measure resting voltage 
contAns = input('Would you like to run a trial in I=0? ','s');
if strcmp(contAns,'y')
    data = acquireTrial;
    meta.restingVoltage = mean(data.voltage); 
    fprintf(['\nResting Voltage = ',num2str(meta.restingVoltage),' mV\n\n'])
end