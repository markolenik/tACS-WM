function m_singleplot( file, channel )
%M_SINGLEPLOT plots the event-related fields or potentials of a single
%   channel or the average over multiple channels. Multiple datasets can be
%   overlayed.

cfg = [];

cfg.hotkeys = 'yes';
cfg.trials = 'all';

if(nargin > 1)
    cfg.channel = channel;
else
    cfg.channel = 'all';
end

ft_singleplotER(cfg, file);


end

