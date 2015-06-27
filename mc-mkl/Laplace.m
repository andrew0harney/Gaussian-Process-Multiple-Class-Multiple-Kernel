%Andrew O'Harney
%4/2/2013
%Basic implementation of the multi-class Laplace function for mode finding following
%Rasmussen's book Gaussian Processes for Machine learning (Section 3.5)

function [f_estimate,L,pytheta] = Laplace(K,modeFindFunc)
global num_observations
global y

% K - Cov Matrix
% y - Training output
% num_observations - the number of observations


f_estimate = zeros([1 length(K)])'; %Initial guess of f
max_itr = 20; %Maximum number of iterations allowed in Newton-Raphson
max_error = 1e-4; %Tolerence in successive estimates
%wb = waitbar(1/max_itr,'Performing Laplace');

onceMore = false;

for itr=1:max_itr
    
    sigma = calc_sigma(f_estimate,num_observations);
    PI = create_PI(sigma,num_observations);
    
    E = [];
    M = zeros(num_observations,num_observations);
    zc = 0;
    
    for i=1:num_observations:length(K)
        
        D = diag(sigma(i:i+num_observations-1))+1e-9;
        Kc = K(i:i+num_observations-1,i:i+num_observations-1);
        try
            L = chol(eye([num_observations num_observations])+(D^0.5)*Kc*(D^0.5),'lower');
        catch
            L;
        end
        Ec = (D^0.5)*(L'\(L\(D^0.5)));
        E=blkdiag(E,Ec);
        M = M + Ec;
        zc = zc+sum(diag(L));
    end
    
    M=chol(M,'lower');
    D=diag(sigma);
    
    b=(diag(sigma)-PI*PI')*f_estimate+y-sigma;
    c=E*K*b;
    R=D\PI;
    a=b-c+E*R*(M'\(M\(R'*c)));
    
    if onceMore
        break;
    end
    
    f_new=K*a;
    
    error = sum((f_new-f_estimate).^2);
    if error <= max_error
        onceMore = true;
    end
    
    f_estimate = f_new;

    
end

assert(itr<=max_itr,'Laplace approx did not converge');

sumEc = M*M';
L = modeFindFunc(K,E,R,sumEc,PI);

pytheta = 0.5*a'*f_estimate+y'*f_estimate+logsumexp(f_estimate)-zc;

end
