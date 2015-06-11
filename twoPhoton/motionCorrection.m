function motionCorrection 

%% Motion correction is not currently changing the image so I'm not going to do it at first
%{
% Motion correction only with green channel
refFrame = mov(:,:,2,1);    % First frame of green channel
refFFT = fft2(refFrame);
mov2(:,:,2,1) = refFrame;
for frame=2:numFrames
    [~, Greg] = dftregistration(refFFT,fft2(mov(:,:,2,frame)),1);
    mov2(:,:,2,frame) = real(ifft2(Greg));
end


figure()
for i = 1:numFrames
    subplot(3,1,1)
    imagesc(mov(:,:,2,i))
    subplot(3,1,2)
    imagesc(mov2(:,:,2,i))
    subplot(3,1,3)
    image3 = mov2(:,:,2,i) - mov2(:,:,2,i);
    imagesc(image3);
    disp(unique(image3))
    input('')
end

%}
