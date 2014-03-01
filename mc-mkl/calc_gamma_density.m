%Andrew O'Harney
%19/04/2013
%Calculates the log Gamma(a,b) density

function [l_density] = calc_gamma_density(theta,a,b)
 l_density = sum(a*theta - b*exp(theta));
end
