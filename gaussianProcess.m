%% Based on CS229 sec8 
%% ================================================ Generating dataset
clear;clc;
m = 10;
x = ((1:m)+m/5*randn(m,1)')';  %m*1
y = (1:m)';                    %m*1
%% ================================================ calculate mean() and cov()
getDiagonal = @(x) x(sub2ind(size(x),1:size(x,1),1:size(x,2)))';
tau = 1;   
sn  = 0.5;  %noise standard deviation

xt = (min(x)-2:0.1:max(x)+2)';
I  = eye(length(x));    %identity matrix
It = eye(length(xt));   %identity matrix
u = K(xt,x,tau)/(K(x,x,tau)+(sn^2)*I)*y;    %mean vector
s = K(xt,xt,tau) + (sn^2)*It - (K(xt,x,tau)/(K(x,x,tau)+(sn^2)*I)*K(x,xt,tau)); %covariance matrix
upperBound = u+2*sqrt(getDiagonal(s));
lowerBound = u-2*sqrt(getDiagonal(s));
%% ================================================
% plotting results
xc  = [xt;xt(end:-1:1)];
yc1 = [lowerBound; u(end:-1:1)];
yc2 = [upperBound; u(end:-1:1)];

figure(1)
plot(x(:,1),y,'*r','LineWidth',3);
hold on
fill(xc,yc1,0.60*[0 1 0]);
fill(xc,yc2,1*[0 1 0]);
plot(xt,upperBound,'k')
plot(xt,lowerBound,'k')
plot(xt,u,'b','LineWidth',2);
plot(x(:,1),y,'*r','LineWidth',3);
hold off;
