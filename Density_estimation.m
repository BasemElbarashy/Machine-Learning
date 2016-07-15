%% ========================================================================
% In practice, the histogram technique can be useful for obtaining a quick 
% visualization of data in one or two dimensions but is unsuited to most
% density estimation applications.

% Two widely used nonparametric techniques for density estimation, 
% 1)kernel estimators 
% 2)nearest neighbours,
% which have better scaling with dimensionality than the simple histogram model.

%% ========================================================================
%1)kernel estimators (http://www.mathworks.com/help/stats/kernel-distribution.html)
clear;close all;
rng default  % For reproducibility

x = [4*randn(10,1); 20+4*randn(20,1);50+4*randn(50,1)];
hold on
[f,xi] = ksdensity(x,'bandwidth',5,'kernel','normal');
figure(1); subplot(2,1,1)
hist(x,20)

figure(1); subplot(2,1,2)
plot(x,zeros(1,size(x,1)),'*'); hold on
plot(xi,f);

%% ========================================================================
%2)Nearest-neighbour methods: 
% k nearest neighbour is very simple to be implemented
% it just classify the new point to the dominant class of the k nearest
% neighbours but we need to select the best value of k from 3-10 or by
% learning it using cross-validation

