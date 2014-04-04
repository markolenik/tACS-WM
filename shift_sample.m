function sample = shift_sample(param_timestamp, cfg)
%SHIFT_SAMPLE Map timepoint from DLDT to a sample in EEG data.
%
%TODO: SYNOPSIS ...
%
% INPUT
%   (number) param_timestamp: time point from task to shift
%
% OUPUT
%   (number) shifted_sample: shifted sample
%
%   
%   We had a time asynchrony between behavioural recordings (DLDT trials)
%   and EEG data. EEG recordings were started first. Then, with an
%   arbitrary delay we started the DLDT. Both DLDT and EEG recordings were
%   stopped simultaneously. WE SHIFT THE TIMES BY THE DIFFERENCE IN BOTH
%   recording lengths.

params = cfg.params;
hdr = ft_read_header(cfg.dataset);
FS = hdr.Fs;
EEG_end = hdr.nSamples;

% map time to samples
if(strcmp(cfg.record, 'dur_post_stim'))
    %Timestamp of synchronisation
    %NOTE: The only time when we should use TimeStamps.
    params_end = params.TimeStamps.Experiment.End * FS;
elseif(strcmp(cfg.record, 'pre_stim'))
    params_end = params.TimeStamps.TaskPreStim.End * FS;
else
    error('Wrong type of data, only "pre_stim" and "dur_post_stim" acceptale');
end

% find the difference in samples between both durations
move_by_samples = EEG_end - params_end;

% shift EEG by difference in samples into future
% no need for anything more exact than a ms
sample = floor( (param_timestamp * FS) + move_by_samples );

end