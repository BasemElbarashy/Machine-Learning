%% ================================================ dataset
rng(6)
clear;close all;
m= 10;
n = 3;
x1 = (1:m)+m/10*randn(m,1)';

x = [x1;x1.^2;x1.^3;ones(1,m)]'; 
y = ((1:m).^3+(1:m).^2)';             
display(x);display(y);
%% ================================================ using normal eq
w = inv(x'*x)*x'*y;        %can be written: w = (x'*x)\(x'*y)
display(w)
figure(1)
plot(x(:,1),y,'*r')
hold on
plot(1:m,[(1:m)',(1:m).^2',(1:m).^3',ones(1,m)']*w,'g');
%% ================================================ using batch gradient descent
w = randn(n+1,1);
alpha = 1e-7;
k = 10;
E = zeros(k,1);
for i=1:k
   w = w + alpha*x'*(y - x*w);
   E(i) = 1/2 * sum((x*w-y).^2);

   figure(2);  plot(1:i,E(1:i),'--o'); hold on;       xlabel('iteration'); ylabel('Error');
   text(i,E(i)+300,num2str(i));
   figure(1);  plot(1:m,[(1:m)',(1:m).^2',(1:m).^3',ones(1,m)']*w,'b');  xlabel('x'); ylabel('y');
   text(m,[m,m^2,m^3,1]*w,num2str(i));
   pause(1);
end

display(w)