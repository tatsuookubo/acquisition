function [flyNum, flyExpNum] = getFlyNum(prefixCode, expNum, newFly)

        % Make numbers strings
    eNum = num2str(expNum,'%03d');
    microCzarSettings;   % Loads settings
    
    path = [dataDirectory,prefixCode,'\expNum',eNum,'\flyNum'];
    % Determine fly number 
    flyNum = 1;
    while( isdir([path,num2str(flyNum,'%03d')]) )
        flyNum = flyNum + 1;
    end
    
    flyExpNum = 1;
    if ~strcmp(newFly,'y')
        flyNum = flyNum - 1;
        flyExpNum = 1; 
        while( isdir([path,num2str(flyNum,'%03d'),'\flyExpNum',num2str(flyExpNum,'%03d')]) )
            flyExpNum = flyExpNum + 1;
        end
    end
