function [stat] = WPLI(data, freq)
%WPLI Apply unbiased wpli on data to calculate the phase lag.
%
% SYNOPSIS
%   (struct) stat = WPLI(data)
%
% INPUT
%   (struct) data: preprocessed data in 1 sec trials (so that the
%   stimulation trials can be ignored)
%
%


cfg           = [];
cfg.method    = 'mtmconvol';
cfg.taper     = 'hanning';
cfg.output    = 'powandcsd';
cfg.keeptrials = 'yes';
cfg.foi = freq(1):0.1:freq(2);
cfg.toi = -0.3:0.001:0.5;
cfg.t_ftimwin = ones(length(cfg.foi),1) .*0.5;

cfg.channel = {'F3','P3','F5','P5'};
cfg.channelcmb = {'F3','P3'; 'F3','F5'; 'P3','P5'};
[freq] = ft_freqanalysis(cfg, data);

% WPLI
cfg = [];
cfg.method = 'wpli_debiased';
stat = ft_connectivityanalysis(cfg, freq);

end

