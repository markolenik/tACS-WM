clear;
% % alex linux
% addpath '/home/arbetten/matlab/fieldtrip-20130901';
% addpath '/home/arbetten/matlab/projects/tACS_stim/helpers';
% % alex windows
addpath 'C:\Users\alex\Dropbox\other_matlab\fieldtrip-20130901';
addpath 'C:\Users\alex\Dropbox\tACS_project_matlab_code\helpers';
ft_defaults;

%% collect all eeg and param paths

% % alex linux
% path_eeg_files = '/home/arbetten/Documents/EEG/';
% path_param_files = '/home/arbetten/Documents/params/';
% % alex windows
path_eeg_files = 'C:\project\EEG\';
path_param_files = 'C:\project\params\';

experiment_sessions = dir(path_eeg_files);
sessions = struct('subject',{},'condition',{},'path_session_eeg',{},'params_file',{});
conditions = {'sham', 'synch', 'desynch'};

for condition = conditions
    condition = char(condition);
    condition_sessions = strfind({experiment_sessions.name},['_',condition]);
    for i = 1:length(condition_sessions)
        if(condition_sessions{i}>1)
            tmp_session = [];
            tmp_session.subject = experiment_sessions(i).name(1:condition_sessions{i}-1);
            tmp_session.condition = condition;
            tmp_session.path_session_eeg = [path_eeg_files,experiment_sessions(i).name];
            tmp_session.event_files = dir([path_session_eeg, strrep(cfg.dataset,'.dat','_event_struct.mat')]);

            if(exist(tmp_session.params_file))
                sessions(end+1) = tmp_session;
            end
        end
    end
end

clear condition conditions condition_sessions i experiment_sessions tmp_session;

%% update central response time collection

% 1:2 ist da nur, um die laufzeit zu verkürzen.. das muss wieder raus
for events_file
        
    % load that file
    load(events_file, 'event');

    collection = [];
    collection.probe_start = [event(find(strcmp('probe', {event.type}))).sample];
    collection.probe_duration = [event(find(strcmp('probe', {event.type}))).duration];
    collection.fixation_duration = [event(find(strcmp('fixation', {event.type}))).duration];
    collection.fixation_duration = fixation_duration(2:end);
    collection.fixation_duration(end+1) = hdr.nSamples - max([event(find(strcmp('fixation', {event.type}))).sample]) - fixation_duration(end);

end

% % als entscheidungshilfe... ich würde eher stdabw. nehmen, sollte reichen
% drawline = probe_duration;
% bottom = mean(drawline)-std(drawline);
% top1 = mean(drawline)+std(drawline);
% top2 = mean(drawline)+min(fixation_duration);
% plot(1:150,drawline,'-k', ...
%     [1,150],repmat(top1,1,2),'-r', ...
%     [1,150],repmat(top2,1,2),'-g', ...
%     [1,150],repmat(mean(drawline),1,2),'-b', ...
%     [1,150],repmat(bottom,1,2),'-r');
%  text(5, top1*0.9, ...
%           [int2str(length(find(and(probe_duration>=bottom, probe_duration<=top1)))), ...
%           ' usable trials'], 'Color', 'red');
%  text(5, top2*0.9, ...
%           [int2str(length(find(and(probe_duration>=bottom, probe_duration<=top2)))), ...
%           ' usable trials'], 'Color', 'green');
%  title('Plot of reaction times');
%  xlabel('Trial');
%  ylabel('Reaction time (in ms)');
%  legend('reaction time', 'thresholds by std.dev.', 'upper threshold by using fixation as buffer', 'Location','SouthOutside');
