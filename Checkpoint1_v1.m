
%% Feature Extraction Code (taken from HW3)
% gets the number of windows given the length and displacement
% winLen and winDisp are in time(s), fs is sampling freq, xLen is length in
% samples
xLen = 300000;
fs = 1000;
winLen = 100 * 1e-3;
winDisp = 50 * 1e-3;
NumWins = @(xLen, fs, winLen, winDisp) length(0:winDisp*fs:xLen)-(winLen/winDisp);

% Line length fxn
LLFn = @(x) sum(abs(diff(x)));
% Area Fxn
areaFxn = @(x) sum(abs(x));
% Energy Fxn
energyFxn =@(x) sum(x.^2);
% Zero crossings around mean
zxFxn = @(x) sum((x(1:end-1)-mean(x)).*(x(2:end)-mean(x))<=0);
%% Feature Extraction (Average Time-Domain Voltage)
load('Sub1_training_ecog.mat');
tdvFxn = @(x) mean(x);

xLen = 300000;
fs = 1000;
winLen = .1;
winDisp = .05;

%subject 1
sub1tdv = cell(1,62);
for i = 1:62
   sub1tdv{i} = MovingWinFeats(Sub1_training_ecog{1,i,1}, fs, winLen, winDisp, tdvFxn);
end
%% Feature Extraction (Average Frequency-Domain Magnitude in 5 bands)
% Frequency bands are: 5-15Hz, 20-25Hz, 75-115Hz, 125-160Hz, 160-175Hz
% Total number of features in given time window is (num channels)*(5+1)
window = winLen*fs;

%subject 1
for i = 1:62
[s,f,t] = spectrogram(Sub1_training_ecog{1,1,1},window,winDisp*fs,[],fs);
    sub1f5_15{i} = mean(s(f(f>5)<15,:));
    sub1f20_25{i} = mean(s(f(f>20)<25,:));
    sub1f75_115{i} = mean(s(f(f>75)<115,:));
    sub1f125_160{i} = mean(s(f(f>125)<160,:));
    sub1f160_175{i} = mean(s(f(f>160)<175,:));
>>>>>>> 801a1b9d3eeb97266a494be61a3d1844696e4862
end

%% Decimation of dataglove
load('Sub1_Training_dg.mat');
% decimated glove data for subject one
% take out the last value to match our 5999
sub1DataGlove = cell(1,5);
for i = 1:5
    sub1DataGlove{i} = decimate(Sub1_Training_dg{i},50);
    sub1DataGlove{i}(end)= [];
end