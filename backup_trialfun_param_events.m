function [trl, event] = trialfun_param_events(cfg);

% This function requires the following fields to be specified
% cfg.dataset
% cfg.record
% cfg.params


% read the header information without events from the data
hdr   = ft_read_header(cfg.dataset);

% check if formerly created event-file exists in eeg folder
events_file = strrep(cfg.dataset,'.dat','_event_struct.mat');

%%%% commented out for debugging reasons
%if(exist(events_file))
    % load that file
    % load(events_file, 'event');
%else
    params = [];
    load(cfg.session.params_file, 'params');
    event = struct('type',{},'sample',{},'value',{},'offset',{},'duration',{});
    
    % pre stim
    if(strcmp(cfg.record, 'pre_stim'))
        record = 'pre_stim';
        analyze_params(1, 50);
    elseif(strcmp(cfg.record, 'dur_post_stim'))
        record = 'dur_stim';
        analyze_params(51, 150);
        record = 'post_stim';
        analyze_params(151, 200);
    end
    
    clear i j;
    % write event-info into eeg folder
    ft_write_event(events_file, event);
% end

% we replicate the polania study's trial window beginning 300ms prior to
% the probe onset, finishing 500ms after probe onset
% additional to the expected structure [begin end offset] we add
% some more information about the trial (comments in embedded function)

% trl = [];
% tasks = [event(find(strcmp('task', {event.type})))];
% for tsk = 1:length(tasks)
%     begin_trial = tasks(tsk).sample;
%     end_trial = begin_trial + tasks(tsk).duration;
%     tsk_events = event([event.sample]>=begin_trial);
%     tsk_events = tsk_events([tsk_events.sample]<=end_trial);
%     
%     tsk_trial = create_trial(tsk, tsk_events);
%     if(tsk_trial(2)<=hdr.nSamples)
%         trl(end+1,:) = tsk_trial;
%     end
% end
trl = [1 hdr.nSamples 0];

%% helper functions for event creation

% adjust time by end-markers
    function eeg_timestamp = adjust_time(param_timestamp)
        eeg_end = hdr.nSamples;
        if(~strcmp(cfg.record, 'pre_stim'))
            params_end = params.TimeStamps.Experiment.End * 1000; % milliseconds
        else
            params_end = params.TimeStamps.TaskPreStim.End * 1000; % milliseconds
        end
        
        move_by = eeg_end - params_end;
        
        % no need for anything more exact than a ms
        eeg_timestamp = floor( (param_timestamp * 1000) + move_by );
    end

% create events for chosen tasks
% task: starts at fixation.start, ends at probe.end
    function analyze_params(a, b)
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
        tsk_event = [];
        tsk_event.type = 'task';
        tsk_event.sample = adjust_time(params.Task.Trial(1,x).Timing.Fixation.Start);
        tsk_event.value = [cfg.session.condition, '_', record];
        tsk_event.offset = [];
        tsk_event.duration = floor( (params.Task.Trial(1,x).Timing.Probe.End - ...
            params.Task.Trial(1,x).Timing.Fixation.Start) * 1000 ); % milliseconds
    end

% create event for fixation
    function fxn_event = fixation_event(x)
        fxn_event = [];
        fxn_event.type = 'fixation';
        fxn_event.sample = adjust_time(params.Task.Trial(1, x).Timing.Fixation.Start);
        fxn_event.value = [];
        fxn_event.offset = [];
        fxn_event.duration = floor( (params.Task.Trial(1,x).Timing.Fixation.End - ...
            params.Task.Trial(1,x).Timing.Fixation.Start) * 1000 ); % milliseconds
    end

% create event for sample
    function smpl_event = sample_event(x, sample_num)
        smpl_event = [];
        smpl_event.type = ['sample', int2str(sample_num)];
        smpl_event.sample = adjust_time(params.Task.Trial(1,x).Timing.Sample(sample_num).Start);
        smpl_event.value = params.Task.Trial(1, x).Samples(sample_num);
        smpl_event.offset = [];
        smpl_event.duration = floor( (params.Task.Trial(1,x).Timing.Sample(sample_num).End - ...
            params.Task.Trial(1,x).Timing.Sample(sample_num).Start) * 1000 ); % milliseconds
    end

% create event for mask
    function msk_event = mask_event(x, mask_num)
        msk_event = [];
        msk_event.type = ['mask', int2str(mask_num)];
        msk_event.sample = adjust_time(params.Task.Trial(1,x).Timing.Mask(mask_num).Start);
        msk_event.value = [];
        msk_event.offset = [];
        msk_event.duration = floor( (params.Task.Trial(1,x).Timing.Mask(mask_num).End - ...
            params.Task.Trial(1,x).Timing.Mask(mask_num).Start) * 1000 ); % milliseconds
    end

% create event for cue
    function cu_event = cue_event(x)
        cu_event = [];
        cu_event.type = 'cue';
        cu_event.sample = adjust_time(params.Task.Trial(1, x).Timing.Cue.Start); % milliseconds!
        cu_event.value = params.Task.Trial(1, x).Cue;
        cu_event.offset = [];
        cu_event.duration = floor( (params.Task.Trial(1,x).Timing.Cue.End - ...
            params.Task.Trial(1,x).Timing.Cue.Start) * 1000 ); % milliseconds
    end

% create event for probe
    function prb_event = probe_event(x)
        prb_event = [];
        prb_event.type = 'probe';
        prb_event.sample = adjust_time(params.Task.Trial(1, x).Timing.Probe.Start); % milliseconds!
        prb_event.value = (params.Task.Trial(1, x).Samples(params.Task.Trial(1, x).Cue) == params.Task.Trial(1, x).Probe) == ...
            params.Task.Trial(1, x).Response; % answered correctly?
        prb_event.offset = [];
        prb_event.duration = floor( params.Task.Trial(1, x).RT * 1000 ); % milliseconds
    end

%% helper functions trial creation

% create trials
    function trl = create_trial(tsk, tsk_events)
        task  = tasks(tsk);
        probe = [tsk_events(find(strcmp('probe',{tsk_events.type})))];
                
        trl = [];
        % begin
        trl = [trl, probe.sample - 300];
        % end
        trl = [trl, probe.sample + 500];
        % offset
        trl = [trl, -300];
        % session
        trl = [trl, params.Subject.NumMeasurement];
        % condition - encoded by the following scheme:
        %   'synch':   1
        %   'desynch': 2
        %   'sham':    3
        switch cfg.session.condition
            case 'synch'
                trl = [trl, 1];   
            case 'desynch'
                trl = [trl, 2];
            otherwise
                trl = [trl, 3];
        end
        % record - encoded by the following scheme:
        %   'pre_stim':     1
        %   'dur_stim':     2
        %   'post_stim':    3
        switch record
            case 'pre_stim'
                trl = [trl, 1];   
            case 'dur_stim'
                trl = [trl, 2];
            otherwise
                trl = [trl, 3];
        end
        % trialnum
        if(strcmp(cfg.record, 'pre_stim'))
            trl = [trl, tsk];
        else
            trl = [trl, tsk + 50];
        end
        % RT
        trl = [trl, probe.duration];
        % value
        trl = [trl, probe.value];
    end

end