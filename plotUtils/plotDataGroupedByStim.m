function plotDataGroupedByStim(prefixCode,expNum,flyNum,cellNum,cellExpNum)

close all

%% Plot settings
set(0,'DefaultAxesFontSize', 16)
set(0,'DefaultFigureColor','w')
set(0,'DefaultAxesBox','off')

gray = [192 192 192]./255;

%% Load groupedData file
exptInfo.prefixCode     = prefixCode;
exptInfo.expNum         = expNum;
exptInfo.flyNum         = flyNum;
exptInfo.cellNum        = cellNum;
exptInfo.cellExpNum     = cellExpNum;

[~, path, ~, idString] = getDataFileName(exptInfo);
fileName = [path,'groupedData.mat'];
load(fileName);

saveFolder = [path,'\figures'];
if ~isdir(saveFolder)
    mkdir(saveFolder);
end

%% Plot
numStim = length(GroupData);


for n = 1:numStim
    figure(n);
    setCurrentFigurePosition(2)
    
    h(1) = subplot(3,1,1);
    plot(GroupStim(n).stimTime,GroupStim(n).stimulus,'k')
    hold on
    ylabel('Voltage (V)')
    set(gca,'Box','off','TickDir','out','XTickLabel','')
    ylim([-1.1 1.1])
    
    h(3) = subplot(3,1,2);
    plot(GroupData(n).sampTime,GroupData(n).voltage,'Color',gray)
    hold on
    plot(GroupData(n).sampTime,mean(GroupData(n).voltage),'k')
    hold on
    ylabel('Voltage (mV)')
    set(gca,'Box','off','TickDir','out','XTickLabel','')
    axis tight
    
    h(2) = subplot(3,1,3);
    plot(GroupData(n).sampTime,GroupData(n).current,'Color',gray)
    hold on
    plot(GroupData(n).sampTime,mean(GroupData(n).current),'k')
    hold on
    xlabel('Time (s)')
    ylabel('Current (pA)')
    set(gca,'Box','off','TickDir','out')
    axis tight
    
    linkaxes(h,'x')
    
    spaceplots
    
    %% Format and save
    saveFilename{n} = [saveFolder,'\GroupData_Stim',num2str(n),'.pdf'];
    set(gcf, 'PaperType', 'usletter');
    orient landscape
    export_fig(saveFilename{n},'-pdf','-q50')
      
    close all
end

append_pdfs([saveFolder,'\allFigures.pdf'],saveFilename{:})
delete(saveFilename{:})

end