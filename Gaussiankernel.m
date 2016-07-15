%% ========================================================================
% constructing dataset
close all,clear;
x = 30*[(randn(100,1)-0.5),(randn(100,1)-0.5)];
y = ones(100,1);
d = 20;
y(find(x(:,1)>-2*d & x(:,2)>-d & x(:,1)<2*d & x(:,2)<d)) = -1;
%% ========================================================================
% plot x vs y
subplot(2,1,1)
for i =1:100
    if(y(i)==1)
        plot(x(i,1),x(i,2),'bo')
    else
        plot(x(i,1),x(i,2),'go')
    end
    hold on
end
%% ========================================================================
% computing new features (kernels) ==> gaussian kernel 
% gaussian kernel ==> similarty between features and landmarks
l = [d,0
    -d,0]; %landmarks
sigma = 20;
for j =1:2
    for i=1:100
        f(i,j) = exp(- ((norm(x(i,:)-l(j,:)).^2)/(2*sigma*sigma)));  
    end
end
%% ========================================================================
% plotting f vs y [becomes linearly seperable]
subplot(2,1,2)
for i =1:100
    if(y(i)==1)
        plot(f(i,1),f(i,2),'b*');
    else
        plot(f(i,1),f(i,2),'g*');
    end
    hold on
end
%% ========================================================================
% linear regression
f = [f,ones(100,1)];
w = inv(f'*f)*f'*y;
display(w)
g = (0:.1:1)';
h = -(g*w(2)+w(3))/w(1);
plot(g,h,'k')

