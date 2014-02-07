function data = filtEEG(data)
%FILTEEG Filter EEG data from noise.
%
% SYNOPSIS
%   data = filtEEG(data)
%
% INPUT
%   (struct) data: continuous data (1 trial) to prevent bias
%
% OUPUT
%   (struct) clean: filtered data
%

% cfg = [];
% cfg.hpfilter = 'yes';
% cfg.hpfreq = 1;
% cfg.hpfiltdir = 'twopass';
% cfg.hpfilttype = 'firls';
% % NOTE: why does it take so long?
% cfg.lpfilter = 'yes';
% cfg.lpfreq = 100;
% cfg.lpfiltdir = 'twopass';
% cfg.lpfilttype = 'firls';
% cfg.bsfilter = 'yes';
% cfg.bsfreq = [46 54];
% cfg.bsfiltdir = 'twopass';
% cfg.bsfilttype = 'firls';


cfg = [];
cfg.hpfilter = 'yes';
cfg.hpfreq = 1;
% cfg.hpfiltdir = 'twopass';
% cfg.hpfilttype = 'firls';
% NOTE: why does it take so long?
cfg.lpfilter = 'yes';
cfg.lpfreq = 25;
% cfg.lpfiltdir = 'twopass';
% cfg.lpfilttype = 'firls';
cfg.bsfilter = 'yes';
cfg.bsfreq = [46 54];
% cfg.bsfiltdir = 'twopass';
% cfg.bsfilttype = 'firls';

cfg.detrend = 'yes';
cfg.channel = {'all'};

data = ft_preprocessing(cfg, data);
% NOTE: uncomment later
% write_to_log(session_path, ['succesfully filtered data from ', data.cfg.dataset]);

end