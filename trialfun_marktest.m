function [trl, event] = trialfun_marktest(cfg);

% Initialize
params = data.params;
fsample = data.hdr.Fs; % sampling rate in Hz
nsamples = data.hdr.nSamples; % number of samples (data length)


%% create events
event = struct('type',{},'sample',{},'value',{},'offset',{},'duration',{});

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

ft_write_event('/Users/Mark/Desktop/events_file.mat', event);
        