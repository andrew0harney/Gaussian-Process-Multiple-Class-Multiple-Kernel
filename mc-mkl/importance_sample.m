%Andrew O'Harney
%19/04/2013
%Importance sampler


function [ approx_p_y_theta ] = importance_sample(num_samples,theta,modeFindFunc,itr,maxitr,id)
global num_observations
global y

persistent zero_mu
persistent I
persistent chol_I



%Generate approx based on theta
K_theta = generate_covariance(theta);
K_theta = K_theta+eye(228)*1e-7;
chol_K_theta = chol(K_theta,'lower');
[f_hat,L_hat,approx_p_y_theta] = Laplace(K_theta,modeFindFunc);

%if(itr<maxitr)
%    return
%end

%Init persistent if not already done
if isempty(zero_mu)
    zero_mu = zeros([length(f_hat) 1]);
    %I = eye([length(f_hat) length(f_hat)]);
    %chol_I = chol(I,'lower');
end


logs = [];


f_is =bsxfun(@plus,f_hat,L_hat*mvnrnd(zeros(size(f_hat')),eye([length(f_hat') length(f_hat)]),num_samples)');

%Perform importance sampling
for i=1:num_samples

    fi_sigma = calc_sigma(f_is(:,i),num_observations);
    
    l_likli = calc_log_likli(fi_sigma,y); %Log liklihood
    l_prior = calc_density(f_is(:,i),zero_mu,chol_K_theta); %Log prior
    l_marg = calc_density(f_is(:,i),f_hat,L_hat); %Log marginal
    
    logs = [logs,l_likli+l_prior-l_marg];
end
 
approx_p_y_theta = -log(num_samples) + logsumexp(logs);


end
