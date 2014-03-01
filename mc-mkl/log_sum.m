%Andrew O'Harney
%19/04/2013
%Calculates the log-sum-exp in a numerically stable way
function [ log_sum ] = log_sum(xs)

xs_max = max(xs);
log_sum = xs_max + log(sum(exp(xs-xs_max)));

end

