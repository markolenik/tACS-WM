function mark_test
% 
% params = importdata('/Users/mark/Documents/Thesis/MATLAB/params/subject_ML_desynch.mat');
% 
% %% 1. load data
% datapre = loadsave('/Users/mark/Documents/theta_tACS/EEG/subject_ML_desynch001/subject_ML_desynchS001R02.dat',...
%     '/Users/Mark/Desktop');
% datapost = loadsave('/Users/mark/Documents/theta_tACS/EEG/subject_ML_desynch001/subject_ML_desynchS001R03.dat',...
%     '/Users/Mark/Desktop');
% 
% %% 2. filter data
% filtDataPre = filtEEG(datapre);
% filtDataPost = filtEEG(datapost);
% 
% %% 3. append data
% data = ft_appenddata([], filtDataPre, filtDataPost);
% 
% % add params to data
% data.params = params;
% 
% 
% %% 4. redefine trials
% data.cfg.trialfun = 'trialfun_marktest';
% data.cfg = ft_redefinetrial(data.cfg, data);
% 
% 

write_to_log('/Users/mark/Dropbox/tacs_project_matlab_code/exampleData/','test successful');