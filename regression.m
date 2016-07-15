function  [track] = regression(Xs,Ys)
%% ================================================
m = length(Xs);
x = [Xs;ones(1,m)]'; 
y = Ys';   
%% ================================================ using normal eq
w = (x'*x)\(x'*y);
track = [Xs',[Xs',ones(1,m)']*w];
%{
display(x);display(y);
display(w)
figure(1)
plot(x(:,1),y,'*r')
hold on
plot(Xs,[Xs',ones(1,m)']*w,'g');
%}

end