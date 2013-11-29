function [trl, event] = trialfun_no_events(cfg);

% read the header information without events from the data
hdr   = ft_read_header(cfg.dataset);

trl = [1 hdr.nTrials 0];
event = [];