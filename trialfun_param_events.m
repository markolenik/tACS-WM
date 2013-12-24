function [trl, event] = trialfun_param_events(cfg);
%TRIALFUN_PARAM_EVENTS Custom function for event definition.
%
% SYNOPSIS
%   [trl, event] = trialfun_param_events(cfg);
%
% INPUT
%   (struct) cfg: The following fields need to be specified:
%   cfg.filepath, cfg.record, cfg.params
%
% OUTPUT
%   (matrix) trl: matrix with trial definition (in our case single trial)
%   (struct) event: definition of events
%

% read the header information without events from the data
hdr   = ft_read_header(cfg.dataset);

% record: prestim, dur/poststim
record = cfg.record;

% sampling rate of EEG recording in ms
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
    analyze_params(51, 200);
else
    error('Wrong type of data, only "pre_stim" and "dur_post_stim" acceptale');
end

trl = [1, hdr.nSamples, 0];

% % Continuous data, 1 trial per recording (pre, dur and post)
% if(strcmp(cfg.record, 'dur_post_stim'))
%     start_dur_stim = params.TimeStamps.TaskDurStim.Start;
%     end_post_stim = params.TimeStamps.TaskPostStim.End;
%     trl = [adjustTime(start_dur_stim), adjustTime(end_post_stim),0];
% elseif(strcmp(cfg.record, 'pre_stim'))
%     start_pre_stim = params.TimeStamps.TaskPreStim.Start;
%     end_pre_stim = params.TimeStamps.TaskPreStim.End;
%     trl = [adjustTime(start_pre_stim), adjustTime(end_pre_stim), 0];
% else
%     error('Wrong type of data, only "pre_stim" and "dur_post_stim" acceptale');
% end

%% helper functions for event creation

% create events for chosen tasks
% task: starts at fixation.start, ends at probe.end, represents one trial
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
        tsk_event.sample = adjustTime(params.Task.Trial(1,x).Timing.Fixation.Start,cfg);
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
        fxn_event.sample = adjustTime(params.Task.Trial(1, x).Timing.Fixation.Start,cfg);
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
        smpl_event.sample = adjustTime(params.Task.Trial(1,x).Timing.Sample(sample_num).Start,cfg);
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
        msk_event.sample = adjustTime(params.Task.Trial(1,x).Timing.Mask(mask_num).Start,cfg);
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
        cu_event.sample = adjustTime(params.Task.Trial(1, x).Timing.Cue.Start,cfg);
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
        prb_event.sample = adjustTime(params.Task.Trial(1, x).Timing.Probe.Start,cfg);
        prb_event.value = (params.Task.Trial(1, x).Samples(params.Task.Trial(1, x).Cue) == params.Task.Trial(1, x).Probe) == ...
            params.Task.Trial(1, x).Response; % answered correctly?
        prb_event.offset = [];
        prb_event.duration = floor( params.Task.Trial(1, x).RT * FS );
    end



end