cfg             = [];
cfg.ntrials     = 500;
cfg.triallength = 1;
cfg.fsample     = 200;
cfg.nsignal     = 3;
cfg.method      = 'ar';
cfg.params(:,:,1) = [ 0.8    0    0 ; 
                        0  0.9  0.5 ;
                      0.4    0  0.5];
cfg.params(:,:,2) = [-0.5    0    0 ; 
                        0 -0.8    0 ; 
                        0    0 -0.2];       
cfg.noisecov      = [ 0.3    0    0 ;
                        0    1    0 ;
                        0    0  0.2];
data              = ft_connectivitysimulation(cfg);
%%

cfg           = [];
cfg.method    = 'mtmconvol';
cfg.taper     = 'hanning';
cfg.output    = 'powandcsd';
cfg.keeptrials = 'yes';
cfg.foi = 2:0.5:20;
cfg.toi = (-0.3-0.25):0.01:(0.5+0.25);
cfg.t_ftimwin = ones(length(cfg.foi),1) .*0.5;
[freq] = ft_freqanalysis(cfg, data);

%%

cfg = [];
cfg.method = 'wpli_debiased';
stat = ft_connectivityanalysis(cfg,freq);
