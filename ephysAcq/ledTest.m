devID = 'Dev1';
x = square(1:100000,50);
x = x>0;
sOut = daq.createSession('ni');
sOut.Rate = 1E3;
sOut.addAnalogOutputChannel(devID,0,'Voltage');
sOut.queueOutputData(ones(3600000,1));
sOut.startForeground; 

