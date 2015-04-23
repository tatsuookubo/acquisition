function ldvStimSet_001(exptInfo)

% Produces the default pip train while switching between all three speakers


%% Set up and acquire with the stimulus set
numberOfStimuli = 1;
stimRan = randperm(numberOfStimuli);
trialMeta.stimNum = 1; 

for n = 1:100
    stim = pickStimulus(1);
    acquireLDVTrial(stim,exptInfo,trialMeta);
end

FS.Clear() ;  % Clear up the box
clear FS ;

    function stim = pickStimulus(stimNum)
        switch stimNum
            case 1
                stim = PipStimulus;
                stim.speaker = 2;
                stim.pipDur = 0.015; 
                stim.numPips = 10; 
                stim.ipi = 0.034;   
                stim.startPadDur = 1; 
        end
    end


end
