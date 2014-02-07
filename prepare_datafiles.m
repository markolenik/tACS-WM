function data = prepare_datafiles(session_path, params_path, rest1_eeg_path,...
    pre_stim_eeg_path, post_dur_stim_eeg_path, rest2_eeg_path)
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
%   (string) session_path:              path to session
%   (string) params_path:               path to params file
%   (string) rest1_eeg_path:            path to rest 1 EEG file
%   (string) pre_stim_eeg_path:         path to pre-stim EEG file
%   (string) post_dur_stim_eeg_path:    path to post/during-stim EEG file
%   (string) rest2_eeg_path:            path to rest 2 EEG file

% OUTPUT
%   (.mat) data: preprocessed data
%

% load params file
% NOTE: can change this to importdata
load(params_path, 'params');
log_path    = [session_path filesep 'log'];

% add info to params
params.paths.session_folder = [session_path, filesep];
params.paths.params_path = params_path;
params.paths.pre_stim_eeg_path = pre_stim_eeg_path;
params.paths.post_dur_stim_eeg_path = post_dur_stim_eeg_path;


% loop through eeg files during task; save individual files
for file_path = {pre_stim_eeg_path, post_dur_stim_eeg_path}
    % read one file, define events, single continuous trial
    data = read_datafile(char(file_path), params, log_path);
    
    % apply filters XXXXXXXXXXXXX
    data = filtEEG(data);
    
    % // ICA //
    
    % add trialinfo to data and cut out recording in between trials
    data = add_trialstruct(); % nested function
    
    % remove trials with wrong anser and outliers
    data = remove_trials(data);
    
    data = artifact_rejection_threshold(data, params);
    %       - trials mit artefakten entfernen
    
    save_files(session_folder, 'preprocessing')
    
end

cfg_append = [];
data_complete = ft_appenddata(cfg_append, data_pre, data_dur_post);

%TODO: loop through non-eeg files

function trl_data = add_trialstruct()
    cfg = [];
    cfg.trl = definetrials(data, params);
    trl_data = ft_redefinetrial(cfg, data);
end



end


