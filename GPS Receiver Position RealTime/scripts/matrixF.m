function [ f ] = matrixF(X, X0, Xp, R)
N = length(X);
for i = 1 : N
%     f(i,1) = X0(1) * (X(1,i) - Xp(1)) / R(i) + X0(2) * (X(2,i) - Xp(2)) / R(i) +X0(3) * (X(3,i) - Xp(3)) / R(i);
f(i,1) = X0(1) * (X(1,i) - Xp(1)) / norm(X(:,i)-Xp) + X0(2) * (X(2,i) - Xp(2)) / norm(X(:,i)-Xp) +X0(3) * (X(3,i) - Xp(3)) / norm(X(:,i)-Xp);
end
end