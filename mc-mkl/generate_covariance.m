%Andrew O'Harney
%19/04/2013
%Calculates the covariance matrix by performing the weighted sum of ks by ws

function [ block_diag_K ] = generate_covariance(ws)
global num_latents
global num_kernels



block_diag_K = [];
for i=1:num_kernels:num_latents*num_kernels
  [c] = generate_kernel(ws(i:i+num_kernels-1));
  block_diag_K = blkdiag(block_diag_K,c);
end


end

