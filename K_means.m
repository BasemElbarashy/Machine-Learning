close all;clc;
rng(6)
load('ex7data2.mat');
m = size(X,1);
n = size(X,2);
XCluster = zeros(m,1);
numOfCentroides = 3;
color = ['r' 'g' 'b'];
c = 10 * rand(numOfCentroides,n); %initialize centroides     %there are better ways to intialize the centorids
inf = 1e10;
figure(1)
hold on


for k = 1:1000
    c_old = c;
    %-------------------- cluster each point
    for i=1:m
        l = inf;
        for j=1:numOfCentroides
            distance = norm( c(j,:) - X(i,:) );
            if(distance < l)
                XCluster(i) = j;
                l = distance;
            end
        end
    end
    %-------------------- update centroides
    for j=1:numOfCentroides
       if length(find(XCluster == j)) ~= 0
           c(j,1) =  sum( X(find(XCluster == j),1) ) / length(find(XCluster == j));
           c(j,2) =  sum( X(find(XCluster == j),2) ) / length(find(XCluster == j));
       end       
    end    
    %-------------------- plot data
    for j=1:numOfCentroides
        plot([c_old(j,1) c(j,1)],[c_old(j,2) c(j,2)],strcat(color( j ),'-.o'),'LineWidth',1);
    end    
    for i=1:m
        plot(X(i,1),X(i,2),strcat(color( XCluster(i) ),'.'))
    end
    pause(0.5)
    %---------------------- convergence condition 
    if c_old == c
        display(['K-means converged after ' num2str(k) ' iterations' ])
        break
    end
end