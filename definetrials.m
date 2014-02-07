function trl = definetrials(data, params, dat_info)
%DEFINETRIALS Define custom trials.
%
% SYNOPSIS
%   trl = definetrials(data, params)
%
% INPUT
%   (struct) data: continuous filtered data (1 trial)
%   (struct) params: parameter file
%
% OUTPUT
%   (matrix) trl: data cut in trials
%   
% trl has following structure, count in samples:
% [begin end offset RT value]
%
% We replicate the polania study's trial window beginning 300ms prior to
% the probe onset, finishing 500ms after probe onset.
% additional to the expected structure [begin end offset] we add
% some more information about the trial (comments in embedded function)

cfg = data.cfg;
event = ft_fetch_event(data);
record = dat_info.record;
hdr = data.hdr;

PRECUEDUR = 800; % we take 300ms + 500ms for window
POSTCUEDUR = 1000; % we take 500ms + 500ms for window

trl = [];
% read out event 'task'
tasks = [event(find(strcmp('task', {event.type})))];
for tsk = 1:length(tasks)
    begin_trial = tasks(tsk).sample;
    end_trial = begin_trial + tasks(tsk).duration;
    % get all events for one trial
    tsk_events = event([event.sample]>=begin_trial);
    tsk_events = tsk_events([tsk_events.sample]<=end_trial);
    tsk_trial = create_trial(tsk, tsk_events, params, record, cfg);
    if(tsk_trial(2)<=hdr.nSamples)
        trl(end+1,:) = tsk_trial;
    end
end

% create trials
    function trl = create_trial(tsk, tsk_events, params, record, cfg)
        
        % true or false answer
        probe = [tsk_events(find(strcmp('probe',{tsk_events.type})))];
        
        trl = [];
        % begin
        trl = [trl, probe.sample - PRECUEDUR];
        % end
        trl = [trl, probe.sample + POSTCUEDUR];
        % offset
        trl = [trl, -PRECUEDUR];
        % RT
        trl = [trl, probe.duration];
        % value
        trl = [trl, probe.value]; % true or false answer
    end

end