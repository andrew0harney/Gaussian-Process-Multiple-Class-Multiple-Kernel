%Andrew O'Harney
%4/2/2013
%Basic implementation of calculation for PI following Rasmussen's book Gaussian Processes for 
%Machine learning (Section 3.5)

function [ PI ] = create_PI( sigma,num_observations )

    PI = [];
    for i=1:num_observations:length(sigma)
        PI = [PI;diag(sigma(i:i+num_observations-1))];  
    end


end

