function [stat] = WPLI(data)
%WPLI
cfg           = [];
cfg.method    = 'mtmconvol';
cfg.taper     = 'hanning';
cfg.output    = 'powandcsd';
cfg.keeptrials = 'yes';
cfg.foi = 0:1:20;
cfg.toi = -0.3:0.01:0.5;
cfg.t_ftimwin = ones(length(cfg.foi),1) .*0.5;
% cfg.t_ftimwin = 1./cfg.foi;
% cfg.pad = 20;

cfg.channel = {'F3','P3'};
cfg.channelcmb = {'F3','P3'};
[freq] = ft_freqanalysis(cfg, data);

% WPLI
cfg = [];
cfg.method = 'wpli_debiased';
stat = ft_connectivityanalysis(cfg, freq);

end

