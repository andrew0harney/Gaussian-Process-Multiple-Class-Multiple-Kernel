%Andrew O'Harney
%5/2/2013
%Draws a random sample from the Gaussian N(mu,sigma)

function [ x ] = draw_sample( mu,L)   
%mu - row vector mean
%sigma - cov matrix
v= mvnrnd(zeros(size(mu)),eye([length(mu) length(mu)]));
x=L*v' + mu';

end