%Andrew O'Harney
%19/04/2013
%Uses a sparse covariance matrix (all off-diagnoals are disregarded)

function [L] = sparseCovModeFind(K,E,R,sumEc,PI)

	W = diag(sigma)-diag(diag(PI*PI'));
	L = chol(inv(inv(K)+W),'lower');

end
