classdef noStimulus < AuditoryStimulus
    % Basic subclass for making just the pad and no stimulus
    
    properties (Dependent = true, SetAccess = private)
        stimulus
    end
    
    methods
        
        %%------Calculate Dependents-----------------------------------------------------------------
        function stimulus = get.stimulus(obj)
            % Make a zero stimulus that is the length of start pad
            stimulus = [];
            obj.endPadDur = 0;
            stimulus = obj.addPad(stimulus);
        end
        
        
        %
        %         %%------Constructor-----------------------------------------------------------------
        %         function obj = noStimulus()
        %             obj.generateStim();
        %         end
        
        
%         %%------Utilities---------------------------------------------------------
%         function obj = generateStim(obj)
%             % Make a zero stimulus that is the length of start pad
%             obj.endPadDur = 0;
%             obj.stimulus  = obj.addPad('start');
%         end
%         
    end
end
