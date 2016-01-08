function pvpp

%% Find out the folder
folder = uigetdir;

%% Make sure folder is empty
cd(folder)
movieFileNames = dir('*.tif');

%% Load movie
numMovies = length(movieFileNames);
for i = 1:numMovies
    % Get movie info
    imageFileName = movieFileNames(i).name;
    warning('off','MATLAB:imagesci:tiffmexutils:libtiffWarning')
    imInfo = imfinfo(imageFileName);
    powerLevels(i) = str2num(char(regexp(imInfo(1).ImageDescription,'(?<=state.init.eom.maxPower=).*(?=state.init.eom.usePowerArray)','match')));
    frameRate = str2num(char(regexp(imInfo(1).ImageDescription,'(?<=state.acq.frameRate=).*(?=state.acq.zoom)','match')));
    chans = regexp(imInfo(1).ImageDescription,'state.acq.acquiringChannel\d=1');
    numChans = length(chans);
    numFrames = round(length(imInfo)/numChans);
    im1 = imread(imageFileName,'tiff','Index',1,'Info',imInfo);
    numPx = size(im1);
    
    % Read in movie
    mov = zeros([numPx(:); numChans; numFrames; numMovies]', 'double');  %preallocate 3-D array
    try
        for frame=1:numFrames
            for chan = 1:numChans
                [mov(:,:,chan,frame)] = imread(imageFileName,'tiff',...
                    'Index',(2*(frame-1)+chan),'Info',imInfo);
            end
        end
    catch
        numFrames = numFrames -1;
        for frame=1:numFrames
            for chan = 1:numChans
                [mov(:,:,chan,frame)] = imread(fullfile(pathName,imageFileName),'tiff',...
                    'Index',(2*(frame-1)+chan),'Info',imInfo);
            end
        end
    end

    
    %% Image processing
    % Remove the last line where the image doesn't change
    mov(64,:,:,:,:)=[];

    
    %% Remove the first frame due to shutter problem 
    mov(:,:,:,1) = [];    
    
    %% Separate channels
    greenMov = squeeze(mov(:,:,2,:,:));
    
    movieMeans(i) = mean(greenMov(:)); 
    movieVars(i) = var(greenMov(:));
    
end

close all
figure
plot(movieMeans,movieVars,'o')
xlabel('mean')
ylabel('variance')
a = powerLevels'; b = num2str(a); c = cellstr(b);
dx = 0; dy = 0; % displacement so the text does not overlay the data points
text(movieMeans+dx, movieVars+dy, c);

figure 
plot(movieMeans.^2,movieVars,'o')
xlabel('mean squared')
ylabel('variance')
meanN = (movieMeans.^2)./movieVars; 
a = [powerLevels;meanN]'; b = num2str(a); c = cellstr(b);
dx = 0; dy = 0; % displacement so the text does not overlay the data points
text(movieMeans.^2+dx, movieVars+dy, c);