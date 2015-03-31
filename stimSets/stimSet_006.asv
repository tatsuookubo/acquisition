function stimSet_006(exptInfo,preExptData)

% Produces the default pip train while switching between all three speakers

%% Archive this code
archiveExpCode(exptInfo)

%% Set up and acquire with the stimulus set
numberOfStimuli = 4;
stimRan = randperm(numberOfStimuli);

count = 1;
FS = stoploop('Stop Experiment');
while ~FS.Stop()
    trialMeta.stimNum = stimRan(count);
    fprintf(['\nStimNum = ',num2str(trialMeta.stimNum)])
    stim = pickStimulus(trialMeta.stimNum);
    switchSpeaker(stim.speaker);
    acquireTrial('i',stim,exptInfo,preExptData,trialMeta);
    if count == numberOfStimuli
        count = 1;
        stimRan = randperm(numberOfStimuli);
    else
        count = count+1;
    end
end

FS.Clear() ;  % Clear up the box
clear FS ;

    function stim = pickStimulus(stimNum)
        switch stimNum
            case 1
                stim = PipStimulus;
                stim.speaker = 2;  
                
                
            case 2
                stim = PipStimulus;
                stim.speaker = 2;
                stim.pipDur = 0.015; 
                stim.numPips = 10; 
                stim.ipi = 0.034;
            case 3
                stim = PipStimulus;
                stim.speaker = 2;  
                stim.carrierFreqHz = 100; 
            case 4
                stim = PipStimulus;
                stim.speaker = 2;
                stim.pipDur = 0.015; 
                stim.numPips = 10; 
                stim.ipi = 0.034;
                stim.carrierFreqHz = 100; 
        end
    end


end
