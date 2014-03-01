%Andrew O'Harney
%5/2/2013
%Calculates the covariance structure of input x with parameters p

function K = cov_sqrdExp(x,p)

K = exp(p(1))*exp(-exp(p(2))*dist(x).^2);

end