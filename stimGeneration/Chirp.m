classdef Chirp < AuditoryStimulus
    % Basic subclass for courtship song
    %
    % AVB 2015
    
    properties
        startFrequency  = 90;
        endFrequency    = 1500;
        chirpLength     = 10;
    end
    
    properties (Dependent = true, SetAccess = private)
        stimulus
    end
    
    methods
        %%------Constructor-----------------------------------------------------------------
        function stimulus = get.stimulus(obj)
            stimTime = (1/obj.sampleRate):(1/obj.sampleRate):obj.chirpLength;
            stimulus = chirp(stimTime,obj.startFrequency,stimTime(end),obj.endFrequency)';
%             spectrogram(y,256,250,256,1E5,'yaxis')
            
            % Add pause at the beginning of of the stim
            stimulus = obj.addPad(stimulus);
        end
        
                
        %%------Plot Spectogram--------------------------------------------------------------------
        function spectPlot(obj,varargin)
            spectrogram(obj.stimulus,128,64,0:10:1500,obj.sampleRate,'yaxis');
            box off; axis on;
            set(gca,'TickDir','Out')
            title('Current Auditory Stimulus','FontSize',obj.defaultFontSize)
            ylabel('Frequency (Hz)','FontSize',obj.defaultFontSize)
            xlabel('Time (seconds)','FontSize',obj.defaultFontSize)
        end
        
    end
    
end