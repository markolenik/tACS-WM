function tests = test_is_stimtrial
tests = functiontests(localfunctions);
end

% trivial testCase
function testCase1(testCase)
dat = importdata(['testing' filesep 'is_stimtrial_testdata1.mat']);
act = double(cell2mat(cellfun(@is_stimtrial,dat,'UniformOutput',0)));
exp = [ones(1,100), zeros(1,49)];
verifyEqual(testCase,act,exp);
end

% complex testCase
function testCase2(testCase)
dat = importdata(['testing' filesep 'is_stimtrial_testdata2.mat']);
act = double(cell2mat(cellfun(@is_stimtrial,dat,'UniformOutput',0)));
exp = [zeros(1,7), ones(1,78) zeros(1,149-85)];
verifyEqual(testCase,act,exp);
end

% another trivial testCase for preStim
function testCase3(testCase)
dat = importdata(['testing' filesep 'is_stimtrial_testdata3.mat']);
act = double(cell2mat(cellfun(@is_stimtrial,dat,'UniformOutput',0)));
exp = [zeros(1,49)];
verifyEqual(testCase,act,exp);
end

% one last complex testCase
function testCase4(testCase)
dat = importdata(['testing' filesep 'is_stimtrial_testdata4.mat']);
act = double(cell2mat(cellfun(@is_stimtrial,dat,'UniformOutput',0)));
exp = [ones(1,93), zeros(1,149-93)];
verifyEqual(testCase,act,exp);
end

