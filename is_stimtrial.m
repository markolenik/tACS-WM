function trl_stim = is_stimtrial(trl)
% input is one trial matrix with data
% output is boolean vector with stimtrials/no-stim and last stimtrial


% threshold chosen by visual investigation of data
trl_stim = trl_energy(trl) > 1e10;

end