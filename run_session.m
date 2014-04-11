function [stat, finaldat, record] = run_session(filepath, logpath, params, condition)

% read data
try
    [raw_dat, record] = read_datafile(filepath, params);
    write_to_log(logpath, ['successfully read data from ' filepath]);
catch
    write_to_log(logpath, ['error in reading data from ' filepath]);
    error(['error in reading data from ' filepath]);
end

% filter
try
    fdat = filtEEG(raw_dat, [1,20]);
    write_to_log(logpath, ['successfully filtered data from ' filepath]);
catch
    write_to_log(logpath, ['error in filtering data from ' filepath]);
    error(['error in filtering data from ' filepath]);
end


% define trials according to events
try
    cfg = [];
    cfg.trl = definetrials(fdat);
    trialdat = ft_redefinetrial(cfg, fdat);
    write_to_log(logpath, ['successfully defined trials for ' filepath]);
catch
    write_to_log(logpath, ['error in defining trials for ' filepath]);
    error(['error in defining trials for ' filepath]);
end


% reject artefacts
try
    rejdat = remove_trials(trialdat, record, condition);
    write_to_log(logpath, ['successfully removed trials from ', filepath]);
catch
    write_to_log(logpath, ['error in removing trials for ', filepath]);
    error(['error in removing trials for ', filepath]);
end

%{
% perform ICA
try
    finaldat = ICA(rejdat);
    write_to_log(logpath, ['successfully ran ICA on ', filepath]);
catch
    write_to_log(logpath, ['error in performing ICA on ', filepath]);
    error(['error in performing ICA on ', filepath]);
end
%}

finaldat = rejdat;

% calculate WPLI
try
    stat = WPLI(finaldat, [1,20]);
    % 	wpli = squeeze(stat.wpli_debiasedspctrm);
    write_to_log(logpath, ['successfully calculated WPLI on ', filepath]);
catch
    write_to_log(logpath, ['error in calculating WPLI on ', filepath]);
    error(['error in calculating WPLI on ', filepath]);
end
end