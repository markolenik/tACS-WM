% testing gen_simpleftsignal


%% LOAD DATA
% test on example data
session_path = '/Users/mark/Dropbox/tACS_project_matlab_code/exampleData/subject_BL_desynch001';

[params, rest1_eeg, pre_stim_eeg, post_dur_stim_eeg, rest2_eeg, log_path] =...
    init_session(session_path);
load(params);

raw_data_pre = read_datafile(log_path, pre_stim_eeg, params);
raw_data_dur_post = read_datafile(log_path, post_dur_stim_eeg, params);

%% CREATE TEST SIGNAL

clear all,

addpath('/Users/mark/Dropbox/tACS_project_matlab_code/fieldtrip-20130901');
addpath(genpath('/Users/mark/Dropbox/tacs_project_matlab_code/functions'));
ft_defaults;

%%
% testing on pre-stim data


fsample = params.Recording.SamplingRate;
trllength = params; % in s
=======
trllength = 10; % in s
numtrl = 1; % continuous data

[simplesignal] = gen_simpleftsignal(fsample,trllength,...
    numtrl);

% ok seems to work
