%% ========= constructing the experiment "cocktail party problem." ========
% MIT Press, September 2004. [modified by me]
% Copyright: 2005, JV Stone, Psychology Department, Sheffield University, Sheffield, England.    
% Basic Bell-Sejnowski ICA algorithm demonstrated on 2 speech signals.
%--------------------------------------------------------------------------
clear;close all;clc;
% [2] M = number of source signals and signal mixtures.
M = 2; 		
% [1e4] N = number of data points per signal.
N = 1e4;
% Load standard matlab sounds (from MatLab's datafun directory) 
load chirp; s1=y(1:N); s1=s1/std(s1);
load gong;  s2=y(1:N); s2=s2/std(s2);
% Combine sources into vector variable s.
s=[s1,s2];

% Make new mixing matrix.
A=randn(M,M);
% Listen to speech signals ...
% [10000] Fs Sample rate of speech.
Fs=10000;
fprintf('\nlisten to sources [press Enter]\n');
soundsc(s(:,1),Fs); pause;
soundsc(s(:,2),Fs); pause;
% Plot each source signal
figure(1); 
subplot(3,2,1); plot(1:length(s(:,1)),s(:,1));   title('1st source');
subplot(3,2,2); plot(1:length(s(:,2)),s(:,2));   title('2nd source');
% Make M mixures x from M source signals s.
x = s*A;
% Listen to signal mixtures signals ...
fprintf('\nlisten to mics i/p [press Enter]\n');
soundsc(x(:,1),Fs); pause;
soundsc(x(:,2),Fs); pause;
subplot(3,2,3); plot(1:length(x(:,1)),x(:,1));   title('mic 1');
subplot(3,2,4); plot(1:length(x(:,2)),x(:,2));   title('mic 2');
%% ========================= applying ICA =================================
W = eye(M,M);   % Initialise unmixing matrix W to identity matrix.
anneal = [0.5 0.5 0.5 0.2 0.2 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.05  ...
0.05 0.02 0.01 0.01 0.005 0.002 0.001 0.001];
maxiter=length(anneal);
% Begin gradient ascent
fprintf('\nBegin gradient ascent: \n');
for i=1:maxiter
    for j =1:N
        g = 1./(1+exp(-W*x(j,:)'));
        W = W + anneal(i)*((1-2*g)*x(j,:) + inv(W'));
    end
    %Error(i) =  -(log(g'*(1-g)) + sum(sum(log(abs(W)))));
    fprintf('%d ',i);
end
fprintf('\nfinish gradient ascent\n');

y = x*W;        % Initialise y, the estimated source signals.
% Listen to extracted signals ...
fprintf('\nlisten to extracted signals [press Enter]\n');
soundsc(y(:,1),Fs);	  pause;
soundsc(y(:,2),Fs);
subplot(3,2,5); plot(1:length(y(:,1)),y(:,1));   title('1st extracted signal');
subplot(3,2,6); plot(1:length(y(:,2)),y(:,2));   title('2nd extracted signal');

%figure(2);  plot(1:maxiter,Error);
