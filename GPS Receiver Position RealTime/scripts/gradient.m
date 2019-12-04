function [ H ] = gradient( X, Xp, R)
N = length(X);
for i = 1 : N
    for j = 1 : 3
%         H(i,j) = (X(j,i) - Xp(j)) / R(i);
          H(i,j) = (X(j,i) - Xp(j)) / norm(X(:,i)-Xp);
    end
end
end

