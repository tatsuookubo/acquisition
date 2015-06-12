function settings = ldvSettings(stim)

%% Parameters
% Samp Rate
settings.sampRate.out   = stim.sampleRate;
settings.sampRate.in    = 10E3;
settings.ldvGain        = 5;                % LDV gain in mm/s/V


