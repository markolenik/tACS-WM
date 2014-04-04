function to_remove = id_badtrl(RT, correct)
%REMOVE_TRIALSRT Identify outliers and trials with wrong answer.
%
% SYNOPSIS
%   to_remove = id_badtrl(RT, correct)
%
% INPUT
%   (vector) RT:  vector with RTs for each trial
%   (vector) correct = vector with type of answer (correct-1/incorrect-0)
%
% OUTPUT
%   (vecotr) to_remove: vector containing trials to be removed
%

%% Check for input dimension
[n, m] =size(RT);
if(m>n)
    RT = RT';
end

[n, m] =size(correct);
if(m>n)
    correct = correct';
end

%%

rt_threshold = mean(RT) + std(RT)*2; % reaction time threshold for outlier

% remove trials if exclusion criteria is met
wrongAnswer = find(correct == 0);
longRT = find(RT > rt_threshold);
to_remove = unique(sort([wrongAnswer' longRT']));

end

