function [] = write_to_log( session_folder, log_event )
%WRITE_TO_LOG appends timestamped event to logfile. Creates a new log file,
%   if not existent.
%
% SYNOPSIS
%   [] = write_to_log( session_folder, log_event )
%
% INPUT
%   (string)  session_folder: folder that contains the parameter file (as .mat) and
%                             all EEG files (rest1, pre_stim, post_stim,
%                             rest2 at .dat)
%   (string)  log_event: event to written to logfile

log_file  = [session_folder, filesep, 'log.txt'];

% timestamp up to seconds precision
timestamp = datestr(clock,'yyyy-mm-dd-HH:MM:SS');
% create log.txt
fid = fopen(log_file, 'at+');
[ST,~] = dbstack;
fprintf(fid, '%s\n', [timestamp, ': "', ST(2).name, '" called']);
fprintf(fid, '%s\n', [timestamp, ': ', log_event]);
fclose(fid);

%some change

end

