function [ output ] = flicker_moment( s,p )
%FLICKER_MOMENT Summary of this function goes here
%   Detailed explanation goes here
%   s - source signal
%   p - order of moment
N = size(s,2);
shift = 0:N-1;
F = zeros(1,N);
for i = 1:N
    temp_sum = 0;
    for j = 1:N-shift(i)
        temp_sum = temp_sum+(s(j)*s(j+shift(i))).^p;
    end
    F(i) = (1/(N-shift(i)))*temp_sum;
end
output = F;

end

