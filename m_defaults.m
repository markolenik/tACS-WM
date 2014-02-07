function defaults = m_defaults

% script to run to initialize paths etc...
%TODO: more comment pls

clear all,

% main folder
global main_path;
main_path = '/Users/mark/Documents/theta_tACS';
% add fieldtrip path
addpath([main_path filesep 'fieldtrip-20130901']);
% add our functions
addpath(genpath([main_path filesep 'functions']));
% apply fieldtrip general fieldtrip settings
ft_defaults;

% add session path
global session_path;
% session_path = [main_path filesep 'exampleData' filesep 'subject_BL_desynch001'];
% session_path = [main_path filesep 'exampleData' filesep 'subject_BL_sham001'];
session_path = [main_path filesep 'exampleData' filesep 'subject_BL_synch001'];


% if global variables don't work, generate output
defaults.mainPath = main_path;
defaults.sessionPath = session_path;

end