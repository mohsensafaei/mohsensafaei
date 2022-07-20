function Bleep
%% Load and PreCalculations
[California_Algorithm,~] = audioread('California.wav');
[Arnold,Fs_Arnold] = audioread('Arnold.wav');

%% Correlation
Corr = xcorr(Arnold,California_Algorithm);
Corr=Corr(651600:length(Corr)); % Remove zero values
normalized_Corr = Corr./(max(Corr(:))-min(Corr(:)));
% normalized_Corr = Corr(:)./max(Corr(:));
[~,max_index] = max(normalized_Corr);
plot(1:length(normalized_Corr),normalized_Corr);
title('Normalized Correlation');

%% Censored
osc = audioOscillator('SignalType','sine','Frequency',1000,...   % Use AudioToolbox. This function generates beep sound.
    'SamplesPerFrame',length(California_Algorithm));
Arnold(max_index:max_index + length(California_Algorithm)-1)=osc();
sound(Arnold,Fs_Arnold);
audiowrite('censored.wav',Arnold,Fs_Arnold);

end