function [simplesignal] = gen_simpleftsignal(fsample,trllength,...
    numtrl)
% generate fieldtripsignal from input vector
% vararg: fsample, trllength, numtrl, 


cfg = [];

cfg.method = 'superimposed';
cfg.output = 'all'; 

% mit diesen Parametern koennen wir ei Signal generieren, was laenger als
% unser DLDT data ist
cfg.fsample = fsample; % may have to be varied
cfg.trllen = trllength;
cfg.numtrl = numtrl;


% generate signal
% cfg.s1.freq = 2;
% cfg.s1.phase = 0;
% cfg.s1.ampl = 1;
% should leave all other signals empty...

simplesignal = ft_freqsimulation(cfg);

end



