session_path = 'D:\Dropbox\tACS_project_matlab_code\exampleData\subject_BL_desynch001';
    
[params_path, rest1_eeg_path, pre_stim_eeg_path, post_dur_stim_eeg_path, rest2_eeg_path, log_path] ...
    = initialize(session_path)

data = prepare_datafiles(session_path, params_path, rest1_eeg_path, pre_stim_eeg_path, ...
    post_dur_stim_eeg_path, rest2_eeg_path)


cfg_pre = [];
cfg_pre.dataset = 'C:\project\EEG\subject_AF_desynch001\subject_AF_desynchS001R02.dat';
cfg_pre.trialdef.triallength = 100;
cfg_pre.trialdef.ntrials = 3;
cfg_pre = ft_definetrial(cfg_pre);
cfg_pre.continuous = 'yes';
data_pre = ft_preprocessing(cfg_pre);

load('C:\project\params\subject_AF_desynch.mat','params');
cfg = [];
cfg.record = 'dur_post_stim';
cfg.params = params;
cfg.trialfun = 'trialfun_param_events';
cfg.dataset = 'C:\project\EEG\subject_AF_desynch001\subject_AF_desynchS001R03.dat';
cfg = ft_definetrial(cfg);
%cfg.continuous = 'yes';
data = ft_preprocessing(cfg);

cfg_append = [];
data_complete = ft_appenddata(cfg_append, data_pre, data_dur_post);



data = ft_preprocessing(cfg);


          
% cfg             = [];
% cfg.channel     = 'all';
% cfg.reref       = 'yes';
% cfg.refchannel  = 'TP9';
% cfg.implicitref = 'FCz' ;
% data            = ft_preprocessing(cfg,data);





% geht nicht??
cfg.channel = {'F3', 'P3', 'EOG'};
cfg.trl = {120};
cfg = ft_databrowser(cfg, data);

%%%%%%%%% von robert geklaut. keine ahnung ob ich davon was brauchen kann.
% anpassen an unsere channels mit emg und so..
hdr.label = {'Fp1','Fp2', ...
              'F7','F3','Fz','F4','F8', ...
              'FC5','FC1','FC2','FC6', ...
              'T7','C3','Cz','C4','T8', ...
              'TP9','CP5','CP1','CP2','CP6','TP10', ...
              'P7','P3','Pz','P4','P8', ...
              'PO9','O1','Oz','O2','PO10', ...
              'AF7','AF3','AF4','AF8', ...
              'F5','F1','F2','F6', ...
              'FT9','FT7','FC3','FC4','FT8','FT10', ...
              'C5','C1','C2','C6', ...
              'TP7','CP3','CPz','CP4','TP8', ...
              'P5','P1','P2','P6', ...
              'PO7','PO3','POz','PO4','PO8', ...
              'EOG', ...
              'APBleft', 'APBright', ...
              ''};
% chan.select     = {'Fp1','Fp2','F7','F3','Fz','F4','F8','FC5','FC1','FC2','FC6','T7','C3','Cz','C4','T8' 'TP9','CP5','CP1','CP2','CP6','TP10','P7','P3','Pz','P4','P8','PO9','O1','Oz','O2','PO10', ...
%                    'AF7','AF3','AF4','AF8','F5','F1','F2','F6','FT9','FT7','FC3','FC4','FT8','FT10','C5','C1','C2','C6','TP7','CP3','CPz','CP4','TP8','P5','P1','P2','P6','PO7','PO3','POz','PO4','PO8','FCz'};
chan.select = {'F3', 'P3'}; % + emg channels? ist das kluk?

data                        = ft_preprocessing(cfg);
data.label                  = chan.setup;
cfg                         = [];        
cfg.reref                   = 'yes';
cfg.refchannel              = 'EEG';
cfg.implicitref             = 'FCz' ;
data                        = ft_preprocessing(cfg,data);
cfg                         = [];
cfg.bsfilter                = 'yes';
cfg.bsfreq                  = [45 55];
data                        = ft_preprocessing(cfg,data);

cfg                         = [];
cfg.trials                  = 'all';
cfg.length                  = 2;
data                        = ft_redefinetrial(cfg,data);

L                           = length(data.trial);
cfg                         = [];
cfg.trials                  = L-20:L-6;
data                        = ft_preprocessing(cfg,data);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% artifact removal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

%     R = []; 
%     for t=1:length(data.trial),
%         R = cat(1,R,range(data.trial{t}')); 
%     end
%     incl = 1:length(data.trial);
%     incl(sum(R'>200)>0) = [];
%     cfg                         = [];
%     cfg.trials                  = incl;
%     data                        = ft_preprocessing(cfg,data);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% frequency estimation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

cfg                         = [];
cfg.trials                  = 'all';
cfg.method                  = 'mtmfft';
cfg.output                  = 'powandcsd';
cfg.taper                   = 'dpss';
cfg.keeptrials          	= 'yes';
cfg.channel                 = 'EEG';
cfg.channelcmb              = {'EEG' 'EEG' };
cfg.tapsmofrq               = [2];
cfg.foi                     = [1:100];
freq                        = ft_freqanalysis(cfg, data);    

freq_results(f)             = freq;

end