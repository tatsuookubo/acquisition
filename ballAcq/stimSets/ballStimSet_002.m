function ballStimSet_002(exptInfo)

% Produces the default pip train while switching between all three speakers

%% Archive this code
archiveExpCodeBall(exptInfo)

%% Set up and acquire with the stimulus set
rng('shuffle');
numberOfStimuli = 21;
trialsPerBlock = 20;
speakerNonRan = repmat(1:numberOfStimuli,1,trialsPerBlock/numberOfStimuli);
stimRan = speakerNonRan(randperm(trialsPerBlock));

count = 1;
stop = 0;
while stop == 0
    trialMeta.pauseDur = rand(1,1);
    pause on 
    pause(trialMeta.pauseDur);
    trialMeta.stimNum = stimRan(count);
    stim = pickStimulus(trialMeta.stimNum);
    trialMeta.outputCh = switchSpeakerBall(stim.speaker);
    acquireBallTrial(stim,exptInfo,trialMeta);
    if count == trialsPerBlock
        count = 1;
        stimRan = speakerNonRan(randperm(trialsPerBlock));
    else
        count = count+1;
    end
end

    function stim = pickStimulus(stimNum)
        switch stimNum
            case 1
                stim = PipStimulus;
                stim.startPadDur = 2;
                stim.endPadDur = 2;
                stim.speaker = 1;     % Left speaker
                stim.maxVoltage = 1.5;
            case 2
                stim = PipStimulus;
                stim.startPadDur = 2;
                stim.endPadDur = 2;
                stim.speaker = 3;       % Right speaker
                stim.maxVoltage = 1.5;
        end
        
        switch stimNum
            case 1
                stim = PipStimulus;
                stim.speaker = 1;
                stim.maxVoltage = 1.5;
                stim.startPadDur = 2;
                stim.endPadDur = 2;
            case 2
                stim = Chirp;
                stim.speaker = 1;
                stim.maxVoltage = 1.5;
                stim.startFrequency  = 400;
                stim.endFrequency    = 17;
                stim.mode = 'piezo';
                stim.startPadDur = 2;
                stim.endPadDur = 2;
            case 3
                stim = Chirp;
                stim.startFrequency  = 17;
                stim.endFrequency    = 400;
                stim.maxVoltage = 1.5;
                stim.mode = 'piezo';
                stim.startPadDur = 2;
                stim.endPadDur = 2;
            case 4
                stim = CourtshipSong;
                stim.speaker = 1;
                stim.maxVoltage = 1.5;
                stim.startPadDur = 2;
                stim.endPadDur = 2;
            case 5
                stim = PulseSong;
                stim.speaker = 1;
                stim.maxVoltage = 1.5;
                stim.startPadDur = 2;
                stim.endPadDur = 2;
            case 6
                stim = SquareWave;
                stim.speaker = 1;
                stim.maxVoltage = 1.5;
                stim.startPadDur = 2;
                stim.endPadDur = 2;
            case num2cell(7:16)
                freqRange = 25.*sqrt(2).^((-1:8));
                stimNumStart = 7-1;
                freqNum = stimNum - stimNumStart;
                stim = SineWave;
                stim.carrierFreqHz = freqRange(freqNum);
                stim.maxVoltage = 1.5;
                stim.startPadDur = 2;
                stim.endPadDur = 2;
            case num2cell(17:21)
                modFreqRange = 2.^(0:4);
                stimNumStart = 17-1;
                modFreqNum = stimNum - stimNumStart;
                stim = AmTone;
                stim.carrierFreqHz = 300;
                stim.modFreqHz = modFreqRange(modFreqNum);
                stim.maxVoltage = 1.5;
                stim.startPadDur = 2;
                stim.endPadDur = 2;
        end
    end

end
