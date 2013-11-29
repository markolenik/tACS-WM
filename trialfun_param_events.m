function [trl, event] = trialfun_param_events(cfg);
%TRIALFUN_PARAM_EVENTS Custom function for event definition.
%
% SYNOPSIS
%   [trl, event] = trialfun_param_events(cfg);
%
% INPUT
%   (struct) cfg: The following fields need to be specified:
%   cfg.dataset, cfg.record, cfg.params
%
% OUTPUT
%   (matrix) trl: matrix with trial definition (in our case single trial)
%   (struct) event: definition of events
%

% read the header information without events from the data
hdr   = ft_read_header(cfg.dataset);

% record: prestim, dur/poststim
record = cfg.record;

% sampling rate of EEG recording
FS = hdr.Fs;

params = cfg.params;

% event structure
% sample: sample number where event starts
% offset: in samples
% duration: in samples
event = struct('type',{},'sample',{},'value',{},'offset',{},'duration',{});

if(strcmp(record, 'pre_stim'))
    analyze_params(1, 50);
elseif(strcmp(record, 'dur_post_stim'))
    analyze_params(51, 200); % so ist gleich wie untere beide oder?
%     analyze_params(51, 150);
%     analyze_params(151, 200);
end

% Continuous data, 1 trial per recording (pre, dur and post)
if(strcmp(cfg.record, 'dur_post_stim'))
    end_dur_stim = params.TimeStamps.TaskDurStim.End;
    trl = [1, adjust_time(end_dur_stim), 0; ...
           adjust_time(end_dur_stim+1), hdr.nSamples, 0];
else
    trl = [1, hdr.nSamples, 0];
end

% trl = [1 hdr.nSamples 0];

%% helper functions for event creation

% adjust time by end-markers
    function eeg_timestamp = adjust_time(param_timestamp)
        % INPUT
        %   (number) param_timestamp: time point to shift
        %
        % OUPUT
        %   (number) eeg_timestamp: shifted time point
        %
        eeg_end = hdr.nSamples;
        if(strcmp(cfg.record, 'dur_post_stim'))
            params_end = params.TimeStamps.Experiment.End * FS; % milliseconds
        else
            params_end = params.TimeStamps.TaskPreStim.End * FS; % milliseconds
        end
        
        move_by = eeg_end - params_end;
        
        % no need for anything more exact than a ms
        eeg_timestamp = floor( (param_timestamp * FS) + move_by );
    end

% create events for chosen tasks
% task: starts at fixation.start, ends at probe.end
    function analyze_params(a, b)
        % INPUT
        %   (number) a,b: lower and upper trial
        %
        for i = a:b
            event(end+1) = task_event(i);
            event(end+1) = fixation_event(i);
            for j = 1:3
                event(end+1) = sample_event(i, j);
                event(end+1) = mask_event(i, j);
            end
            event(end+1) = cue_event(i);
            event(end+1) = probe_event(i);
        end
    end

% create event for task x
    function tsk_event = task_event(x)
        % INPUT
        %   (number) x: number of event
        %
        tsk_event = [];
        tsk_event.type = 'task';
        tsk_event.sample = adjust_time(params.Task.Trial(1,x).Timing.Fixation.Start);
        tsk_event.value = [];
        tsk_event.offset = [];
        tsk_event.duration = floor( (params.Task.Trial(1,x).Timing.Probe.End - ...
            params.Task.Trial(1,x).Timing.Fixation.Start) * FS );
    end

% create event for fixation
    function fxn_event = fixation_event(x)
        % INPUT
        %   (number) x: number of event
        %
        fxn_event = [];
        fxn_event.type = 'fixation';
        fxn_event.sample = adjust_time(params.Task.Trial(1, x).Timing.Fixation.Start);
        fxn_event.value = [];
        fxn_event.offset = [];
        fxn_event.duration = floor( (params.Task.Trial(1,x).Timing.Fixation.End - ...
            params.Task.Trial(1,x).Timing.Fixation.Start) * FS );
    end

% create event for sample
    function smpl_event = sample_event(x, sample_num)
        % INPUT
        %   (number) x: number of event
        %
        smpl_event = [];
        % number of presented sample (in terms of order number)
        smpl_event.type = ['sample', int2str(sample_num)];
        smpl_event.sample = adjust_time(params.Task.Trial(1,x).Timing.Sample(sample_num).Start);
        % type of sample presented (1,2,3)
        smpl_event.value = params.Task.Trial(1, x).Samples(sample_num);
        smpl_event.offset = [];
        smpl_event.duration = floor( (params.Task.Trial(1,x).Timing.Sample(sample_num).End - ...
            params.Task.Trial(1,x).Timing.Sample(sample_num).Start) * FS );
    end

% create event for mask
    function msk_event = mask_event(x, mask_num)
        % INPUT
        %   (number) x: number of event
        %
        msk_event = [];
        % number of presented mask (in terms of order number)
        msk_event.type = ['mask', int2str(mask_num)];
        msk_event.sample = adjust_time(params.Task.Trial(1,x).Timing.Mask(mask_num).Start);
        msk_event.value = [];
        msk_event.offset = [];
        msk_event.duration = floor( (params.Task.Trial(1,x).Timing.Mask(mask_num).End - ...
            params.Task.Trial(1,x).Timing.Mask(mask_num).Start) * FS );
    end

% create event for cue
    function cu_event = cue_event(x)
        % INPUT
        %   (number) x: number of event
        %
        cu_event = [];
        cu_event.type = 'cue';
        cu_event.sample = adjust_time(params.Task.Trial(1, x).Timing.Cue.Start);
        cu_event.value = params.Task.Trial(1, x).Cue;
        cu_event.offset = [];
        cu_event.duration = floor( (params.Task.Trial(1,x).Timing.Cue.End - ...
            params.Task.Trial(1,x).Timing.Cue.Start) * FS );
    end

% create event for probe
    function prb_event = probe_event(x)
        % INPUT
        %   (number) x: number of event
        %
        prb_event = [];
        prb_event.type = 'probe';
        prb_event.sample = adjust_time(params.Task.Trial(1, x).Timing.Probe.Start);
        prb_event.value = (params.Task.Trial(1, x).Samples(params.Task.Trial(1, x).Cue) == params.Task.Trial(1, x).Probe) == ...
            params.Task.Trial(1, x).Response; % answered correctly?
        prb_event.offset = [];
        prb_event.duration = floor( params.Task.Trial(1, x).RT * FS );
    end

end