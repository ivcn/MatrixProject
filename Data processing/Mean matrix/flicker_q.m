function [ output ] = flicker_q( input,k,b )
%FLICKER_Q Summary of this function goes here
%   Detailed explanation goes here
alpha = 1;
p=2;
N = size(input,2);
N1 = alpha*N;
shift = 0:N-1;
temp_sum = 0;
for i=1:size(shift,2)
    temp_sum2=0;
    for j=1+k*b:N-shift(i)+k*b
        temp_sum2 = temp_sum2+(input(min(j,N))-input(min(j+shift(i),N))^p);
    end
    temp_sum = temp_sum + (1/(N-shift(i)))*temp_sum2;
end
output = temp_sum/N1;
end

