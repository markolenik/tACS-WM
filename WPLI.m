function [stat] = WPLI(data)
%WPLI

cfg = [];
cfg.method = 'mtmconvol';
cfg.output = 'powandcsd';
cfg.channel = {'F3', 'P3'};
cfg.channelcmb = {'F3', 'P3'};
cfg.keeptrials = 'yes';
cfg.keeptapers = 'no';
cfg.taper = 'hanning';
cfg.foi = 2:0.5:20;
cfg.t_ftimwin = ones(length(cfg.foi),1).*0.5;
cfg.toi = -0.3-0.25:0.01:0.5+0.25;
[freq] = ft_freqanalysis(cfg, data);

%% WPLI
cfg = [];
cfg.method = 'wpli_debiased';
stat = ft_connectivityanalysis(cfg, freq);




%%%
% [xx yy] = meshgrid(1:0.1:10);  %force it to interpolate at every 10th pixel
% surf(interp2(X,xx,yy))





