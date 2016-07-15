%% ================================================ dataset
clear;close all;
n= 100;
x = [(1:2*n)+n/5*randn(2*n,1)';(1:2*n)+n/5*randn(2*n,1)' ;ones(1,2*n)]';
y = [ones(n, 1); -ones(n, 1)]; 
% important note: classes must be positive and negative values lika +a and -a
% zeros aren't working here
% display(x);display(y);
%% ================================================ using normal eq
w = inv(x'*x)*x'*y;     %least squares solution %3*1    can be written: w = (x'*x)\(x'*y)
display(w)
figure(1)
plot(x(1:n,1),x(1:n,2),'*r')
hold on
plot(x((n+1):end,1),x((n+1):end,2),'og')

g = (1:2*n)';
h = -(g*w(2)+w(3))/w(1);
plot(g,h,'b')
