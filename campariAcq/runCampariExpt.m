function runCampariExpt

count = 0;
% add trial num 
for i = 1:60 
    for j = 1:10 
        count = count + 1; 
        fprintf(['Trial = ',num2str(count)]);
        acquireSyncOut2
    end
    disp('Pausing')
    pause(10)
end