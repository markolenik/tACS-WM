% script to copy all param files from params folder to session folder of
% each subject

ID_list = {'AF','AG','ArG','AT','BL','CN','CR','CS','DZ','FG','ML','NP','SG','SP','VS','YM'};

cd '/Volumes/Transcend/ThesisData/MATLABpsychtoolbox/params/';

sessionFolder = '/Volumes/Transcend/ThesisData/EEG/';

for j = 1:length(ID_list)
    subjectID = 'SP';%ID_list{j};
    subjectParams = dir(['subject_' subjectID '*']);
    subjectParams = {subjectParams.name};
    for i = 1:length(subjectParams)
        destfolder = [sessionFolder subjectParams{i}(1:(findstr('.mat',subjectParams{i})-1)) '001'];
        [status, message] = copyfile(subjectParams{i}, destfolder);
        if ~status
            fprintf(['Error in ' subjectParams{i}]);
        end
    end
end