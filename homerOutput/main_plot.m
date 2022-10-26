clc; close all; clear;

%% load all files path
dirName = 'MT\';
data = dir(dirName);
data(1:3) = [];

%% generate integral result
motion = [];
mirror = [];
for i = 1:length(data)
    pathName = fullfile(dirName, data(i).name);
    [mo, mi] = generate(pathName, 2, 3);
    motion = [motion; mo];
    mirror = [mirror; mi];
end

clear mo  mi;

%% quick look of result
I = sum( (motion > 0)&(mirror > 0) );
II = sum( (motion < 0)&(mirror > 0) );
III = sum( (motion < 0)&(mirror < 0) );
IV = sum( (motion > 0)&(mirror < 0) );

%% plot
b = polyfit(motion, mirror, 1);
R = corrcoef(motion, mirror);
xfit = linspace(min(motion), max(motion));
yfit = b(1)*xfit + b(2);

hold on
scatter(motion, mirror, "filled");

R_str = "r = " + num2str(R(2));
title(dirName, R_str);
xlabel('motion conc') 
ylabel('mirror conc') 

plot(xfit, yfit, 'Color', 'k', 'LineWidth', 1);
plot(xfit, yfit, 'Color', 'k', 'LineWidth', 1);
legend('Symmetrical channels', 'regression');

f_str = newline + "slope = " + num2str(round(b(1),2)) + newline + "offset = " + num2str(b(2));
text(2*xfit(end)/3, 2*yfit(end)/3, f_str);
