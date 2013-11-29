function data = loadsave(EEG)
% BLA BLA nur zum Testen
% LOAD_SAVE Load and save data.
%
% SYNOPSIS
%   data = loadssave(EEG, params, destPath)
%
% INPUT
%   (char) EEG: path to BCI2000 .dat file
%   (char) params: path to parameter file
%   (char) destPath: destination folder where to save the file
%

% First load EEG data

% Define 1 trial (continuous data)
cfg = [];
cfg.dataset = EEG;
cfg.trialfun = 'trialfun_param_events';

cfg = ft_definetrial(cfg);

% Add channel information
% cfg.channel = {'Fp1','Fp2','F7','F3','Fz','F4','F8','FC5','FC1','FC2','FC6','T7','C3','Cz','C4','T8','TP9','CP5','CP1','CP2','CP6','TP10','P7','P3','Pz','P4','P8','PO9','O1','Oz','O2','PO10','AF7','AF3','AF4','AF8','F5','F1','F2','F6','FT9','FT7','FC3','FC4','FT8','FT10','C5','C1','C2','C6','TP7','CP3','CPz','CP4','TP8','P5','P1','P2','P6','PO7','PO3','POz','PO4','PO8','EOG','APBleft', 'APBright',''};
% IS THAT CORRECT??? SEEMS NOT TO WORK
% //alex// I think it should be DATA.label after ft_preprocessing if you
%          only want to rename the channels. cfg.channel is mostly to
%          select the channels that are subject to the following function
%          (so usually cfg.channel = {'F3', 'P3'}; )


% Load data, store params in cfg
data = ft_preprocessing(cfg);

% save data
% save(char(strcat(destPath,filesep,data.cfg.params.Subject.ID,'_',data.cfg.params.Subject.Conditions(data.cfg.params.Subject.NumMeasurement))), 'data');

end