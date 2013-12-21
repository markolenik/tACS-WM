% Let's test like crazy... looks unnecessary but we're playing safe here
function tests = test_trialfun_param_events
tests = functiontests(localfunctions);
end

function setupOnce(testCase)  % do not change function name
defaults = m_defaults;
%NOTE: you can't run a script in a testfile...
%NOTE: no global variables unfortunately

fsample = 1000;
testCase.TestData.y = 2;
[paramsPath, ~, preStimPath, postStimPath,...
    ~, ~] = init_session(defaults.sessionPath);
load(paramsPath);

dataPre = read_datafile(preStimPath,params);
dataPost = read_datafile(postStimPath,params);

% manually calculate expected sample
% if this function is wrong, then the trialfun will be as well ...
f = @(timeStamp,eegEnd,prmsEnd,fsample)(floor(timeStamp*fsample + (eegEnd - prmsEnd*fsample)));

% data to save
testCase.TestData.dataPre = dataPre;
testCase.TestData.dataPost = dataPost;
testCase.TestData.fsample = fsample;
testCase.TestData.prms = params;
testCase.TestData.f = f;
end

%% TEST PRE STIM RECORD

% Test events of first trial of pre stim record
function testPreStimStartEvent(testCase)
% load data from setup
dataPre = testCase.TestData.dataPre;
fsample = testCase.TestData.fsample;
prms = testCase.TestData.prms;
f = testCase.TestData.f;
% trial to test
trialnum = 1;

