%Andrew O'Harney
%19/04/2013

function [ mu,sig,mi,ma,step,pdf ] = get_density(ws)
	mu = mean(ws);
	sig = std(ws);
	ma = max(ws);
	mi = min(ws);
	step = (ma-mi)/1000;
	pdf = normpdf(mi:step:ma,mu,sig);
end

