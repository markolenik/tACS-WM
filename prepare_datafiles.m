function data = prepare_datafiles(session, rest1_eeg, pre_stim_eeg, post_dur_stim_eeg, rest2_eeg)
%PREPARE_DATAFILES Preprocessing of data, filtering etc.
% 1. filter data
% 2. ICA
% 3. trialdefinition
% 4. append pre and post stim
% 5. save data
%
% SYNOPSIS
%   data = prepare_datafiles(session, params, rest1_eeg, pre_stim_eeg, post_dur_stim_eeg, rest2_eeg)
%
% INPUT
%   (string) session:              path to session
%   (string) rest1_eeg:            path to rest1 EEG file
%   (string) pre_stim_eeg:         path to pre-stim EEG file
%   (string) post_dur_stim_eeg:    path to post/during-stim EEG file
%   (string) rest2_eeg:            path to rest2 EEG file
%
% OUTPUT
%   (.mat) data: preprocessed data
%
% Expect params_file, pre_stim_eeg, post_dur_stim_eeg to be known after call
% of initialize.m
%     params_file         = [session_folder filesep subject,'_',condition,'.mat'];
%     pre_stim_eeg        = [session_folder filesep subject,'_',condition,'S001R02.dat'];
%     post_dur_stim_eeg   = [session_folder filesep subject,'_',condition,'S001R03.dat'];
%


% params = ...

read(params, 'params');


params.paths.session_folder = session;
params.paths.params_file = params;
params.paths.pre_stim_eeg = pre_stim_eeg;
params.paths.post_dur_stim_eeg = post_dur_stim_eeg;

% loop through eeg files during task
for file_path = {pre_stim_eeg, post_dur_stim_eeg}
    
    data = read_datafile();
    % apply filters XXXXXXXXXXXXX
    data = filtEEG(data);
    
    % // ICA //
    
    % add trialinfo to data and cut out recording in between trials
    data = add_trialstruct(); % nested function
    
    data = remove_trials();
    data = artifact_rejection_threshold(data, params);
    %       - trials mit artefakten entfernen
    
    save_files(session_folder, 'preprocessing')
    
end

function trl_data = add_trialstruct()
cfg = [];
cfg.trl = definetrials(data, params);
trl_data = ft_redefinetrial(cfg, data);
end



end


