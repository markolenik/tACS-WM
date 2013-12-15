function raw_data = read_datafile(file_path, params)
%READ_DATAFILE Read data from .dat-file and assign channel labels.
%
% SYNOPSIS
%   raw_data = read_datafile(file_path)
%
% INPUT
%   file_path:  path to the file to be read
%
% OUTPUT
%   raw_data:   loaded data with channel labels.
%

cfg = [];
cfg.filepath = file_path;
cfg.trialfun = 'trialfun_param_events'; % one trial, all events
% determine the type of recording (i.e. rest1, prestim etc...)
record_code = file_path(strfind(file_path, 'R0'):1:strfind(file_path, 'R0')+2);
switch(record_code)
    case 'R01'
        record = 'rest1';
    case 'R02'
        record = 'pre_stim';
    case 'R03'
        record = 'dur_post_stim';
    case 'R04'
        record = 'rest2';
    otherwise
        error('Wrong record_code');
end
cfg.record = record;
cfg.params = params;

cfg = ft_definetrial(cfg);
write_to_log(session, ['succesfully read events from ', file_path]);
cfg.continuous = 'yes';


raw_data = ft_preprocessing(cfg);
write_to_log(session, ['succesfully read data from ', file_path]);

% set channel names in data
raw_data.label = {'Fp1','Fp2', ...
    'F7','F3','Fz','F4','F8', ...
    'FC5','FC1','FC2','FC6', ...
    'T7','C3','Cz','C4','T8', ...
    'TP9', ...
    'CP5','CP1','CP2','CP6','TP10', ...
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



end