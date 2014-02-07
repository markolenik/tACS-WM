function m_databrowser(dat)

cfg = [];
cfg.continuous = 'no';
cfg.viewmode = 'vertical';
cfg.channel = {'F3','P3'};


ft_databrowser(cfg,dat);

end