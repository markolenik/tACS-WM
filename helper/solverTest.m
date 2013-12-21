function tests = solverTest
tests = functiontests(localfunctions);
end

function testRealSolution(testCase)
disp('hiiiii');
disp(num2str(testCase.TestData.x));
actSolution = quadraticSolver(1,-3,testCase.TestData.x);
expSolution = [2,1];
verifyEqual(testCase,actSolution,expSolution);
end

function testImaginarySolution(testCase)
actSolution = quadraticSolver(1,2,10);
expSolution = [-1+3i, -1-3i];
verifyEqual(testCase,actSolution,expSolution);
% verifyEqual(testCase,2,2);
end

function setupOnce(testCase)  % do not change function name
testCase.TestData.x = 2;
end