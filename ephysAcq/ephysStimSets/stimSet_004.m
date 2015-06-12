function stimSet_004(exptInfo,preExptData)

% Produces the default pip train while switching between all three speakers

%% Archive this code
archiveExpCode(exptInfo)

%% Set up and acquire with the stimulus set
numberOfStimuli = 9;
stimRan = randperm(numberOfStimuli);

count = 1;
FS = stoploop('Stop Experiment');
while ~FS.Stop()
    trialMeta.stimNum = stimRan(count);
    fprintf(['\nStimNum = ',num2str(trialMeta.stimNum)])
    stim = pickStimulus(trialMeta.stimNum);
    switchSpeaker(stim.speaker);
    acquireTrial('i',stim,exptInfo,preExptData,trialMeta);
    if count == 9
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
                stim.speaker = 1;
            case 2
                stim = PipStimulus;
                stim.speaker = 2;
            case 3
                stim = PipStimulus;
                stim.speaker = 3;
            case 4
                stim = CourtshipSong;
                stim.speaker = 1;
            case 5
                stim = CourtshipSong;
                stim.speaker = 2;
            case 6
                stim = CourtshipSong;
                stim.speaker = 3;
            case 7
                stim = PulseSong;
                stim.speaker = 1;
            case 8
                stim = PulseSong;
                stim.speaker = 2;
            case 9
                stim = PulseSong;
                stim.speaker = 3;
        end
    end


end
