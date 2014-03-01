%Andrew O'Harney
%5/12/2013
%Evaluates the log density of the multivariate Gaussian N(position|mu,cov)
%at position 

function [ ld ] = calc_prior(position,mu,cov)

    ld = calc_density(position,mu,cov);

end

