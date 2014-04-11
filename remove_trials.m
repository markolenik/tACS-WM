function clean = remove_trials(dat, record, condition)
%REMOVE_TRIALS removes trials from data that can't be used for the
%analysis.
%   - trials that were answered wrong
%   - trials with a reaction time > 2*stddev. (stddev calculated over the session)
%   - trials with peak-to-peak amplitudes of either <2uV or >200uV
%
% SYNOPSIS
%   clean = remove_trials( data, record )
%
% INPUT
%   (struct) data:   preprocessed data (with trigger-trials)
%   (string) record: type of recording (rest1,prestim, etc.)
%   (string) datset: path to dataset
%
% OUTPUT
%   (struct) clean: data without artefacted trials
%

befcue = (dat.sampleinfo(1,2)-dat.sampleinfo(1,1))/2; % duration before cue in ms in trial
trials = cat(2, dat.sampleinfo, zeros(length(dat.sampleinfo),1)-befcue, dat.trialinfo); % create trl matrix
RT = dat.trialinfo(:,1); % vector with RTs for each trial
correct = dat.trialinfo(:,2); % vector with type of answer (correct/incorrect)

to_remove = [];
% remove all trials during tACS
if (strcmp(record,'dur_post_stim'))
    if (strcmp(condition, 'sham'))
        to_remove = 1:100;
    else
        stim_trials = double(cell2mat(cellfun(@is_stimtrial,dat.trial,'UniformOutput',0)));
        % Start from trial 1 since we are only interested in trials AFTER the
        % stimulation and it may happen that the first few trials do not
        % contain a stimulus artefact.
        to_remove = 1:find(stim_trials(end),1,'last');
    end
end

% remove outliers and trials with wrong answer
badtrl = id_badtrl(RT,correct);

to_remove = unique(sort([to_remove badtrl]));

trl = trials(to_remove,:);
cfg = [];
cfg.artfctdef.reject = 'complete';
cfg.artfctdef.remove_trials.artifact = trl;
clean = ft_rejectartifact(cfg,dat);

%% Remove noisy trials
cfg = [];
cfg.continuous = 'no';
cfg.trl = dat.cfg.trl;
cfg.artfctdef.threshold.channel = {'F3', 'P3'};
cfg.artfctdef.threshold.bpfilter  = 'no';
cfg.artfctdef.threshold.range = 200; % peak2peak in uV
[cfg, ~] = ft_artifact_threshold(cfg, clean);
clean = ft_rejectartifact(cfg,clean);

end

