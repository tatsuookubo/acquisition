clear all 
close all

% Ask for user input: 
% flyNum,flyExpNum

%% If there is already an experiment number for this fly, create a new one.  

% archiveExpCode(prefixCode,expNum,flyNum,flyExpNum)
% switchSpeaker(n)

stim = plotTestStim;
acquireTrial(stim,'000_firstGreen',1,1,1);
