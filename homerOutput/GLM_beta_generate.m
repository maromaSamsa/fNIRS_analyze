function [motion, mirror] = GLM_beta_generate(groupName, channel, signal_type, condition)
    
    %% load all files path
    data = dir(groupName);
    data(1:3) = [];
    data(end) = [];
    
    subjPath = [];
    for i=1:length(data)
        subjPath = [subjPath; fullfile(groupName, [data(i).name])];
    end
    
    %% average beta value of selected channel in subject

    motion = zeros(length(subjPath), length(channel.motion));
    mirror = zeros(length(subjPath), length(channel.motion));
    
    for subj = 1:length(subjPath)
        load(subjPath(subj));
        motion(subj, :) = output.misc.beta{1}(1, signal_type, channel.motion, condition);
        mirror(subj, :) = output.misc.beta{1}(1, signal_type, channel.mirror, condition);
    end

    %% reshape and find mean and std
    motion = reshape(motion, 1, []);
    mirror = reshape(mirror, 1, []);