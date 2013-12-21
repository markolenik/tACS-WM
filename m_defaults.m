function defaults = m_defaults

% script to run to initialize paths etc...
%TODO: more comment pls

clear all,

% main folder
global mainPath;
mainPath = '/Users/mark/Documents/theta_tACS';
% add fieldtrip path
addpath([mainPath filesep 'fieldtrip-20130901']);
% add our functions
addpath(genpath([mainPath filesep 'functions']));
% apply fieldtrip general fieldtrip settings
ft_defaults;

% add session path
global sessionPath;
sessionPath = [mainPath filesep 'exampleData' filesep 'subject_BL_desynch001'];

% if global variables don't work, generate output
defaults.mainPath = mainPath;
defaults.sessionPath = sessionPath;

end