function stimSet_010(exptInfo,preExptData)

% Produces the default pip train while switching between all three speakers

%% Archive this code
archiveExpCode(exptInfo)

%% Set up and acquire with the stimulus set
numberOfStimuli = 22;
stimRan = randperm(numberOfStimuli);

count = 1;
repeat = 1;
while repeat < 4
    trialMeta.stimNum = stimRan(count);
    fprintf(['\nStimNum = ',num2str(trialMeta.stimNum)])
    fprintf(['\nRepeatNum = ',num2str(repeat)])
    stim = pickStimulus(trialMeta.stimNum);
    switchSpeaker(stim.speaker);
    acquireTrial('i',stim,exptInfo,preExptData,trialMeta);
    if count == numberOfStimuli
        count = 1;
        stimRan = randperm(numberOfStimuli);
        repeat = repeat + 1;
    else
        count = count+1;
    end
end

end

function stim = pickStimulus(stimNum)
switch stimNum
    case 1
        stim = PipStimulus;
        stim.speaker = 2;
    case 2
        stim = Chirp;
        stim.speaker = 2;
    case 3
        stim = Chirp;
        stim.startFrequency  = 1500;
        stim.endFrequency    = 90;
    case 4
        stim = CourtshipSong;
        stim.speaker = 2;
    case 5
        stim = PulseSong;
        stim.speaker = 2;
    case 6
        stim = ClickStimulus;
        stim.speaker = 2;
    case num2cell(7:17)
        stimNumStart = 7;
        stim = SineWave;
        stim.carrierFreqHz = 25*sqrt(2)^((stimNum-stimNumStart)+1);
    case num2cell(18:22)
        stimNumStart = 18;
        stim = AmTone;
        stim.carrierFreqHz = 300;
        stim.modFreqHz = 2^(stimNum - stimNumStart);
end
end




