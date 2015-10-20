function blockNum = getBlockNum(newBlock,varargin)

if nargin == 0
    newBlock = input('New Block? ','s');
end

blockNum = 1; 

folder = getpref('scimSavePrefs','folder');
roiNum = getpref('scimSavePrefs','roiNum'); 
    
while( isdir([folder,'\roiNum',num2str(roiNum,'%03d'),'\blockNum',num2str(blockNum,'%03d')]) )
    blockNum = blockNum + 1;
end

if ~strcmp(newBlock,'y') && blockNum ~= 1
    blockNum = blockNum -1; 
end 

fprintf(['Block Number = ',num2str(blockNum),'\n'])

if strcmp(newBlock,'y')
    setpref('scimSavePrefs','blockNum',blockNum);
    probePos = input('Probe Position: ','s');
    setpref('scimSavePrefs','probePos',probePos);
end
