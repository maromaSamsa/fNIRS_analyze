clc; close all; clear;

%% load data
load ARMT_RES.mat
load MT_RES.mat

a = ARMT_res;
b = MT_res;
ARMT_res = rmoutliers(ARMT_res);
MT_res = rmoutliers(MT_res);

%% plot ARMT
R = corrcoef(a, b);

b = polyfit(ARMT_res(:,1), ARMT_res(:,2), 1);
xfit = linspace(min(ARMT_res(:,1)), max(ARMT_res(:,1)));
yfit = b(1)*xfit + b(2);

hold on
scatter(ARMT_res(:,1), ARMT_res(:,2), "filled");

R_str = "Corr = " + num2str(R(2));
title('Symmetrical channels', R_str);
xlabel('motion conc'); 
ylabel('mirror conc');


% plot(xfit, yfit, 'Color', 'k', 'LineWidth', 1);
% f_str = "slope = " + num2str(round(b(1),2));
% text(2*xfit(end)/3, 2*yfit(end)/3, f_str);

%% plot MT
b = polyfit(MT_res(:,1), MT_res(:,2), 1);
xfit = linspace(min(MT_res(:,1)), max(MT_res(:,1)));
yfit = b(1)*xfit + b(2);

scatter(MT_res(:,1), MT_res(:,2), 'red', "filled");

% plot(xfit, yfit, 'Color', 'k', 'LineWidth', 1);
% f_str = "slope = " + num2str(round(b(1),2));
% text(2*xfit(end)/3, 2*yfit(end)/3, f_str);

%% 
legend('ARMT', 'MT');
hold off;