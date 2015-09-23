function twoPhotonStimSet_002(trialMeta)

% Goes through an array of speaker stimuli for the two photon



%% Set up and acquire with the stimulus set
blockNum = newBlock;
pause on
numberOfStimuli = 22;
stimRan = randperm(numberOfStimuli);

count = 1;
repeat = 1;
while repeat < 4
    trialMeta.stimNum = stimRan(count);
    fprintf(['\nStimNum = ',num2str(trialMeta.stimNum)])
    fprintf(['\nRepeatNum = ',num2str(repeat)])
    stim = pickStimulus(trialMeta.stimNum,blockNum);
    switchSpeaker(stim.speaker);
    metaFileName = acquireTwoPhotonTrial(stim,trialMeta);
    postMultTrialPlot(metaFileName,'Online')
    if count == numberOfStimuli
        count = 1;
        stimRan = randperm(numberOfStimuli);
        repeat = repeat + 1;
    else
        count = count+1;
    end
end

end

function stim = pickStimulus(stimNum,blockNum)
switch stimNum
    case 1
        stim = PipStimulus;
        stim.speaker = 2;
        stim.maxVoltage = 2; 
        switchBlock(blockNum+stimNum-1,'pip')
    case 2
        stim = Chirp;
        stim.speaker = 2;
        stim.maxVoltage = 2; 
        switchBlock(blockNum+stimNum-1,'ascending chirp')
    case 3
        stim = Chirp;
        stim.startFrequency  = 1500;
        stim.endFrequency    = 90;
        stim.maxVoltage = 2; 
        switchBlock(blockNum+stimNum-1,'descending chirp')
    case 4
        stim = CourtshipSong;
        stim.speaker = 2;
        stim.maxVoltage = 2; 
        switchBlock(blockNum+stimNum-1,'courtship song')
    case 5
        stim = PulseSong;
        stim.speaker = 2;
        stim.maxVoltage = 2; 
        switchBlock(blockNum+stimNum-1,'pulse song')
    case 6
        stim = ClickStimulus;
        stim.speaker = 2;
        stim.maxVoltage = 2; 
        switchBlock(blockNum+stimNum-1,'click')
    case num2cell(7:17)
        stimNumStart = 7;
        stim = SineWave;
        stim.maxVoltage = 2; 
        stim.carrierFreqHz = 25*sqrt(2)^((stimNum-stimNumStart)+1);
        switchBlock(blockNum+stimNum-1,['sine wave ',num2str(stim.carrierFreqHz),'Hz'])
    case num2cell(18:22)
        stimNumStart = 18;
        stim = AmTone;
        stim.maxVoltage = 2; 
        stim.carrierFreqHz = 300;
        stim.modFreqHz = 2^(stimNum - stimNumStart);
        switchBlock(blockNum+stimNum-1,['AM Tone, 300Hz carrier, ',num2str(stim.modFreqHz),'Hz mod freq'])
end
end




