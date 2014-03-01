function [ sigma ] = calc_sigma(f,num_observations)

[a b]=size(f);
assert(b==1);

sigma = zeros(size(f));

for i=1:length(sigma)
    y_i = f(i);
    
    f_i = f(mod(i-1,num_observations)+1:num_observations:length(sigma));
    %sigma(i) = exp(f(i))/sum(exp(f_i));
    sigma(i) = exp(f(i)-logsumexp(f_i));
end


end

