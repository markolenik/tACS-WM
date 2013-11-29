function out_data = ICA(in_data)
    %split in_data in eeg and eog channels
    cfg = [];
    cfg.channel = [1:64];
    eeg_data = ft_preprocessing(cfg, in_data);
    
    cfg = [];
    cfg.channel = {'EOG'};
    eog_data = ft_preprocessing(cfg, in_data);
    
    %do ICA for 40 components // with only two channels? or rather use all to be able to identify more components?
    cfg = []; 
    %cfg.channel = {'F3', 'P3'};
    cfg.numcomponent = 40;
    comp = ft_componentanalysis(cfg,eeg_data);
    cfg.trials = 1;
    comp_dur = ft_componentanalysis(cfg,eeg_data);
    cfg.trials = 2;
    comp_post = ft_componentanalysis(cfg,eeg_data);
    
    % visualization:
    
    elec = ft_convert_units(ft_read_sens('C:\project\fieldtrip\template\electrode\standard_1005.elc'),'cm');
    f = [];
    for k=1:length(eeg_data.label)
        f = [f,find(strcmpi(elec.label,eeg_data.label{k}))];
    end
    elec.chanpos = elec.chanpos(f,:);
    elec.elecpos = elec.elecpos(f,:);
    elec.label   = elec.label(f,:);
    
    cfg = [];
    cfg.viewmode = 'component'; 
    cfg.continuous = 'yes';
    cfg.blocksize = 5;
    cfg.channels = {'F3', 'P3'};
    cfg.elec = elec;
    cfg.layout = ft_prepare_layout(cfg);
    ft_databrowser(cfg,comp);
  
    %
    
    % define which components should be removed by correlating IC with EOG
    tmp  = cat(2,comp.trial{:});
    % tmp1 = cat(2,dataCmbECG.trial{:});
    tmp2 = cat(2,eog_data.trial{:});
    
    corEOG = zeros(size(tmp,1))
    for c = 1:size(tmp,1)
       % corECG(c) = corr(tmp(c,:)',tmp1(1,:)','type','pearson');
       corEOG(c) = corr(tmp(c,:)',tmp2(1,:)','type','pearson');
    end
    clear tmp tmp2
    
    % find component of maximal correlation with EOG signal
    componentReject = find(abs(corEOG)==max(abs(corEOG)));
    fprintf(['IC of max correlation with EOG: ',num2str(find(abs(corEOG)==max(abs(corEOG)))),'\n'])
    
    % the original data can now be reconstructed, excluding those components
    cfg              = [];    
    cfg.component    = [componentReject];
    out_data         = ft_rejectcomponent(cfg, comp, dataCmb);
end
