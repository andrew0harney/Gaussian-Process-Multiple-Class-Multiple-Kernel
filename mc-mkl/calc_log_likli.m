%Andrew O'Harney
%19/04/2013
%Calculates the log liklihood of y given sigma

function [ log_l ] = calc_log_likli(sigma,y)
    
    log_l = 0;
    for i=1:length(sigma)
        log_l = log_l+log(sigma(i)^y(i));
    end
    
    end
end

