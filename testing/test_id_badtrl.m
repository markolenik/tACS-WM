function tests = test_id_badtrl
tests = functiontests(localfunctions);
end

function testRemoveOutliers(testCase)
RT = [50 1:10 22 55];
correct = [1 ones(1,9) 0 1 1];
% threshold =  49.8050;
expSol = unique(sort([find(RT==50), find(RT==55), find(RT==10)]));
actSol = id_badtrl(RT,correct);
verifyEqual(testCase,actSol,expSol);
end

