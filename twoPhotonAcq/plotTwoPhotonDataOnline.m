function data = plotTwoPhotonDataOnline(imageFileName,metaFileName)


imageFolder = 'C:\Users\Alex\Documents\Data\CalciumImagingData\beads\expNum001\flyNum002\roiNum002\';
metaFileName = [imageFolder,'beads_expNum001_flyNum002_roiNum002_trialNum001.mat'];
imageFileName = [imageFolder,'beads_expNum001_flyNum002_roiNum002_trialNum001_image.tif'];

%% Load image and meta data
% Load meta data 
load(metaFileName);

% Get image info
imInfo = imfinfo(imageFileName);
chans = regexp(imInfo(1).ImageDescription,'state.acq.acquiringChannel\d=1');
numChans = length(chans);
numFrames = round(length(imInfo)/numChans);
im1 = imread(imageFileName,'tiff','Index',1,'Info',imInfo);
numPx = size(im1);

% Read in image 
mov = zeros([numPx(:); numChans; numFrames]', 'double');  %preallocate 3-D array
for frame=1:numFrames
    for chan = 1:numChans
        [mov(:,:,chan,frame)] = imread(imageFileName,'tiff',...
            'Index',(2*(frame-1)+chan),'Info',imInfo);
    end
end

%% Image processing
% Remove the last line where the image doesn't change
mov(64,:,:,:)=[];

%% Load or select ROI
currRoiNum = getpref('scimSavePrefs','roiNum');
lastRoiNum = getpref('scimPlotPrefs','lastRoiNum');
roifig = figure;
colormap(gray);
greenAvg = squeeze(nanmean(mov(:,:,2,:),4));
imagesc(greenAvg);
if lastRoiNum == currRoiNum
    oldRoi = getpref('scimPlotPrefs','roi');
    roi = impoly(gca,oldRoi);
    mask = createMask(roi);
else    
    roiObj = imfreehand(gca,'Closed',1);
    roi = wait(roiObj);
    mask = createMask(roiObj);
end
close(roifig)

%% Calculate fluorescence count in ROI
greenMov = squeeze(mov(:,:,2,:));
repMask = squeeze(repmat(mask,[1,1,1,numFrames]));
greenMov(~repMask) = NaN;
fCount = squeeze(nanmean(nanmean(greenMov,2),1));

%% Save roi
%setpref('scimPlotPrefs','roi',roi);
data.roi = roi;

%% Get frame timing data 
% find(max(data.yMirror),'first',1))
sampsPerFrame = round(length(Stim.stimulus)/(numFrames + 0.5));
frameDivisions = round(0.5*sampsPerFrame + sampsPerFrame.*(0:66));
for i = 1:length(frameDivisions)
    if i == length(frameDivisions) 
        yMirrorSubset = data.yMirror(frameDivisions(i):end);
    else 
        yMirrorSubset = data.yMirror(frameDivisions(i):frameDivisions(i+1));
    end
    [~,maxIdx] = max(yMirrorSubset);
    frameEndIdxs(i) = frameDivisions(i) + maxIdx - 1;
end

frameTimes = Stim.timeVec(frameEndIdxs);

% % Check 
% figure
% plot(Stim.timeVec,data.yMirror) 
% hold on 
% plot(Stim.timeVec(frameDivisions),0,'ro')
% hold on 
% plot(Stim.timeVec(frameEndIdxs),2,'go')

%% Plot
figure()
ax(1) = subplot(2,1,1);
plot(Stim.timeVec,Stim.stimulus)
ylabel('Stimulus level (V)') 
ax(2) = subplot(2,1,2);
plot(frameTimes,fCount)
ylabel('F (counts)')
xlabel('Time (s)')
linkaxes(ax(:),'x')


end



% function exp_t = makeScimStackTime(i_info,num_frame,params)
% dscr = i_info(1).ImageDescription;
% strstart = regexp(dscr,'state.acq.frameRate=','end');
% strend = regexp(dscr,'state.acq.frameRate=\d*\.\d*','end');
% delta_t = 1/str2double(dscr(strstart+1:strend));
% t = makeInTime(params);
% exp_t = [fliplr([-delta_t:-delta_t:t(1)]), 0:delta_t:t(end)];
% exp_t = exp_t(1:num_frame);



