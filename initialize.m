function [params, rest1_eeg, pre_stim_eeg, post_dur_stim_eeg, rest2_eeg,...
    log_path] = initialize(session_path)
%INITIALIZE Initializes analysis of a session.
% Return params and eeg file-paths when done succesfully. Additionally, a
% log folder is created. It will contain all steps of processed data
% (filering etc.).
%
% SYNOPSIS
%   [params, rest1_eeg, pre_stim_eeg, post_dur_stim_eeg, rest2_eeg log_path] = initialize(session_folder)
%
% INPUT
%   (string)  session_path: path to folder that contains the parameter file (as .mat) and
%                             all EEG files (rest1, pre_stim, post_stim,
%                             rest2 at .dat)
%
% OUPUT
%TODO: add path again to variable names
%   (string)  params:               path to params file
%   (string)  rest1_eeg:            path to rest 1 EEG file
%   (string)  pre_stim_eeg:         path to pre-stim EEG file
%   (string)  post_dur_stim_eeg:    path to post/during-stim EEG file
%   (string)  rest2_eeg:            path to rest 2 EEG file
%   (string)  log_path              path to logfile

% get subject ID
folder      = session_path(strfind(session_path, 'subject_'):end);
localize    = strfind(folder,'_');
subject     = folder(localize(1)+1:localize(2)-1);
log_path    = [session_path filesep 'log'];

condition   = '';
% find out what session we are looking at, by looking for _<condition> in
% the folders name (the subject name can be drawn from the folders
% name, too)
if (strfind(session_path,'_synch'))
    condition = 'synch';
elseif (strfind(session_path,'_desynch'))
    condition = 'desynch';
elseif (strfind(session_path,'_sham'))
    condition = 'sham';
% wrong folder    
else 
    error('Wrong folder');
end

% the following three files are essential to analyse the session. their
% filenames consist of subject and condition as follows
params              = [session_path filesep 'subject' '_' subject,'_',condition,'.mat'];
rest1_eeg           = [session_path filesep 'subject' '_' subject,'_',condition,'S001R01.dat'];
pre_stim_eeg        = [session_path filesep 'subject' '_' subject,'_',condition,'S001R02.dat'];
post_dur_stim_eeg   = [session_path filesep 'subject' '_' subject,'_',condition,'S001R03.dat'];
rest2_eeg           = [session_path filesep 'subject' '_' subject,'_',condition,'S001R04.dat'];

% check whether all objects exist
if(exist(params, 'file') && exist(pre_stim_eeg, 'file') && ...
        exist(post_dur_stim_eeg, 'file') && exist(rest1_eeg, 'file') ...
        && exist(rest2_eeg, 'file'))
    % create log folder
    mkdir(log_path);
    write_to_log(log_path, ['successfully initialized session ', '"', condition, '"', ' for subject ', '"', subject, '"']);
    success = true;
else
    write_to_log(log_path, ['files missing in session ', '"', condition, '"', ' for subject ', '"', subject, '"']);
    success = false;

% now that everything is in place, the preprocessing can begin
end

