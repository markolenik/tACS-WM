% testing gen_simpleftsignal

clear all,

addpath('/Users/mark/Dropbox/tACS_project_matlab_code/fieldtrip-20130901');
addpath(genpath('/Users/mark/Dropbox/tacs_project_matlab_code/functions'));
ft_defaults;

%%
% testing on pre-stim data


fsample = params.Recording.SamplingRate;
trllength = 10; % in s
numtrl = 1; % continuous data

[simplesignal] = gen_simpleftsignal(fsample,trllength,...
    numtrl);

% ok seems to work
