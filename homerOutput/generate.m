function [res_motion,res_mirror] = generate(packagePath, condition, rank)

    %% load subject data
    load(packagePath);
    dcAvg = output.dcAvg.GetDataTimeSeries('reshape');
    
    %% set parameter
    signal_type = 1; % [1, 2, 3] = ['HbO', 'HbR', 'HbT']
    % [1...31] = [source:detector], e.g. channel 1 = 1-1, see Homer3 GUI message window
    channel.motion = [25, 26, 24, 28, 29, 30, 31, 16];
    channel.mirror = [5, 6, 7, 9, 10, 11, 12, 13]; 
    % condition = 2; % [1, 2] = ['rest', 'pintch']
    
    %% Calculate the intergral value of all chennal
    sampling_rate = 7.81;
    timeRange = int16([5, 15] .* sampling_rate);
    res.motion = zeros(length(channel.motion), 1);
    res.mirror = zeros(length(channel.motion), 1);
    
    for i = 1:length(res.motion)
        HRF_motion = dcAvg(:,signal_type, channel.motion(i), condition);
        HRF_mirror = dcAvg(:,signal_type, channel.mirror(i), condition);
        for dt = timeRange(1):timeRange(2)
            res.motion(i) = res.motion(i) + HRF_motion(dt);
            res.mirror(i) = res.mirror(i) + HRF_mirror(dt);
        end
        res.motion(i) = res.motion(i)/sampling_rate;
        res.mirror(i) = res.mirror(i)/sampling_rate;
    end

%% choose big value
    sampleList = [res.motion, res.motion, res.mirror];
    sampleList = sortrows(sampleList, 1, "descend");
    res.motion = sampleList(1:rank,2);
    res.mirror = sampleList(1:rank,3);
    clear sampleList;
%% return 
    res_motion = res.motion;
    res_mirror = res.mirror;
end

