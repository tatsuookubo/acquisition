function sumDoc2P(exptInfo,FlyData,filename)

dateNumber = datenum(exptInfo.dNum,'yymmdd');
dateAsString = datestr(dateNumber,'mm-dd-yy');
exptInfoText = ['Experiment date: ',dateAsString,'\n','Experiment start time: ',exptInfo.exptStartTime,'\n','Prefix code: ',exptInfo.prefixCode,'\n','ExpNum: ',num2str(exptInfo.expNum),'\n','FlyNum: ',num2str(exptInfo.flyNum),'\n'];
flyDataText = ['Line: ',FlyData.line,'\n','Left antenna: ',FlyData.freenessLeft,'\n','Right antenna: ',FlyData.freenessRight,...
    '\n','Prep type: ',FlyData.prepType,'\n','Notes on dissection: ',FlyData.notesOnDissection,'\n','Eclosion date: ',FlyData.eclosionDate,'\n'];

fileID = fopen(filename,'a');
fprintf(fileID,exptInfoText);
fprintf(fileID,flyDataText);
fclose(fileID);

end