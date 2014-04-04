% m_defaults

clear all
% define paths as global variables
global MAIN_PATH DESYNCH_PATH SHAM_PATH SYNCH_PATH;
MAIN_PATH = '/Users/mark/Documents/theta_tACS';
% add fieldtrip path
addpath([MAIN_PATH filesep 'fieldtrip-20130901']);
% add our functions
addpath(genpath([MAIN_PATH filesep 'functions']));
% apply fieldtrip general fieldtrip settings
ft_defaults;

% add session path
DESYNCH_PATH = [MAIN_PATH filesep 'exampleData' filesep 'subject_BL_desynch001'];
SHAM_PATH = [MAIN_PATH filesep 'exampleData' filesep 'subject_BL_sham001'];
SYNCH_PATH = [MAIN_PATH filesep 'exampleData' filesep 'subject_BL_synch001'];

cd '/Users/mark/Documents/theta_tACS/functions';


