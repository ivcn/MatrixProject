function [ output ] = autocorrelation( input )
%AUTOCORRELATION Summary of this function goes here
%   Detailed explanation goes here
V = input;
N = size(V,2);
A = zeros(1,N);
m = mean(V);
for i = 0:N-1%цикл по сдвигам
    temp_sum = 0;
    for j = 1:N-i
        temp_sum = temp_sum + V(j)*V(j+i);
    end
    A(i+1) = temp_sum /(N-i);
end
output = A;