% Test Fixation
event = 'fixation';
% find all events in data
eventsample = find(strcmp({dataPre.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Fixation.Start,dataPre.hdr.nSamples,...
    prms.TimeStamps.TaskPreStim.End,fsample);
actSolution = dataPre.cfg.event(eventsample(trialnum)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Sample1
event = 'sample1';
% find all events in data
eventsample = find(strcmp({dataPre.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Sample(1).Start,dataPre.hdr.nSamples,...
    prms.TimeStamps.TaskPreStim.End,fsample);
actSolution = dataPre.cfg.event(eventsample(trialnum)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Sample2
event = 'sample2';
% find all events in data
eventsample = find(strcmp({dataPre.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Sample(2).Start,dataPre.hdr.nSamples,...
    prms.TimeStamps.TaskPreStim.End,fsample);
actSolution = dataPre.cfg.event(eventsample(trialnum)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Sample3
event = 'sample3';
% find all events in data
eventsample = find(strcmp({dataPre.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Sample(3).Start,dataPre.hdr.nSamples,...
    prms.TimeStamps.TaskPreStim.End,fsample);
actSolution = dataPre.cfg.event(eventsample(trialnum)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Mask1
event = 'mask1';
% find all events in data
eventsample = find(strcmp({dataPre.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Mask(1).Start,dataPre.hdr.nSamples,...
    prms.TimeStamps.TaskPreStim.End,fsample);
actSolution = dataPre.cfg.event(eventsample(trialnum)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Mask2
event = 'mask2';
% find all events in data
eventsample = find(strcmp({dataPre.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Mask(2).Start,dataPre.hdr.nSamples,...
    prms.TimeStamps.TaskPreStim.End,fsample);
actSolution = dataPre.cfg.event(eventsample(trialnum)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Mask3
event = 'mask3';
% find all events in data
eventsample = find(strcmp({dataPre.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Mask(3).Start,dataPre.hdr.nSamples,...
    prms.TimeStamps.TaskPreStim.End,fsample);
actSolution = dataPre.cfg.event(eventsample(trialnum)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Cue
event = 'cue';
% find all events in data
eventsample = find(strcmp({dataPre.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Cue.Start,dataPre.hdr.nSamples,...
    prms.TimeStamps.TaskPreStim.End,fsample);
actSolution = dataPre.cfg.event(eventsample(trialnum)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Probe
event = 'probe';
% find all events in data
eventsample = find(strcmp({dataPre.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Probe.Start,dataPre.hdr.nSamples,...
    prms.TimeStamps.TaskPreStim.End,fsample);
actSolution = dataPre.cfg.event(eventsample(trialnum)).sample;
verifyEqual(testCase,actSolution,expSolution);

end

% Test events of some middle trial of pre stim record
function testPreStimMiddleEvent(testCase)
% load data from setup
dataPre = testCase.TestData.dataPre;
fsample = testCase.TestData.fsample;
prms = testCase.TestData.prms;
f = testCase.TestData.f;
% trial to test
trialnum = 30;

% Test Fixation
event = 'fixation';
% find all events in data
eventsample = find(strcmp({dataPre.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Fixation.Start,dataPre.hdr.nSamples,...
    prms.TimeStamps.TaskPreStim.End,fsample);
actSolution = dataPre.cfg.event(eventsample(trialnum)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Sample1
event = 'sample1';
% find all events in data
eventsample = find(strcmp({dataPre.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Sample(1).Start,dataPre.hdr.nSamples,...
    prms.TimeStamps.TaskPreStim.End,fsample);
actSolution = dataPre.cfg.event(eventsample(trialnum)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Sample2
event = 'sample2';
% find all events in data
eventsample = find(strcmp({dataPre.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Sample(2).Start,dataPre.hdr.nSamples,...
    prms.TimeStamps.TaskPreStim.End,fsample);
actSolution = dataPre.cfg.event(eventsample(trialnum)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Sample3
event = 'sample3';
% find all events in data
eventsample = find(strcmp({dataPre.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Sample(3).Start,dataPre.hdr.nSamples,...
    prms.TimeStamps.TaskPreStim.End,fsample);
actSolution = dataPre.cfg.event(eventsample(trialnum)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Mask1
event = 'mask1';
% find all events in data
eventsample = find(strcmp({dataPre.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Mask(1).Start,dataPre.hdr.nSamples,...
    prms.TimeStamps.TaskPreStim.End,fsample);
actSolution = dataPre.cfg.event(eventsample(trialnum)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Mask2
event = 'mask2';
% find all events in data
eventsample = find(strcmp({dataPre.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Mask(2).Start,dataPre.hdr.nSamples,...
    prms.TimeStamps.TaskPreStim.End,fsample);
actSolution = dataPre.cfg.event(eventsample(trialnum)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Mask3
event = 'mask3';
% find all events in data
eventsample = find(strcmp({dataPre.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Mask(3).Start,dataPre.hdr.nSamples,...
    prms.TimeStamps.TaskPreStim.End,fsample);
actSolution = dataPre.cfg.event(eventsample(trialnum)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Cue
event = 'cue';
% find all events in data
eventsample = find(strcmp({dataPre.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Cue.Start,dataPre.hdr.nSamples,...
    prms.TimeStamps.TaskPreStim.End,fsample);
actSolution = dataPre.cfg.event(eventsample(trialnum)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Probe
event = 'probe';
% find all events in data
eventsample = find(strcmp({dataPre.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Probe.Start,dataPre.hdr.nSamples,...
    prms.TimeStamps.TaskPreStim.End,fsample);
actSolution = dataPre.cfg.event(eventsample(trialnum)).sample;
verifyEqual(testCase,actSolution,expSolution);
end

% Test events at the end of pre stim record
function testPresStimEndEvent(testCase)
% load data from setup
dataPre = testCase.TestData.dataPre;
fsample = testCase.TestData.fsample;
prms = testCase.TestData.prms;
f = testCase.TestData.f;
% trial to test
trialnum = 50;

% Test Fixation
event = 'fixation';
% find all events in data
eventsample = find(strcmp({dataPre.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Fixation.Start,dataPre.hdr.nSamples,...
    prms.TimeStamps.TaskPreStim.End,fsample);
actSolution = dataPre.cfg.event(eventsample(trialnum)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Sample1
event = 'sample1';
% find all events in data
eventsample = find(strcmp({dataPre.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Sample(1).Start,dataPre.hdr.nSamples,...
    prms.TimeStamps.TaskPreStim.End,fsample);
actSolution = dataPre.cfg.event(eventsample(trialnum)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Sample2
event = 'sample2';
% find all events in data
eventsample = find(strcmp({dataPre.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Sample(2).Start,dataPre.hdr.nSamples,...
    prms.TimeStamps.TaskPreStim.End,fsample);
actSolution = dataPre.cfg.event(eventsample(trialnum)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Sample3
event = 'sample3';
% find all events in data
eventsample = find(strcmp({dataPre.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Sample(3).Start,dataPre.hdr.nSamples,...
    prms.TimeStamps.TaskPreStim.End,fsample);
actSolution = dataPre.cfg.event(eventsample(trialnum)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Mask1
event = 'mask1';
% find all events in data
eventsample = find(strcmp({dataPre.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Mask(1).Start,dataPre.hdr.nSamples,...
    prms.TimeStamps.TaskPreStim.End,fsample);
actSolution = dataPre.cfg.event(eventsample(trialnum)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Mask2
event = 'mask2';
% find all events in data
eventsample = find(strcmp({dataPre.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Mask(2).Start,dataPre.hdr.nSamples,...
    prms.TimeStamps.TaskPreStim.End,fsample);
actSolution = dataPre.cfg.event(eventsample(trialnum)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Mask3
event = 'mask3';
% find all events in data
eventsample = find(strcmp({dataPre.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Mask(3).Start,dataPre.hdr.nSamples,...
    prms.TimeStamps.TaskPreStim.End,fsample);
actSolution = dataPre.cfg.event(eventsample(trialnum)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Cue
event = 'cue';
% find all events in data
eventsample = find(strcmp({dataPre.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Cue.Start,dataPre.hdr.nSamples,...
    prms.TimeStamps.TaskPreStim.End,fsample);
actSolution = dataPre.cfg.event(eventsample(trialnum)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Probe
event = 'probe';
% find all events in data
eventsample = find(strcmp({dataPre.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Probe.Start,dataPre.hdr.nSamples,...
    prms.TimeStamps.TaskPreStim.End,fsample);
actSolution = dataPre.cfg.event(eventsample(trialnum)).sample;
verifyEqual(testCase,actSolution,expSolution);
end

%% TEST POST STIM RECORD
% Test events of first trial of Post stim record
function testPostStimStartEvent(testCase)
% load data from setup
dataPost = testCase.TestData.dataPost;
fsample = testCase.TestData.fsample;
prms = testCase.TestData.prms;
f = testCase.TestData.f;
% trial to test
trialnum = 51;

% Test Fixation
event = 'fixation';
% find all events in data
eventsample = find(strcmp({dataPost.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Fixation.Start,dataPost.hdr.nSamples,...
    prms.TimeStamps.TaskPostStim.End,fsample);
% we're subsracting 50 from trialnum since postStim first trial is trial
% 51 in params
actSolution = dataPost.cfg.event(eventsample(trialnum-50)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Sample1
event = 'sample1';
% find all events in data
eventsample = find(strcmp({dataPost.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Sample(1).Start,dataPost.hdr.nSamples,...
    prms.TimeStamps.TaskPostStim.End,fsample);
actSolution = dataPost.cfg.event(eventsample(trialnum-50)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Sample2
event = 'sample2';
% find all events in data
eventsample = find(strcmp({dataPost.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Sample(2).Start,dataPost.hdr.nSamples,...
    prms.TimeStamps.TaskPostStim.End,fsample);
actSolution = dataPost.cfg.event(eventsample(trialnum-50)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Sample3
event = 'sample3';
% find all events in data
eventsample = find(strcmp({dataPost.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Sample(3).Start,dataPost.hdr.nSamples,...
    prms.TimeStamps.TaskPostStim.End,fsample);
actSolution = dataPost.cfg.event(eventsample(trialnum-50)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Mask1
event = 'mask1';
% find all events in data
eventsample = find(strcmp({dataPost.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Mask(1).Start,dataPost.hdr.nSamples,...
    prms.TimeStamps.TaskPostStim.End,fsample);
actSolution = dataPost.cfg.event(eventsample(trialnum-50)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Mask2
event = 'mask2';
% find all events in data
eventsample = find(strcmp({dataPost.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Mask(2).Start,dataPost.hdr.nSamples,...
    prms.TimeStamps.TaskPostStim.End,fsample);
actSolution = dataPost.cfg.event(eventsample(trialnum-50)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Mask3
event = 'mask3';
% find all events in data
eventsample = find(strcmp({dataPost.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Mask(3).Start,dataPost.hdr.nSamples,...
    prms.TimeStamps.TaskPostStim.End,fsample);
actSolution = dataPost.cfg.event(eventsample(trialnum-50)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Cue
event = 'cue';
% find all events in data
eventsample = find(strcmp({dataPost.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Cue.Start,dataPost.hdr.nSamples,...
    prms.TimeStamps.TaskPostStim.End,fsample);
actSolution = dataPost.cfg.event(eventsample(trialnum-50)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Probe
event = 'probe';
% find all events in data
eventsample = find(strcmp({dataPost.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Probe.Start,dataPost.hdr.nSamples,...
    prms.TimeStamps.TaskPostStim.End,fsample);
actSolution = dataPost.cfg.event(eventsample(trialnum-50)).sample;
verifyEqual(testCase,actSolution,expSolution);

end

% Test events of some middle trial of Post stim record
function testPostStimMiddleEvent(testCase)
% load data from setup
dataPost = testCase.TestData.dataPost;
fsample = testCase.TestData.fsample;
prms = testCase.TestData.prms;
f = testCase.TestData.f;
% trial to test
trialnum = 150;

% Test Fixation
event = 'fixation';
% find all events in data
eventsample = find(strcmp({dataPost.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Fixation.Start,dataPost.hdr.nSamples,...
    prms.TimeStamps.TaskPostStim.End,fsample);
actSolution = dataPost.cfg.event(eventsample(trialnum-50)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Sample1
event = 'sample1';
% find all events in data
eventsample = find(strcmp({dataPost.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Sample(1).Start,dataPost.hdr.nSamples,...
    prms.TimeStamps.TaskPostStim.End,fsample);
actSolution = dataPost.cfg.event(eventsample(trialnum-50)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Sample2
event = 'sample2';
% find all events in data
eventsample = find(strcmp({dataPost.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Sample(2).Start,dataPost.hdr.nSamples,...
    prms.TimeStamps.TaskPostStim.End,fsample);
actSolution = dataPost.cfg.event(eventsample(trialnum-50)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Sample3
event = 'sample3';
% find all events in data
eventsample = find(strcmp({dataPost.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Sample(3).Start,dataPost.hdr.nSamples,...
    prms.TimeStamps.TaskPostStim.End,fsample);
actSolution = dataPost.cfg.event(eventsample(trialnum-50)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Mask1
event = 'mask1';
% find all events in data
eventsample = find(strcmp({dataPost.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Mask(1).Start,dataPost.hdr.nSamples,...
    prms.TimeStamps.TaskPostStim.End,fsample);
actSolution = dataPost.cfg.event(eventsample(trialnum-50)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Mask2
event = 'mask2';
% find all events in data
eventsample = find(strcmp({dataPost.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Mask(2).Start,dataPost.hdr.nSamples,...
    prms.TimeStamps.TaskPostStim.End,fsample);
actSolution = dataPost.cfg.event(eventsample(trialnum-50)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Mask3
event = 'mask3';
% find all events in data
eventsample = find(strcmp({dataPost.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Mask(3).Start,dataPost.hdr.nSamples,...
    prms.TimeStamps.TaskPostStim.End,fsample);
actSolution = dataPost.cfg.event(eventsample(trialnum-50)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Cue
event = 'cue';
% find all events in data
eventsample = find(strcmp({dataPost.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Cue.Start,dataPost.hdr.nSamples,...
    prms.TimeStamps.TaskPostStim.End,fsample);
actSolution = dataPost.cfg.event(eventsample(trialnum-50)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Probe
event = 'probe';
% find all events in data
eventsample = find(strcmp({dataPost.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Probe.Start,dataPost.hdr.nSamples,...
    prms.TimeStamps.TaskPostStim.End,fsample);
actSolution = dataPost.cfg.event(eventsample(trialnum-50)).sample;
verifyEqual(testCase,actSolution,expSolution);
end

% Test events at the end of Post stim record
function testPostsStimEndEvent(testCase)
% load data from setup
dataPost = testCase.TestData.dataPost;
fsample = testCase.TestData.fsample;
prms = testCase.TestData.prms;
f = testCase.TestData.f;
% trial to test
trialnum = 200;

% Test Fixation
event = 'fixation';
% find all events in data
eventsample = find(strcmp({dataPost.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Fixation.Start,dataPost.hdr.nSamples,...
    prms.TimeStamps.TaskPostStim.End,fsample);
actSolution = dataPost.cfg.event(eventsample(trialnum-50)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Sample1
event = 'sample1';
% find all events in data
eventsample = find(strcmp({dataPost.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Sample(1).Start,dataPost.hdr.nSamples,...
    prms.TimeStamps.TaskPostStim.End,fsample);
actSolution = dataPost.cfg.event(eventsample(trialnum-50)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Sample2
event = 'sample2';
% find all events in data
eventsample = find(strcmp({dataPost.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Sample(2).Start,dataPost.hdr.nSamples,...
    prms.TimeStamps.TaskPostStim.End,fsample);
actSolution = dataPost.cfg.event(eventsample(trialnum-50)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Sample3
event = 'sample3';
% find all events in data
eventsample = find(strcmp({dataPost.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Sample(3).Start,dataPost.hdr.nSamples,...
    prms.TimeStamps.TaskPostStim.End,fsample);
actSolution = dataPost.cfg.event(eventsample(trialnum-50)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Mask1
event = 'mask1';
% find all events in data
eventsample = find(strcmp({dataPost.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Mask(1).Start,dataPost.hdr.nSamples,...
    prms.TimeStamps.TaskPostStim.End,fsample);
actSolution = dataPost.cfg.event(eventsample(trialnum-50)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Mask2
event = 'mask2';
% find all events in data
eventsample = find(strcmp({dataPost.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Mask(2).Start,dataPost.hdr.nSamples,...
    prms.TimeStamps.TaskPostStim.End,fsample);
actSolution = dataPost.cfg.event(eventsample(trialnum-50)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Mask3
event = 'mask3';
% find all events in data
eventsample = find(strcmp({dataPost.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Mask(3).Start,dataPost.hdr.nSamples,...
    prms.TimeStamps.TaskPostStim.End,fsample);
actSolution = dataPost.cfg.event(eventsample(trialnum-50)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Cue
event = 'cue';
% find all events in data
eventsample = find(strcmp({dataPost.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Cue.Start,dataPost.hdr.nSamples,...
    prms.TimeStamps.TaskPostStim.End,fsample);
actSolution = dataPost.cfg.event(eventsample(trialnum-50)).sample;
verifyEqual(testCase,actSolution,expSolution);

% Test Probe
event = 'probe';
% find all events in data
eventsample = find(strcmp({dataPost.cfg.event.type},event));
% manually calculate expected sample
expSolution = f(prms.Task.Trial(trialnum).Timing.Probe.Start,dataPost.hdr.nSamples,...
    prms.TimeStamps.TaskPostStim.End,fsample);
actSolution = dataPost.cfg.event(eventsample(trialnum-50)).sample;
verifyEqual(testCase,actSolution,expSolution);
end