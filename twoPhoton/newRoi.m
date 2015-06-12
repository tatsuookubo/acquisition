function roiNum = newRoi

roiNum = 1; 

folder = getpref('scimSavePrefs','folder');
    
while( isdir([folder,'\roiNum',num2str(roiNum,'%03d')]) )
    roiNum = roiNum + 1;
end

if ~strcmp(newRoi,'y') && roiNum ~= 1
    roiNum = roiNum -1; 
end 

fprintf(['ROI Number = ',num2str(roiNum),'\n']);

if strcmp(newRoi,'y')
    setpref('scimSavePrefs','roiNum',roiNum)
    roiDescrip = input('Give ROI description: ','s');
    setpref('scimSavePrefs','roiDescrip',roiDescrip);
end
