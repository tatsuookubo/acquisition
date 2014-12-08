classdef noStimulus < AuditoryStimulus
% Basic subclass for making just the pad and no stimulus
 

    methods
%%------Constructor-----------------------------------------------------------------
        function obj = noStimulus()
            obj.stimulusDur = 0;
            obj.generateStim();
            
        end

%%------Utilities---------------------------------------------------------
        function obj = generateStim(obj)
            % Make a zero stimulus that is the length of pad 
            obj.stimulus = obj.addPad();
        end
        
    end
end
