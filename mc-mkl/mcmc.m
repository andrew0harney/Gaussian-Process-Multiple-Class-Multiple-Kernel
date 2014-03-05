%Andrew O'Harney
%19/04/2013
%Implementation of MH sampler with adaptive (burn in)

function [trace] = mcmc(num_samples,nadaptive,graphical,printJump,densityFunc,proposalDensityFunc,theta,id)

global num_kernels
global num_latents
global num_observations
global testName
global cv_num

%Initial setup
doAdaptive = nadaptive>0;
alpha = 1; %Parameter to be tuned
num_importance_samples = num_observations*num_latents;
itr = 0;
trace = [];
accept_cnt = 0;

I = eye([num_latents*num_kernels num_latents*num_kernels]);
proposal_sig = chol(alpha*I,'lower');

l_current_density = proposalDensityFunc(num_importance_samples,theta,1,nadaptive)+densityFunc(theta);

if(graphical)
    progbar = waitbar(0,'Performing MCMC');
end

goodAlpha = ~doAdaptive;

tic

%num_samples - Number of iterations in the MCMC
for i=1:num_samples
 
    if(graphical)
        waitbar(i/num_samples,progbar,sprintf('Performing MCMC %d/%d',i,num_samples));
    end
    
    itr = itr+1;
    
    %Add theta to trace
    trace = [trace;theta'];
    
    
    %Calculate ratio based on theta'
    theta_n = draw_sample(theta',proposal_sig); %Generate proposal
    l_proposal_density = proposalDensityFunc(num_importance_samples,theta_n,i,nadaptive)+densityFunc(theta_n);
    a=min(1,exp(l_proposal_density-l_current_density));
    
    %Accept/reject new sample
    u = rand(1);
    if(a>u)
        theta = theta_n;
        l_current_density = l_proposal_density;
        accept_cnt = accept_cnt + 1;
    end
    
    %Increase/decrease variance parameter based on acceptance ratio for
    %last 100 samples
    if(mod(i,100)==0 && i<=nadaptive && ~goodAlpha && doAdaptive)
                
        if(accept_cnt<20)
            alpha = alpha/1.1; %Variance is too large so decrease (sampling too far away from current position)
            fprintf(sprintf('Acceptance :%d - Decreasing variance\n',accept_cnt));
            
        elseif(accept_cnt>30)
            alpha = alpha*1.1; %Variance is too small so increase (sampling too close to current position)
            fprintf(sprintf('Acceptance :%d - Increasing variance\n',accept_cnt));
            
        elseif(~goodAlpha)
            fprintf(sprintf('Found Good Alpha : %f, with acceptance %d\n',alpha,accept_cnt))
            goodAlpha = true;
        end
        
        proposal_sig = chol(alpha*I,'lower');
        accept_cnt = 0;
    end
    
    if(doAdaptive && i>nadaptive)
        assert(goodAlpha)
    end
    
    if(mod(i,printJump)==0)
        fprintf(sprintf('Itr @%d\n',i));
    end
    
   
end
toc

try
    dlmwrite(sprintf('results/%s/%d_%d_trace',testName,cv_num,id),trace); %Output trace to file
catch
    try
         pause(rand()*100)
        dlmwrite(sprintf('results/%s/%d_%d_trace',testName,cv_num,id),trace); %Output trace to file
    end
end

if(graphical)
    close(progbar)
end
end
