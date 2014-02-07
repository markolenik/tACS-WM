function clean = remove_trials( data, dat_info )
%REMOVE_TRIALS removes trials from data that can't be used for the analysis
%   - trials that were answered wrong
%   - trials with a reaction time > 2*stddev. (stddev calculated over the session)
%   - trials with peak-to-peak amplitudes of either <2uV or >100uV
%   // - trials with eye artifacts? or are those removed in ICA from continuous dataset?

%TODO: test function

trials = cat(2, data.sampleinfo, zeros(length(data.sampleinfo),1)-300, data.trialinfo);

to_remove = [];
if (strcmp(dat_info.record,'dur_post_stim'))
    to_remove = 1:100;
end

% loop through trials and check if any of the exclusion criteria is met. if so, add to array

rt_threshold = mean(trials(:,4)) + std(trials(:,4))*2;
% rt_threshold = floor((mean([params.Task.Trial(1, :).RT]) + std([params.Task.Trial(1, :).RT]) * 2) * data.hdr.Fs);
for i = 1:length(trials)
    to_remove = remove_wrong(trials,i, to_remove);
    to_remove = remove_long_rt(trials,i,rt_threshold, to_remove);
end
trl = trials(to_remove,:);
cfg = [];
cfg.artfctdef.reject = 'complete';
cfg.artfctdef.remove_trials.artifact = trl;
clean = ft_rejectartifact(cfg,data);

% remove noisy trials
% cfg = [];
% cfg.continuous = 'no';
% cfg.trl = data.cfg.trl;
% cfg.artfctdef.threshold.channel = {'F3', 'P3'};
% cfg.artfctdef.threshold.range = 2; % uV
% [cfg, artifact] = ft_artifact_threshold(cfg, data);


%% helper functions for evaluation of trials

% remove trial from return true if answer was wrong
    function to_remove = remove_wrong(trials, trialnum, to_remove)
        % INPUT
        %   (number) trialnum: trial to check
        %
        % OUPUT
        %   (vector) to_remove: contains trlNum to remove
        %
        if trials(trialnum,5) == 0
            to_remove = [to_remove, trialnum];
            %             write_to_log(params.session_folder, ['removed trial ', num2str(i), ': wrong answer.']);
        end
    end

% remove trial from return true if the answer for this trial took longer than
% a certain threshold-value (//two standard deviations from the sessions mean)
    function to_remove = remove_long_rt(trials,trialnum, threshold, to_remove)
        % INPUT
        %   (number) trialnum: trial to check
        %   (number) threshold: max allowed reaction time
        %
        % OUPUT
        %   (vector) to_remove: contains trlNum to remove
        %
        if trials(trialnum,4) > threshold
            to_remove = [to_remove, trialnum];
            %             write_to_log(params.session_folder, ['removed trial ', num2str(i), ': exceptionally slow answer.']);
        end
    end



end

