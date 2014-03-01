%Andrew O'Harney
%19/04/2013
%Uses the full covariance for the Laplace approximation

function [L] = fullCovModeFind(K,E,R,sumEc,PI)

L = chol(K-K*(E-E*R/sumEc*R'*E)*K,'lower');

end
