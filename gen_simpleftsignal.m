function [simplesignal] = gen_simpleftsignal(fsample,trllenght,...
    numtrl)
% generate fieldtripsignal from input vector
% vararg: fsample, trllength, numtrl, 

% TODO: if nargin...

cfg = [];

cfg.method = superimposed;
cfg.output = 1; 

% mit diesen Parametern koennen wir ei Signal generieren, was laenger als
% unser DLDT data ist
cfg.fsample = fsample; % may have to be varied
cfg.trllen = trllength;
cfg.numtrl = numtrl;


% generate signal
cfg.s1.freq = 10;
cfg.s1.phase = 0;
cfg.s1.ampl = 1;
% should leave all other signals empty...





end
%NOTE: params muesste dann noch hinzugefuegt werden zu cfg nach dem output



