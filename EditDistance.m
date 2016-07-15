function distance = EditDistanceBasem(s1,s2) 
%% calculate Levenshtein Edit distance
n1 = length(s1)+1;
n2 = length(s2)+1;
table = zeros(n1,n2);

%intitialization of 1st row and column
table(1,1:n2) = 0:(n2-1);
table(1:n1,1) = 0:(n1-1);

%get each entry value using the previous ones
for i = 2:n1
    for j =2:n2
        table(i,j) = min([ table(i-1,j)+1 , table(i,j-1)+1 , table(i-1,j-1)+2*not(s1(i-1)==s2(j-1)) ]);
        % the three terms in min fn are costs of Deletion, insertion and substitution, respectively 
    end
end
%return the Levenshtein Edit distance
distance = table(n1,n2);
disp(table)
end