function trl = definetrials(data)
%DEFINETRIALS Define custom trials.
%
% SYNOPSIS
%   trl = definetrials(data, params)
%
% INPUT
%   (struct) data: continuous filtered data (1 trial)
%
% OUTPUT
%   (matrix) trl: data cut in trials
%   
% trl has following structure, count in samples:
% [begin end offset RT value]
%
% We replicate the polania study's trial window beginning 300ms (1500ms) prior to
% the probe onset, finishing 500ms (1500ms) after probe onset.
% additional to the expected structure [begin end offset] we add
% some more information about the trial (comments in embedded function)

event = ft_fetch_event(data);
hdr = data.hdr;

% For WPLI only time in [-300ms 500ms] range of cue will be considered.
% But we take a bigger trialwindow for better frequency resolution
PRECUEDUR = 3000; % we take 300ms + 1200ms for window
POSTCUEDUR = 5000; % we take 500ms + 1000ms for window

trl = [];
% read out event 'task'
tasks = [event(find(strcmp('task', {event.type})))];
for tsk = 1:length(tasks)
    begin_trial = tasks(tsk).sample;
    end_trial = begin_trial + tasks(tsk).duration;
    % get all events for one trial
    tsk_events = event([event.sample]>=begin_trial);
    tsk_events = tsk_events([tsk_events.sample]<=end_trial);
    tsk_trial = create_trial(tsk_events);
    if(tsk_trial(2)<=hdr.nSamples)
        trl(end+1,:) = tsk_trial;
    end
end


% create trials
    function trl = create_trial(tsk_events)
        
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