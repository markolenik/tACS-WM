function sessioninfo = get_sessionsinfo(file_path, params)
%GET_SESSIONSINFO

% /Users/mark/Desktop/YM_synch_prestim_files.mat


subjectID = params.Subject.ID: % subjectID
session = params.Subject.NumMeasurement; % number of session (1,2,3)
condition = params.Subject.Conditions(session); % stim conditions (sham, synch, desynch)
path = file_path; % path to file (with file name)
file_path(strfind(file_path, '.dat')-3:1:strfind(file_path, '.dat')-1);
record = []; % type of file recorded (rest1, pre_stim, dur_post_stim, rest2)


