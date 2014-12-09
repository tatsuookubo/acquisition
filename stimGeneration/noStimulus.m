classdef noStimulus < AuditoryStimulus
% Basic subclass for making just the pad and no stimulus
 

    methods
%%------Constructor-----------------------------------------------------------------
        function obj = noStimulus()
            obj.generateStim();
        end

%%------Utilities---------------------------------------------------------
        function obj = generateStim(obj)
            % Make a zero stimulus that is the length of start pad
            obj.endPadDur = 0;
            obj.stimulus  = obj.addPad('start');
        end
        
    end
end
