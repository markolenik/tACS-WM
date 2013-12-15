function [] = write_to_log( log_path, log_event )
%WRITE_TO_LOG appends timestamped event to logfile. Creates or modifies log
%
% SYNOPSIS
%   [] = write_to_log( session_folder, log_event )
%
% INPUT
%   (string)  log_path: path to log folder in session folder
%   (string)  log_event: event to written to logfile

log_file  = [log_path, filesep, 'log.txt'];

% timestamp up to seconds precision
timestamp = datestr(clock,'yyyy-mm-dd|HH:MM:SS');
% create log.txt
fid = fopen(log_file, 'at+');
[ST,~] = dbstack;
% write function that writes event
fprintf(fid, '%s\n', [timestamp, ': "', ST(2).name, '.m" called']);
% write event
fprintf(fid, '%s\n', [timestamp, ': ', log_event]);
fclose(fid);

end

