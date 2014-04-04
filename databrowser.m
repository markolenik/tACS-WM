function databrowser(dat, continuous)

if nargin<2
    continuous = 0;
end
cfg = [];

if continuous
    cfg.continous = 'yes';
else
    cfg.continous = 'no';
    
end
cfg.viewmode = 'vertical';
cfg.channel = {'F3','P3'};

ft_databrowser(cfg,dat);

end