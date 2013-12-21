% testing simpleftsignal
%% GENERATE SIGNAL
[params, rest1_eeg, pre_stim_eeg, post_dur_stim_eeg, rest2_eeg, log_path] =...
    init_session(session_path);
load(params);

% generate test data for prestim
fsample = params.Recording.SamplingRate;
% test data is
% difference in length between test_data and params_data
move_by = 200;
trllength = params.TimeStamps.TaskPreStim.End + move_by;
numtrl = 1; % continuous data

simplesignal = simpleftsignal(fsample,trllength,...
    numtrl);

%% TEST LENGTH OF SIGNAL
disp(['actual:   ' num2str(length(simplesignal.trial{1,1}))]);
disp(['expected: ' num2str(floor(trllength*fsample))]);

% ok seems to work