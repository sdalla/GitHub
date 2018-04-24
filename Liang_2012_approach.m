% for this data set, the band-specific ECoG signals were generated using 
% equiripple finite impulse response (FIR) filters by setting their band-pass
% specifications as: sub-bands (1?60 Hz), gamma band (60?100 Hz), and fast 
% gamma band (100?200 Hz)
% testing on sub1 only, for now
%% load data
xLen = 300000;
fs = 1000;
winLen = 100 * 1e-3;
winDisp = 50 * 1e-3;
NumWins = @(xLen, fs, winLen, winDisp) length(0:winDisp*fs:xLen)-(winLen/winDisp);

load('Sub1_training_ecog.mat');
% original dataglove
load('sub1_Training_dg.mat');
% decimated dataglove
load('sub1DataGlove.mat');


%% break into freq bands using spectrogram, could do next section instead

window = winLen*fs;
freq_arr = 0:1:500; 
%subject 1
for i = 1:62
    [s,freq,t] = spectrogram(Sub1_Training_ecog{1,i},window,winDisp*fs,freq_arr,fs);
    sub1f1_60{i} = abs(s(1:60,:));
    sub1f60_100{i} = abs(s(60:100,:));
    sub1f100_200{i} = abs(s(100:200,:));
    
end

%% break into freq bands using FIR filters and filterDesigner
for i = 1:62   
    sub1_1_60filt{i} = filtfilt(Filter1,1,Sub1_Training_ecog{1,i});
    sub1_60_100filt{i} = filtfilt(Filter2,1,Sub1_Training_ecog{1,i});
    sub1_100_200filt{i} = filtfilt(Filter3,1,Sub1_Training_ecog{1,i});
end

%% plot the filtered and original data (sanity check)
subplot(4,1,1)
plot(Sub1_Training_ecog{1,1}(1:10000))
subplot(4,1,2)
plot(sub1_1_60filt{1}(1:10000))
subplot(4,1,3)
plot(sub1_60_100filt{1}(1:10000))
subplot(4,1,4)
plot(sub1_100_200filt{1}(1:10000))