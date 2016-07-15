function k = K(x,y,tau) %gaussian kernel [can be used as covariance function]

gk = @(x,y,tau) exp(-1/2*(tau^2) * norm(x-y)^2);
k = zeros(length(x),length(y));

for i=1:length(x)
    for j=1:length(y)
        k(i,j) = gk(x(i),y(j),tau);
    end
end

    

