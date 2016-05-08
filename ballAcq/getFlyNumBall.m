function [flyNum, flyExpNum] = getFlyNumBall(prefixCode, expNum, newFly, newFlyExp)

% Make numbers strings
eNum = num2str(expNum,'%03d');

% Find out data directory 
settings = ballSettings;
dataDirectory = settings.dataDirectory;

path = [dataDirectory,prefixCode,'\expNum',eNum,'\flyNum'];

% Determine fly number
flyNum = 1;
while( isdir([path,num2str(flyNum,'%03d')]) ) 
    flyNum = flyNum + 1;
end

% Determine fly experiment number 
flyExpNum = 1;
if ~strcmp(newFly,'y')
    if flyNum ~= 1
        flyNum = flyNum - 1;
    end
    while( isdir([path,num2str(flyNum,'%03d'),'\flyExpNum',num2str(flyExpNum,'%03d')]) )
        flyExpNum = flyExpNum + 1;
    end
    if ~strcmp(newFlyExp,'y')
        if flyExpNum ~= 1
            flyExpNum = flyExpNum - 1;
        end
    end
end