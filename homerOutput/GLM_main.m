clc; clear; close all;


%% set parameters
signal_type = [1, 2]; % [1, 2, 3] = ['HbO', 'HbR', 'HbT']

region = "prefrontal cortex";

% [1...31] = [source:detector], e.g. channel 1 = 1-1, see Homer3 GUI message window
if region == "motor cortex"
%     channel.motion = [25, 26, 24, 28, 29, 30, 31, 16];
%     channel.mirror = [5, 6, 7, 9, 10, 11, 12, 13]; 
    channel.motion = [26, 31, 16];
    channel.mirror = [6, 12, 13]; 
end
if region == "prefrontal cortex"
    channel.motion = [20, 21, 22, 23, 19, 27];
    channel.mirror = [1, 2, 3, 4, 18, 8]; 
    channel.motion = [20, 21, 22, 23];
    channel.mirror = [1, 2, 3, 4]; 
end


condition = 2; % [1, 2] = ['rest', 'pintch']
groupName = "ARMT\";

%% generate the output
[ARMT.motion.HbO.beta, ARMT.mirror.HbO.beta] = GLM_beta_generate("ARMT\", channel, signal_type(1), condition);
[MT.motion.HbO.beta, MT.mirror.HbO.beta] = GLM_beta_generate("MT\", channel, signal_type(1), condition);

[ARMT.motion.HbR.beta, ARMT.mirror.HbR.beta] = GLM_beta_generate("ARMT\", channel, signal_type(2), condition);
[MT.motion.HbR.beta, MT.mirror.HbR.beta] = GLM_beta_generate("MT\", channel, signal_type(2), condition);

%% find mean and std
ARMT.motion.HbO.mean = mean(ARMT.motion.HbO.beta);
ARMT.motion.HbO.std = std(ARMT.motion.HbO.beta);
ARMT.mirror.HbO.mean = mean(ARMT.mirror.HbO.beta);
ARMT.mirror.HbO.std = std(ARMT.mirror.HbO.beta);

MT.motion.HbO.mean = mean(MT.motion.HbO.beta);
MT.motion.HbO.std = std(MT.motion.HbO.beta);
MT.mirror.HbO.mean = mean(MT.mirror.HbO.beta);
MT.mirror.HbO.std = std(MT.mirror.HbO.beta);

ARMT.motion.HbR.mean = mean(ARMT.motion.HbR.beta);
ARMT.motion.HbR.std = std(ARMT.motion.HbR.beta);
ARMT.mirror.HbR.mean = mean(ARMT.mirror.HbR.beta);
ARMT.mirror.HbR.std = std(ARMT.mirror.HbR.beta);

MT.motion.HbR.mean = mean(MT.motion.HbR.beta);
MT.motion.HbR.std = std(MT.motion.HbR.beta);
MT.mirror.HbR.mean = mean(MT.mirror.HbR.beta);
MT.mirror.HbR.std = std(MT.mirror.HbR.beta);

%% p value between bilateral HbO

[~,p.ARMT] = ttest(ARMT.motion.HbO.beta, ARMT.mirror.HbO.beta);
[~,p.MT] = ttest(MT.motion.HbO.beta, MT.mirror.HbO.beta);

%% p value between group HbO

[~,p.motion] = ttest(ARMT.motion.HbO.beta, MT.motion.HbO.beta);
[~,p.mirror] = ttest(ARMT.mirror.HbO.beta, MT.mirror.HbO.beta);

%% plot
figure(1)
x = [10, 15, 25, 30];
y = [ARMT.mirror.HbO.mean, ARMT.motion.HbO.mean, MT.mirror.HbO.mean, MT.motion.HbO.mean];
err = [ARMT.mirror.HbO.std, ARMT.motion.HbO.std, MT.mirror.HbO.std, MT.motion.HbO.std] / 10;
b = bar(x, y, "grouped");

hold on
str = erase(groupName,"\");
title({'HbO beta value in ' + region ; "ARMT:MT"});
set(gca,'xtick',[])
xticks([x(1), x(2), x(3), x(4)])
xticklabels({"mirror", "motion","mirror", "motion"});

ylabel('Beta value', 'FontSize', 12, 'FontWeight', 'bold') 
errorbar(x, y, err, "LineStyle", "none", "Color", 'black', 'LineWidth', 1.5);    
hold off

%% plot
figure(2)
x = [10, 15, 25, 30];
y = [ARMT.mirror.HbR.mean, ARMT.motion.HbR.mean, MT.mirror.HbR.mean, MT.motion.HbR.mean];
err = [ARMT.mirror.HbR.std, ARMT.motion.HbR.std, MT.mirror.HbR.std, MT.motion.HbR.std] / 10;
b = bar(x, y, "grouped");

hold on
str = erase(groupName,"\");
title({'HbR beta value in ' + region ; "ARMT:MT"});
set(gca,'xtick',[])
xticks([x(1), x(2), x(3), x(4)])
xticklabels({"mirror", "motion", "mirror", "motion"});

ylabel('Beta value', 'FontSize', 12, 'FontWeight', 'bold') 
errorbar(x, y, err, "LineStyle", "none", "Color", 'black', 'LineWidth', 1.5);    
hold off
