% function mark_test
clear all,

addpath(genpath('/Users/mark/Dropbox/tACS_project_matlab_code/fieldtrip-20130901'));


session_path = '/Users/mark/Dropbox/tACS_project_matlab_code/exampleData/subject_BL_desynch001';

[params, rest1_eeg, pre_stim_eeg, post_dur_stim_eeg, rest2_eeg, log_path] =...
    initialize(session_path);
load(params);
raw_data = read_datafile(log_path, pre_stim_eeg, params);

%%
cfg.channel = {'F3', 'P3', 'EOG'};
cfg = ft_databrowser(cfg, raw_data);
