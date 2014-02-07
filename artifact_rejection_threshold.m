function clean = artifact_rejection_threshold( data, params)
%ARTIFACT_REJECTION_THRESHOLD Summary of this function goes here
%TODO: add summary here
%TODO: test function
%   Detailed explanation goes here

    cfg = [];
    cfg.continuous = 'no';
    cfg.trl = data.cfg.trl;
    cfg.artfctdef.threshold.channel = {'F3', 'P3'};
    cfg.artfctdef.threshold.range = 2; % uV
    [cfg, artifact] = ft_artifact_threshold(cfg, data);
    
    cfg = [];
    cfg.trials = cat(2, data.sampleinfo, zeros(length(data.sampleinfo),1)-300, data.trialinfo);
    
    % loop through trials and check if any does NOT exceed a range of 2uV. remove those trials.
    to_remove = [];
    for i = 1:length(cfg.trl)
        if(isempty(find(trl_data.sampleinfo(i,1) == artifact(:,1))))
            to_remove = [to_remove, i];
            write_to_log(params.session_folder, ['removed trial ', num2str(i), ': too high amplitude.']);
        end
    end
    % remove all trials that have been marked
    cfg.trials(to_remove) = [];
    % update data with only the usable trials
    low_range_clean = ft_preprocessing(cfg, data);
    
    % % save here?
    
    cfg = [];
    cfg.continuous = 'no';
    cfg.trl = data.cfg.trl;
    cfg.artfctdef.threshold.channel = {'F3', 'P3'};
    cfg.artfctdef.threshold.range = 2; % uV
    [cfg, artifact] = ft_artifact_threshold(cfg, data);
    cfg.artfctdef.feedback = 'yes';
    data = ft_rejectartifact(cfg, data);

    if cfg.trials(i,4) > threshold
        to_remove = [to_remove, i];
        remove = true;
        
    elseif
        write_to_log(params.session_folder, ['removed trial ', num2str(i), ': too low amplitude.']);
    end
end

