classdef ClickStimulus < AuditoryStimulus
    % Basic subclass for making series of clicks 
    
    properties
        numClicks           = 10;%10;
        ici                 = 0.5;%0.034;
    end
    
    properties (Dependent = true, SetAccess = private)
        stimulus
    end
    
    methods
       
        %%------Calculate Dependents-----------------------------------------------------------------       
        function stimulus = get.stimulus(obj)
            
            % Make click
            click = 1;
            
            % generate click train
            spacePip = [zeros(obj.ici*obj.sampleRate,1);click];
            stimulus = [click;repmat(spacePip,obj.numPips,1)];
            
            % Scale the stim to the maximum voltage in the amp
            stimulus = stimulus*obj.maxVoltage;
            
            % Add pause at the beginning of of the stim
            stimulus = obj.addPad(stimulus);
        end
        
        
        
    end
    
end