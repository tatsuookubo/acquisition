classdef AuditoryStimulus < handle
% Basic superclass for auditory stimuli that holds samplerate and a plotting function
%
% SLH 2014
    properties (Constant,Hidden)
        % Default setting for duration and rate
        defaultStimDurMs = 10
        defaultSampleRate = 1E5
        
        % Default pad duration - time with zero output before and after the stimulus  
        defaultPadDur = 1 

        % Default setting for amplifier input maximum
        defaultMaxVoltage = 1
        
        % Default setting for speaker arrangment 
        defaultSpeakerOrder = {'L','M','R'}; % From fly's point of view
        defaultSpeaker = 1;

        % Default setting for plotting
        defaultFontSize = 14
        defaultLineWidth = 2

        % Various subclass effects
        debug = 0
    end

    properties
        stimulusDur
        sampleRate
        padDur
        maxVoltage
        stimulus
        speakerOrder
        speaker
    end

    methods
%%------Constructor-----------------------------------------------------------------
        function obj = AuditoryStimulus(params)
            if nargin < 1
                obj.sampleRate = obj.defaultSampleRate;
                obj.stimulusDur = obj.defaultStimDurMs;
                obj.padDur = obj.defaultPadDur; 
                obj.maxVoltage = obj.defaultMaxVoltage;
                obj.speakerOrder = obj.defaultSpeakerOrder;
                obj.speaker = obj.defaultSpeaker;
            else
                obj.sampleRate = params.sampleRate;
                obj.stimulusDur = params.stimulusDur;
                obj.padDur = params.padDur; 
                obj.maxVoltage = params.maxVoltage;
                obj.speakerOrder = params.speakerOrder;
                obj.speaker = params.speaker;
            end
            obj.stimulus = [];
        end

%%------Common Utilities---------------------------------------------------------
        function carrier = makeSine(obj,frequency)
            ts = (1/obj.sampleRate):(1/obj.sampleRate):(obj.stimulusDur);
            carrier = sin(2*pi*frequency*ts)';
        end
        
        function static = makeStatic(obj)
            static = ones(obj.sampleRate*obj.stimulusDur,1);
        end


%%------Plotting--------------------------------------------------------------------
        function [figHandle,plotHandle] = plot(obj,varargin)
            timeInMs = (1E3/obj.sampleRate):(1E3/obj.sampleRate):(1E3*length(obj.stimulus)/obj.sampleRate);
            figHandle = figure('Color',[1 1 1],'Name','AuditoryStimulus'); 
            plotHandle = plot(timeInMs,obj.stimulus);
            set(plotHandle,'LineWidth',obj.defaultLineWidth)

            box off; axis on; 
            set(gca,'TickDir','Out')
            title('Current AuditoryStimulus','FontSize',obj.defaultFontSize)
            ylabel('Amplitude (V)','FontSize',obj.defaultFontSize)
            xlabel('Time (ms)','FontSize',obj.defaultFontSize)
        end
    end

end
