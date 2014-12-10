classdef AuditoryStimulus < handle
    % Basic superclass for auditory stimuli that holds samplerate and a plotting function
    %
    % SLH 2014
    
    properties (Constant,Hidden)        
        % Default setting for plotting
        defaultFontSize = 14
        defaultLineWidth = 2
    end
    
    properties
        sampleRate        = 4E4;
        startPadDur     = 3;
        endPadDur       = 1;
        maxVoltage      = 1;
        stimulus        = [];
        speakerOrder    = {'L','M','R'}; % From fly's point of view
        speaker         = 1;
    end
    
    properties (Dependent = true, SetAccess = private)
        totalDur
        stimDur
    end
    
    methods
        %%------Calculate Dependents-----------------------------------------------------------------
        function totalDur = get.totalDur(obj)
            totalDur = length(obj.stimulus)/obj.sampleRate;
        end
        
        function stimDur = get.stimDur(obj)
            stimDur = obj.totalDur - obj.startPadDur - obj.endPadDur;
        end
        
        %%------Common Utilities---------------------------------------------------------
        function carrier = makeSine(obj,frequency,dur)
            ts = (1/obj.sampleRate):(1/obj.sampleRate):(dur);
            carrier = sin(2*pi*frequency*ts)';
        end
        
        function static = makeStatic(obj,dur)
            static = ones(obj.sampleRate*dur,1);
        end
        
        function pad = addPad(obj,padType)
            switch lower(padType)
                case {'start'}
                    pad = zeros(obj.sampleRate*obj.startPadDur,1);
                    obj.stimulus = [pad;obj.stimulus];
                case {'end'}
                    pad = zeros(obj.sampleRate*obj.endPadDur,1);
                    obj.stimulus = [obj.stimulus;pad];
            end
        end
        
        
        %%------Plotting--------------------------------------------------------------------
        function [figHandle,plotHandle] = plot(obj,varargin)
            timeInMs = (1E3/obj.sampleRate):(1E3/obj.sampleRate):(1E3*length(obj.stimulus)/obj.sampleRate);
            figHandle = figure('Color',[1 1 1],'Name','AuditoryStimulus');
            plotHandle = plot(timeInMs,obj.stimulus);
            set(plotHandle,'LineWidth',obj.defaultLineWidth)
            
            box off; axis on;
            set(gca,'TickDir','Out')
            title('Current Auditory Stimulus','FontSize',obj.defaultFontSize)
            ylabel('Amplitude (V)','FontSize',obj.defaultFontSize)
            xlabel('Time (ms)','FontSize',obj.defaultFontSize)
        end
    end
    
end
