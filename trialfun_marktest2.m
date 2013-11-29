function [trl, event] = trialfun_param_events(cfg);


% read the header information without events from the data
hdr   = ft_read_header(cfg.dataset);

% check if formerly created event-file exists in eeg folder
events_file = strrep(cfg.dataset,'.dat','_event_struct.mat');

% Initialize
params = cfg.params;
record = cfg.record;
fsample = hdr.Fs; % sampling rate in Hz
nsamples = hdr.nSamples; % number of samples (data length)


% create events
event = struct('type',{},'sample',{},'value',{},'offset',{},'duration',{});

if(strcmp(record, 'pre_stim'))
    analyze_params(1, 50);
elseif(strcmp(record, 'dur_post_stim'))
    analyze_params(51, 200);
end

% write event-info into eeg folder
ft_write_event(events_file, event);


% loop through all trials and create events
for itrial = 1:200
    % create event for trial i
    event(itrial).type = 'probe';
    % move event timings to end of EEG recording
    if(itrial <= 50)
        trialEnd = floor(params.Task.Trial(1,50).Timing.Probe.End * fsample); % prestim trial sampleNum
    else
        trialEnd = floor(params.Task.Trial(1,200).Timing.Probe.End * fsample); % durstim & poststim trial sampleNum
    end
    % difference in length between params and EEG data is the shift length
    moveBy = nsamples - trialEnd;
    % move sample number of event
    event(itrial).sample = params.Task.Trial(1,itrial).Timing.Probe.Start * fsample ...
        + moveBy;
    event(itrial).value = (params.Task.Trial(1, itrial).Samples(params.Task.Trial(1, itrial).Cue) == params.Task.Trial(1, itrial).Probe) == ...
        params.Task.Trial(1, itrial).Response; % true or false answer
    event(itrial).offset = [];
    event(itrial).duration = floor( params.Task.Trial(1, itrial).RT * fsample ); % milliseconds
end

