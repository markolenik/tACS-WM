function sample = adjustTime(prmsTimestamp,cfg,dat_info)
%ADJUSTTIME Map timepoint from DLDT to a sample in EEG data.
%
%   SYNOPSIS
%       movedSample = adjustTime(prmsTimestamp,prms,cfg)
%
%   INPUT
%       (number) prmsTimestamp: time point from task to shift
%       (struct) prms:          params file
%       (struct) eegData:       file with EEG data
%
%   OUPUT
%       (number) sample: shifted sample
%
%   We had a time asynchrony between behavioural recordings (DLDT trials)
%   and EEG data. EEG recordings were started first. Then, with an
%   arbitrary delay we started the DLDT. Both DLDT and EEG recordings were
%   stopped simultaneously. WE SHIFT THE TIMES BY THE DIFFERENCE IN BOTH
%   recording lengths.
%

% read the header information without events from the data
hdr   = ft_read_header(cfg.dataset);
% record: prestim, dur/poststim
record = dat_info.record;
% sampling rate of EEG recording in ms
FS = hdr.Fs;
prms = dat_info.params;
eegLength = hdr.nSamples;

% map time to samples
if(strcmp(record, 'dur_post_stim'))
%     prms_end = prms.TimeStamps.Experiment.End - ...
%         prms.Task.Trial(51).Timing.TrialStart;
    prms_end = prms.TimeStamps.Experiment.End * FS;
elseif(strcmp(record, 'pre_stim'))
    prms_end = prms.TimeStamps.TaskPreStim.End * FS;
else
    error('Wrong type of data, only "pre_stim" and "dur_post_stim" acceptale');
end

% find the difference in samples between both durations
move_by_samples = eegLength - prms_end;

% shift EEG by difference in samples into future
% no need for anything more exact than a ms
sample = floor( (prmsTimestamp * FS) + move_by_samples );



end


