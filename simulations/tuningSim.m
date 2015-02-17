close all
angles = -pi:0.01:pi;

%% normal
figure()
for n = 1:3;
    
    tuningR = n*sin(2*angles);
    tuningR = abs(min(tuningR))+n*sin(2*angles);

    tuningL = n*sin(2*(angles + pi/2));
    tuningL = abs(min(tuningL))+n*sin(2*angles);

    
    subplot(3,1,1)
    plot(angles,tuningR,'k')
    hold on
%     plot(angles,tuningL,'r')
    hold on
    legend right left
    legend boxoff
        set(gca,'XTick',[-pi,-3*pi/4,-pi/2,-pi/4,0,pi/4,pi/2,3*pi/4,pi]);
    set(gca,'XTickLabel',[-180,-135,-90,-45,0,45,90,135,180])
    
    difference = tuningR-tuningL;
    sum = tuningR + tuningL;
    subplot(3,1,2)
    plot(angles,difference)
    hold on
        set(gca,'XTick',[-pi,-3*pi/4,-pi/2,-pi/4,0,pi/4,pi/2,3*pi/4,pi]);
    set(gca,'XTickLabel',[-180,-135,-90,-45,0,45,90,135,180])
    
    subplot(3,1,3)
    plot(angles,sum)
    hold on
    set(gca,'XTick',[-pi,-3*pi/4,-pi/2,-pi/4,0,pi/4,pi/2,3*pi/4,pi]);
    set(gca,'XTickLabel',[-180,-135,-90,-45,0,45,90,135,180])
end


%% shifted
tuningR = 1+sin(2*angles);
tuningL = 1+sin(2*(angles + pi/2 + 0.1));
figure()
subplot(2,1,1)
plot(angles,tuningR,'k')
hold on
plot(angles,tuningL,'r')
legend right left
legend boxoff

subplot(2,1,2)
plot(angles,tuningR-tuningL)
set(gca,'XTick',[-pi,-3*pi/4,-pi/2,-pi/4,0,pi/4,pi/2,3*pi/4,pi]);
set(gca,'XTickLabel',[-180,-135,-90,-45,0,45,90,135,180])