function roiNum = newRoi

roiNum = 1; 

folder = getpref('scimSavePrefs','folder');
    
while( isdir([folder,'\roiNum',num2str(roiNum,'%03d')]) )
    roiNum = roiNum + 1;
end

if ~strcmp(newRoi,'y') && roiNum ~= 1
    roiNum = roiNum -1; 
end 

setpref('scimSavePrefs','roiNum',roiNum);
fprintf(['ROI Number = ',num2str(roiNum),'\n']);

roiDescrip = input('Give ROI description: ');
setpref('scimSavePrefs','roiDescrip',roiDescrip);

