% testing gen_simpleftsignal

clear all,

addpath('/Users/mark/Dropbox/tACS_project_matlab_code/fieldtrip-20130901');
addpath(genpath('/Users/mark/Dropbox/tacs_project_matlab_code/functions'));
ft_defaults;

fsample = 1000;
trllength = 1000;
numtrl = 20;

[simplesignal] = gen_simpleftsignal(fsample,trllength,...
    numtrl);