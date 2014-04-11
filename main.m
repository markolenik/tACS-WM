% pseudocode zur Uebersicht
%
% GRUNDLEGENDES:
% - paths hinzufügen
% - toolbox hinzufügen
%
% AUSWERTUNG PRO SESSION:
% loop über alle sessions (als dateiordner)
%   - session-ordner auf vollständigkeit prüfen                            initialize.m (done(alex) - getestest)
%   - 'loop' über beide EEG-Aufnahmen (pre_stim und dur_post_stim)         prepare_datafiles.m (in progress(alex) - ungetestet)
%       - ft_definetrial (1 trial, events)
%       - filtern                                                          filtEEG.m (done?(mark) - ungetestet)
%       - (ICA)                                                            ICA.m (angefangen(alex) - ungetestet)
%       - [trl] definieren                                                 definetrial.m (?(mark) - ?)
%       - ft_redefinetrial (trl-matrix)
%       - trials mit falscher antwort entfernen                            remove_trials.m
%       - trials mit RT > 2*stddev innerhalb der session entfernen         remove_trials.m
%       - trials mit peaktopeak <2uV >100uV entfernen                      artifact_rejection_threshold.m
%       - trials mit artefakten entfernen
%       - ICA
%       - WPLI
%   - ANOVA
%
%%
clc
clear all
% define paths as global variables
MAIN_PATH = 'D:\ThesisData';
% add fieldtrip path
addpath([MAIN_PATH filesep 'fieldtrip-20130901']);
RESULT_PATH = [MAIN_PATH filesep 'RESULTS'];
% add our functions
%FUNCTIONS_PATH = [MAIN_PATH filesep 'functions'];
FUNCTIONS_PATH = '\\ads.bris.ac.uk\filestore\MyFiles\Students\mo13924\Documents\GitHub\tACS-WM';
addpath(genpath(FUNCTIONS_PATH));
% apply fieldtrip general fieldtrip settings
ft_defaults;
% go to path
cd(FUNCTIONS_PATH);
DATA_PATH = [MAIN_PATH filesep 'EEG'];

%% LOOP SUBJECTS
% exclude CR for now, sth went wrong here
%subject_list = {'AF', 'AG', 'ArG', 'AT', 'BL', 'CS', 'DZ', 'FG',...
%    'ML', 'NP', 'SG', 'SP', 'VS', 'YM'};

subject_list = {'FG',...
    'ML', 'NP', 'SG', 'SP', 'VS', 'YM'};
N = length(subject_list);

%%condition = params.Subject.Conditions{params.Subject.NumMeasurement};

% create log.txt
% timestamp up to seconds precision

fid = fopen([RESULT_PATH filesep 'progress_log'], 'at+');
%TODO: run subject 'CR'
for n = 1:N
    subjectID = subject_list{n};
    timestamp = datestr(clock,'yyyy-mm-dd|HH:MM:SS');
    % write event
    fprintf(fid, '%s\n', '=========================================');
    fprintf(fid, '%s\n', [timestamp, ' Running subject ' subjectID]);
    
    DESYNCH_PATH = [DATA_PATH filesep 'subject_' subjectID '_desynch001'];
    SHAM_PATH = [DATA_PATH filesep 'subject_' subjectID '_sham001'];
    SYNCH_PATH = [DATA_PATH filesep 'subject_' subjectID '_synch001'];
    
    savepath = [RESULT_PATH filesep subjectID];
    mkdir(savepath);
    % loop sessions
    sessionpath_list = {DESYNCH_PATH, SHAM_PATH, SYNCH_PATH};
    session_list = {'desynch', 'sham', 'synch'};
    for i = 1:3
        datasetpath = sessionpath_list{i};
        session = session_list{i};
        timestamp = datestr(clock,'yyyy-mm-dd|HH:MM:SS');
        fprintf(fid, '%s\n', [timestamp, ' ', session]);
        % initialise session
        [params_path, rest1, pre_stim, post_dur_stim, rest2, logpath] =...
            init_session(datasetpath);
        params = importdata(params_path);
        % run just sham, since rest already analysed before
        condition = params.Subject.Conditions{params.Subject.NumMeasurement};
        file_list = {pre_stim, post_dur_stim};
        % loop conditions in session
        for j = 1:2
            filepath = file_list{j};
            [wpli, finaldat, record] = run_session(filepath, logpath, params, condition);
            % save everything from wpli apart from cfg (too big)
            temp.wpli = [];
            temp.wpli.labelcmb = wpli.labelcmb;
            temp.wpli.dimord = wpli.dimord;
            temp.wpli.wpli_debiasedspctrm = wpli.wpli_debiasedspctrm;
            temp.wpli.freq = wpli.freq;
            temp.wpli.time = wpli.time;
            temp.trial = finaldat.trialinfo;
            temp.ID = subjectID;
            temp.record = record;
            temp.condition = condition;
            save([savepath filesep subjectID '_' session '_' record '_result'], 'temp');
            %save([savepath filesep subjectID '_' session '_' record '_finaldat'], 'finaldat');
        end
        
    end
end

fclose(fid);
