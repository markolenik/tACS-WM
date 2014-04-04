function data = filtEEG(data, freq)
%FILTEEG Filter EEG data from noise.
%
% SYNOPSIS
%   data = filtEEG(data)
%
% INPUT
%   (struct) data: continuous data (1 trial) to prevent bias
%   (string) filepath: path to dataset
%
% OUPUT
%   (struct) data: filtered data
%

cfg = [];
cfg.bpfilter = 'yes';
cfg.bpfreq = freq;
cfg.bpdir = 'twopass';
cfg.bptype = 'fir';
cfg.continuous = 'yes';
cfg.detrend = 'yes';
cfg.channel = 'all';

data = ft_preprocessing(cfg, data);

end