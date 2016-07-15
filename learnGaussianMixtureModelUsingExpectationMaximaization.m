%% ================================================ generating dataset [two clusters]
clear;close all;clc;
m = 30;  %must be multiple of 4
x = [(1:m/2)+m/5*randn(m/2,1)';(1:m/2)+m/5*randn(m/2,1)']';
x = [x; [((1.5*m+1):2*m)+m/10*randn(m/2,1)';((1.5*m+1):2*m)+m/10*randn(m/2,1)']'];
%% ================================================ initialization
mu = rand(2,2);
sigma(:,:,1) = [5,0;0,5];  
sigma(:,:,2) = [5,0;0,5];  
w = [0.5 0.5];
r = min(x(:)):0.5:max(x(:));
epsilon = 1e-10; %I used this value to guarantee that normComp != 0
%% ================================================ EM algorithm
for i=1:200
    parametersHistory = [w(:) ; mu(:); sigma(:)];
    %%======== E-step ========
    normComp = w(1) * mvnpdf(x,mu(1,:),sigma(:,:,1)) + ...
               w(2) * mvnpdf(x,mu(2,:),sigma(:,:,2)) + epsilon;
    Zn1 = w(1) * mvnpdf(x,mu(1,:),sigma(:,:,1)) ./ normComp;
    Zn2 = w(2) * mvnpdf(x,mu(2,:),sigma(:,:,2)) ./ normComp;
    %%======== M-step ========
    N1 = sum(Zn1);
    N2 = sum(Zn2);
    %update mu
    sm1 = [0 0];      sm2 = [0 0];
    for j =1:m
        sm1 = sm1 + Zn1(j)*x(j,:);
        sm2 = sm2 + Zn2(j)*x(j,:);
    end
    mu(1,:) = (1/N1) *sm1;
    mu(2,:) = (1/N2) *sm2;
    %update sigma
    sm1 = [0 0;0 0];      sm2 = [0 0;0 0];
    for j =1:m
        sm1 = sm1 + Zn1(j)*(x(j,:)-mu(1,:))'*(x(j,:)-mu(1,:));
        sm2 = sm2 + Zn2(j)*(x(j,:)-mu(2,:))'*(x(j,:)-mu(2,:));
    end
    sigma(:,:,1) = 1/N1 * sm1;
    sigma(:,:,2) = 1/N2 * sm2;    
    %update the wights of each gaussian
    w(1) = N1/m;
    w(2) = N2/m;
    parametersUpdate = [w(:) ; mu(:) ;sigma(:)];
    
    if abs(parametersHistory-parametersUpdate)<epsilon   %check convergence   
        fprintf('EM converged successfully after %d iterations\n',i);
        break;
    end
    %%======== visulaization ========
    %{
    pause
    plot(x(:,1),x(:,2),'og')
    hold on
    gaussianPlot(mu(1,:),sigma(:,:,1),r)
    gaussianPlot(mu(2,:),sigma(:,:,2),r)
    hold off
    %}
end

%% ================================================ visulaization
display(Zn1)
display(Zn2)
fprintf('EM converged successfully after %d iterations\n',i);

figure(1)
plot(x(:,1),x(:,2),'ob');
title('Dataset');
xlabel('x1')
ylabel('x2')

figure(2)
for i=1:m
    if abs(Zn1(i) - 1) < 1e-2
        plot(x(i,1),x(i,2),'og');
    elseif abs(Zn2(i) - 1) < 1e-2
        plot(x(i,1),x(i,2),'or');
    else 
        plot(x(i,1),x(i,2),'ok');
    end
    hold on
end
hold on
gaussianPlot(mu(1,:),sigma(:,:,1),r);
gaussianPlot(mu(2,:),sigma(:,:,2),r);
title('clusters');
xlabel('x1')
ylabel('x2')
hold off
    