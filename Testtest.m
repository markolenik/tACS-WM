classdef Testtest < matlab.unittest.TestCase
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods (Test)
        function testRealsolution(testCase)
            actSolution = factorial(3);
            expSolution = 6;
            testCase.verifyEqual(actSolution, expSolution, 'AbsTol', sqrt(eps));
        end
        
    end
    
end

