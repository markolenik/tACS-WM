function data = prepare_datafiles( session_path, params_file, pre_stim_eeg, post_dur_stim_eeg )
%PREPARE_DATAFILES Summary of this function goes here
% expect params_file, pre_stim_eeg, post_dur_stim_eeg to be known after call
% of initialize.m
%     params_file         = [session_folder filesep subject,'_',condition,'.mat'];
%     pre_stim_eeg        = [session_folder filesep subject,'_',condition,'S001R02.dat'];
%     post_dur_stim_eeg   = [session_folder filesep subject,'_',condition,'S001R03.dat'];
    
    read(params_file, 'params');
    % add some rather important paths (no changing of computers anymore plz.. (ok, should be with fileseps...)
    params.session_folder = session_folder;
    params.params_file = params_file;
    params.pre_stim_eeg = pre_stim_eeg;
    params.post_dur_stim_eeg = post_dur_stim_eeg;
    
    for file_path = {pre_stim_eeg, post_dur_stim_eeg}
        
        data = read_datafile(); % nested function
        % apply filters XXXXXXXXXXXXX
        data = filtEEG(data);
        
        % // ICA //
        
        % add trialinfo to data and cut out recording in between trials
        data = add_trialstruct(); % nested function
        
        data = remove_trials(data, params);
        data = artifact_rejection_threshold(data, params);                 
%       - trials mit artefakten entfernen          
        
        save_files(session_folder, 'preprocessing')
        
    end

    %% small helper functions for better readability of above code
    
    % read data from .dat-file
    function raw_data = read_datafile()
        cfg = [];
        cfg.dataset = file_path;
        cfg.trialfun = 'trialfun_param_events'; % one trial, all events
        cfg = ft_definetrial(cfg);
        % write_to_log(session_path, ['succesfully read events from ', file_path]);
        
        cfg.continuous = 'yes';
        raw_data = ft_preprocessing(cfg);
        % write_to_log(session_path, ['succesfully read data from ', file_path]);
        
        % set channel names in data
        raw_data.label = {'Fp1','Fp2', ...
                  'F7','F3','Fz','F4','F8', ...
                  'FC5','FC1','FC2','FC6', ...
                  'T7','C3','Cz','C4','T8', ...
                  'TP9', ...
                  'CP5','CP1','CP2','CP6','TP10', ...
                  'P7','P3','Pz','P4','P8', ...
                  'PO9','O1','Oz','O2','PO10', ...
                  'AF7','AF3','AF4','AF8', ...
                  'F5','F1','F2','F6', ...
                  'FT9','FT7','FC3','FC4','FT8','FT10', ...
                  'C5','C1','C2','C6', ...
                  'TP7','CP3','CPz','CP4','TP8', ...
                  'P5','P1','P2','P6', ...
                  'PO7','PO3','POz','PO4','PO8', ...
                  'EOG', ...
                  'APBleft', 'APBright', ...
                  ''};
    end

    function trl_data = add_trialstruct()
        cfg = [];
        cfg.trl = definetrials(data, params);
        trl_data = ft_redefinetrial(cfg, data);
    end
    
end

