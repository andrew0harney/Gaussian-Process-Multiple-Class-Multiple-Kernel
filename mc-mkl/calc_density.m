%Andrew O'Harney
%19/04/2013
%Calculates the log density

function [ l_density ] = calc_density(x,mu,L)

%x - column vector position
%mu - column vector denisty mean
%L - cov matrix

    
    v = L\(x-mu);
    l_density = -sum(log(diag(L)))-(0.5*(v'*v))-(length(x)/2)*log(2*pi);
        
end

