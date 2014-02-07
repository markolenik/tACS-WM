% Main function to generate tests

%% TEST TIMING OF SHIFTED EVENTS: PRE_STIM

trialnum = 50;
% expected sample should be
prmsTimeStamp = params.Task.Trial(trialnum).Timing.Probe.Start;
% the sample on the EEG timescale
expSolution = adjustTime(prmsTimeStamp,dataPre.cfg);
actSolution = dataPre.cfg.event(end).sample;
disp(['expSolution: ' num2str(expSolution)]);
disp(['actSolution: ' num2str(actSolution)]);

%% TEST TIMING OF SHIFTED EVENTS: POST_STIM

trialnum = 200;
% expected sample should be
pause = params.Task.Trial(51).Timing.Fixation.Start;
prmslength = (params.TimeStamps.Experiment.End - pause);
moveBy = dataPost.hdr.nSamples - prmslength*fsample;

prmsTimeStamp = params.Task.Trial(trialnum).Timing.Probe.Start - pause;
expSolution = floor(prmsTimeStamp*fsample + moveBy);

actSolution = dataPost.cfg.event(end).sample;
disp(['expSolution: ' num2str(expSolution)]);
disp(['actSolution: ' num2str(actSolution)]);


%% TEST SEVERAL EVENTS
trialnum = 188; % means its trial 138 of record postStim
eventsample = find(strcmp({dataPost.cfg.event.type},'probe'));
% expected sample should be
pause = params.Task.Trial(51).Timing.Fixation.Start;
prmslength = (params.TimeStamps.Experiment.End - pause);
moveBy = dataPost.hdr.nSamples - prmslength*fsample;

prmsTimeStamp = params.Task.Trial(trialnum).Timing.Probe.Start - pause;
expSolution = floor(prmsTimeStamp*fsample + moveBy);

actSolution = dataPost.cfg.event(eventsample(138)).sample;
disp(['expSolution: ' num2str(expSolution)]);
disp(['actSolution: ' num2str(actSolution)]);

%% MORE EVENTS
trialnum = 51; % means its trial 1 of record postStim
eventsample = find(strcmp({dataPost.cfg.event.type},'fixation'));
% expected sample should be
pause = params.Task.Trial(51).Timing.Fixation.Start;
prmslength = (params.TimeStamps.Experiment.End - pause);
moveBy = dataPost.hdr.nSamples - prmslength*fsample;

prmsTimeStamp = params.Task.Trial(trialnum).Timing.Fixation.Start - pause;
expSolution = floor(prmsTimeStamp*fsample + moveBy);

actSolution = dataPost.cfg.event(eventsample(1)).sample;
disp(['expSolution: ' num2str(expSolution)]);
disp(['actSolution: ' num2str(actSolution)]);

% OK SEEMS TO WORK

