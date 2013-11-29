function clean = remove_trials( data, params )
%REMOVE_TRIALS removes trials from data that can't be used for the analysis
%   - trials that were answered wrong
%   - trials with a reaction time > 2*stddev. (stddev calculated over the session)
%   - trials with peak-to-peak amplitudes of either <2uV or >100uV
%   // - trials with eye artifacts? or are those removed in ICA from continuous dataset?
    
    cfg = [];
    cfg.trials = cat(2, data.sampleinfo, zeros(length(data.sampleinfo),1)-300, data.trialinfo);
    
    % loop through trials and check if any of the exclusion criteria is met. if so, add to array
    to_remove = [];
    rt_threshold = floor((mean([params.Task.Trial(1, :).RT]) + std([params.Task.Trial(1, :).RT]) * 2) * data.hdr.Fs);
    for i = 1:length(cfg.trials)
        if remove_wrong(i) % nested function
            % removed, no need to check for any further exclusion criteria
        elseif remove_long_rt(i, rt_threshold) % nested function
            % removed, no need to check for any further exclusion criteria
        end
    end
    % remove all trials that have been marked
    cfg.trials(to_remove) = [];
    % update data with only the usable trials
    clean = ft_preprocessing(cfg, data);
       
    %% helper functions for evaluation of trials 
    
    % remove trial from return true if answer was wrong
    function remove = remove_wrong(trialnum)
    % INPUT
    %   (number) trialnum: trial to check
    %
    % OUPUT
    %   (boolean) remove: do we have to remove this trial?
    %
        if cfg.trials(i,5) == 0
            to_remove = [to_remove, i];
            remove = true;
            write_to_log(params.session_folder, ['removed trial ', num2str(i), ': wrong answer.']);
        end
    end

    % remove trial from return true if the answer for this trial took longer than
    % a certain threshold-value (//two standard deviations from the sessions mean)
    function remove = remove_long_rt(trialnum, threshold)
    % INPUT
    %   (number) trialnum: trial to check
    %   (number) threshold: max allowed reaction time
    %
    % OUPUT
    %   (boolean) remove: do we have to remove this trial?
    %
        if cfg.trials(i,4) > threshold
            to_remove = [to_remove, i];
            remove = true;
            write_to_log(params.session_folder, ['removed trial ', num2str(i), ': exceptionally slow answer.']);
        end
    end
end

