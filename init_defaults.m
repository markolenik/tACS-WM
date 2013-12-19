% script to run to initialize paths etc...
%TODO: more comment pls

clear all,

% add fieldtrip path
addpath('/Users/mark/Dropbox/tACS_project_matlab_code/fieldtrip-20130901');
% add our functions
addpath(genpath('/Users/mark/Dropbox/tacs_project_matlab_code/functions'));
% apply fieldtrip general fieldtrip settings
ft_defaults;

% add anything else here...