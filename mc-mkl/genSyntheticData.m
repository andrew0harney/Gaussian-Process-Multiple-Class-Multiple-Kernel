%Andrew O'Harney
%19/04/2013
%Generates the data for the synthetic experiment

global num_observations;
global num_latents;
global num_kernels;
global ks
global jitter

num_observations = 1000;
num_latents = 3;
num_kernels = 2;
jitter = 1e-4; %Needed to maintain matrix stability

%Generate Data
fprintf('\nGenerating random data\n')
x = importdata('data/synthetic/full_data/x');

%Create kernels in use
ks = []; %Set of kernels in use

%Produce kernels with varying properties

%1st Kernel
 p = [log(2) log(40)];
 K = cov_sqrdExp(x,p);
 k1 = K + (jitter)*eye(size(K));
 ks=[ks;k1];

%2nd kernel with larger length scale
p = [log(2) log(100)];
K = cov_sqrdExp(x,p);
k2 = K + (jitter)*eye(size(K));
ks=[ks;k2];

%Generate random kernel weights and create covariance
zero_mu = zeros([1 num_latents*num_kernels]);
I = eye([num_latents*num_kernels num_latents*num_kernels]);
chol_I = chol(I,'lower');

%theta = draw_sample(zero_mu,chol_I);
theta = log([0.9 0.1 0.2 0.8 0.5 0.5]);
c = generate_covariance(theta);
L = chol(c,'lower');

%Generate f by sampling covariance
fprintf('\nGenerating latent variables\n')
f = draw_sample(zeros([1 num_observations*num_latents]),L);

hold on
plot(x,f(1:num_observations),'r.');
plot(x,f((num_observations+1):(2*num_observations)),'b.');
plot(x,f((2*num_observations+1):(3*num_observations)),'g.');

% Generate y
sigma = calc_sigma(f,num_observations);
assert(int64(sum(sigma))==num_observations,'Probabilities do not sum to 1')

% Generate Observations
y=[];
for i=1:num_observations
    y_n = mnrnd(1,sigma(max(1,mod(1,num_observations)):num_observations:length(sigma)));
    assert(sum(y_n)==1);
    y = [y;y_n];
    
end

 
% Print class distribution
for i=1:num_latents
    fprintf('Num class %d:%d\n',i,sum(y(:,i)));
end
% 
dlmwrite('data/synthetic/k1',k1);
dlmwrite('data/synthetic/k2',k2);
dlmwrite('data/synthetic/ks',ks);
dlmwrite('data/synthetic/y',y);
dlmwrite('data/synthetic/theta',theta);

