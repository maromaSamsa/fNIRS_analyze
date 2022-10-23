clear; close all; clc;


%% load subject data
load Sub11_G1_ARMT.mat
dcAvg = output.dcAvg.GetDataTimeSeries('reshape');
tHRF = output.dcAvg.GetTime();

%% set parameter
signal_type = 1; % [1, 2, 3] = ['HbO', 'HbR', 'HbT']
channel = 11; % [1...31] = [source:detector], e.g. channel 1 = 1-1, see Homer3 GUI message window
condition = 2; % [1, 2] = ['rest', 'pintch']

%% plot the signal
HRF = dcAvg(:,signal_type, channel, condition);
plot(tHRF, HRF);

%% integral
sampling_rate = 7.81;
timeRange = int16([5, 20] .* sampling_rate);
sum = 0;
for i = timeRange(1):timeRange(2)
    sum = sum + HRF(i);
end
ans = sum/sampling_rate;






