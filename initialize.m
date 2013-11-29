function [params_file, pre_stim_eeg, post_dur_stim_eeg] = initialize( session_folder )
%INITIALIZE Initializes analysis of a session,
%           returns params and eeg file-paths when done succesfully
%
% SYNOPSIS
%   [params_file, pre_stim_eeg, post_dur_stim_eeg] = initialize( session_folder )
%
% INPUT
%   (string)  session_folder: folder that contains the parameter file (as .mat) and
%                             all EEG files (rest1, pre_stim, post_stim,
%                             rest2 at .dat)
%
% OUPUT
%   (string)  params_file:          path to params file
%   (string)  rest1_eeg:            path to rest 1 EEG file
%   (string)  pre_stim_eeg:         path to pre-stim EEG file
%   (string)  post_dur_stim_eeg:    path to post/during-stim EEG file
%   (string)  rest2_eeg:            path to rest 2 EEG file

condition   = '';
subject     = '';

% find out what session we are looking at, by looking for _condition in
% the folders name (the subject name can be drawn from the folders
% name, too)
if (strfind(session_folder,'_synch'))
    condition = 'synch';
    subject = session_folder(1:strfind(session_folder,'_synch')-1);
elseif (strfind(session_folder,'_desynch'))
    condition = 'desynch';
    subject = session_folder(1:strfind(session_folder,'_desynch')-1);
elseif (strfind(session_folder,'_sham'))
    condition = 'sham';
    subject = session_folder(1:strfind(session_folder,'_sham')-1);
end

% the following three files are essential to analyse the session. their
% filenames consist of subject and condition as follows
params_file         = [session_folder filesep subject,'_',condition,'.mat'];
rest1_eeg           = [session_folder filesep subject,'_',condition,'S001R01.dat'];
pre_stim_eeg        = [session_folder filesep subject,'_',condition,'S001R02.dat'];
post_dur_stim_eeg   = [session_folder filesep subject,'_',condition,'S001R03.dat'];
rest2_eeg           = [session_folder filesep subject,'_',condition,'S001R04.dat'];

% only if all objects exist, create a log-folder and create a logfile
% in this folder
if(exist(params_file, 'file') && exist(pre_stim_eeg, 'file') && ...
        exist(post_dur_stim_eeg, 'file') && exist(rest1_eeg, 'file') ...
        && exist(rest2_eeg, 'file'))
%     mkdir([session_folder, filesep, 'log']); %why creating folder?
    write_to_log(session_folder, ['successfully initiated session ', condition, ' for ', subject]);
    success = true;
end

% now that everything is in place, the preprocessing can begin
end

