m_defaults;
global main_path session_path;

[params_path, rest1_eeg, pre_stim_eeg, post_dur_stim_eeg, rest2_eeg, log_path] =...
    init_session(session_path);
params = importdata(params_path);

params.paths.session_folder = [session_path, filesep];
params.paths.params_path = params_path;
params.paths.pre_stim_eeg_path = pre_stim_eeg;
params.paths.post_dur_stim_eeg_path = post_dur_stim_eeg;

%%

pre_stim = params.paths.pre_stim_eeg_path;
post_stim = params.paths.post_dur_stim_eeg_path;

[data_pre, dat_info_pre] = read_datafile(char(pre_stim), params, log_path);
[data_post, dat_info_post] = read_datafile(char(post_stim), params, log_path);

fdata_pre = filtEEG(data_pre);
fdata_post = filtEEG(data_post);


cfg = [];
cfg.trl = definetrials(fdata_pre, params, dat_info_pre);
trl_data_pre = ft_redefinetrial(cfg, fdata_pre);

cfg = [];
cfg.trl = definetrials(fdata_post, params, dat_info_post);
trl_data_post = ft_redefinetrial(cfg, fdata_post);

%%
clear_data_pre = remove_trials(trl_data_pre,dat_info_pre);
clear_data_post = remove_trials(trl_data_post,dat_info_post);


% doesn't work, not sure about the amplitude range, add later
% cfg = [];
% cfg.continuous = 'no';
% cfg.trl = data.cfg.trl;
% cfg.artfctdef.threshold.channel = {'F3', 'P3'};
% cfg.artfctdef.threshold.range = 2; % uV
% [cfg, artifact] = ft_artifact_threshold(cfg, clear_data);

%% Calc phase
stat = WPLI(clear_data_pre);
wpli = squeeze(stat.wpli_debiasedspctrm);
% plot
t = squeeze(wpli);
% t(:,isnan(t(1,:))) = [];
% t(:,[1:50, 82:end]) = [];
figure,
surf(stat.time,stat.freq,t,'edgecolor','none');
axis tight;
xlabel('Time'); ylabel('Hz');
view(2);
% zlim([0,0.15]);
% caxis([-20,50]);
bar = colorbar;

%%
stat = WPLI(clear_data_post);
wpli = squeeze(stat.wpli_debiasedspctrm);
% plot
t = squeeze(wpli);
% t(:,isnan(t(1,:))) = [];
% t(:,[1:50, 82:end]) = [];
figure,
surf(stat.time,stat.freq,t,'edgecolor','none');
axis tight;
xlabel('Time'); ylabel('Hz');
view(2);
% zlim([0,0.15]);
% caxis([-20,50]);
bar = colorbar;

