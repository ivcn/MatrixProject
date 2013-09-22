function B = Balance(A,F)   %% Балансировка функции (убираем тренд)
%UNTITLED1 Summary of this function goes here
n = size(A,2);
B = A(1,:)-F(1,:);
%plot(1:n,A(1,:),1:n,F(1,:),1:n,B)
%  Detailed explanation goes here
