%Andrew O'Harney
%19/04/2013
%Calculates a kernel with weights ws

function [c] = generate_kernel(ws)
  global ks
  global num_observations
  global num_kernels
  
  c = zeros([num_observations num_observations]);
  i = 1;
  %Create new covariance based on sum K_i*w_i
  for j=1:num_observations:num_observations*num_kernels
    c=c+ks(j:j+num_observations-1,:)*exp(ws(i));
    i = i+1;
  end


end

