function gaussianPlot(mu,sigma,range)
    %plot contour of the gaussian
    
    [X1,X2] = meshgrid(range,range);
    F = mvnpdf([X1(:) X2(:)],mu,sigma);
    F = reshape(F,length(range),length(range));
    contour(X1,X2,F)
    %figure(2); surf(range,range,F);   %hold on;
end