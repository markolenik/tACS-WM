function out_data = ICA(in_data)
%ICA Remove eye-movement related components. Remove component that most
%strongly correlates with EOG.
%
% SYNOPSIS
%   out_data = ICA(in_data, record)
%
% INPUT
%   (struct) in_data:   preprocessed data (with trigger-trials)
%   (string) dataset:   path to dataset
%
% OUTPUT
%   (struct) out_data: data cleaned from EOG components
%

% get EEG channels
cfg = [];
cfg.channel = 1:64;
eeg_data = ft_preprocessing(cfg, in_data);

% get EOG channel
cfg = [];
cfg.channel = {'EOG'};
eog_data = ft_preprocessing(cfg, in_data);

cfg = [];
cfg.numcompponent = 'all';
cfg.demean = 'no';
comp = ft_componentanalysis(cfg,eeg_data);

% define which components should be removed by correlating IC with EOG
tmp1  = cat(2,comp.trial{:}); % extract matrix from cell
tmp2 = cat(2,eog_data.trial{1:end});

corEOG = zeros(size(tmp1,1),1);
for c = 1:size(tmp1,1)
    corEOG(c) = corr(tmp1(c,:)',tmp2(1,:)','type','pearson');
end
clear tmp1 tmp2
% find component of maximal correlation with EOG signal
componentReject = find(abs(corEOG)==max(abs(corEOG)));
fprintf(['IC of max correlation with EOG: ',num2str(find(abs(corEOG)==max(abs(corEOG)))),'\n'])

% the original data can now be reconstructed, excluding those components
cfg              = [];
cfg.component    = componentReject;
out_data         = ft_rejectcomponent(cfg, comp, in_data);

end
