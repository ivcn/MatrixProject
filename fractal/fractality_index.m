function [ output ] = fractality_index( input )
%FRACTALITY_INDEX Summary of this function goes here
%   Detailed explanation goes here
N = length(input);
pow = floor(log2(N));
numberOfIntervalsInPartition = 2.^(0:pow);
%deltas = zeros(1, size(numberOfIntervals,2));
V = zeros(1,size(numberOfIntervalsInPartition,2));
sizeOfIntervalsInPartition = floor(N./numberOfIntervalsInPartition);%delta
for j = 1:size(numberOfIntervalsInPartition, 2);
    for i=1:numberOfIntervalsInPartition(j)
        interval = input(max(1,(i-1)*sizeOfIntervalsInPartition(j)):i*sizeOfIntervalsInPartition(j));
        %interval_low =  input(max(1,(i-1)*sizeOfIntervalsInPartition(j)):i*sizeOfIntervalsInPartition(j));
        A = max(interval) - min(interval);%calc A
        V(j) = V(j) + A;%add to V
        %store V
    end
end

x = log(sizeOfIntervalsInPartition);
y = log(V);

%let y = ax+b
mean_xy = mean(x.*y);
mean_x = mean(x);
mean_y = mean(y);
mean_square_x = mean(x.^2);
square_mean_x = mean(x).^2;
a = (mean_xy - mean_x*mean_y)/(mean_square_x - square_mean_x);
b = mean(y) - a*mean(x);

y_regr = a.*x+b;
figure();
plot(x, y, 'k.');
hold on;
plot(x, y_regr, 'k');
mu = -a;
%calculate estimate of dispertion
s2 = sum( (y - y_regr).^2)/(size(x,2)-2);
A = zeros(size(x,2),2);
A(:,1) = x';
A(:,2) = 1;
ATA = A'*A;
K = s2*inv(ATA);
disp_a = K(1,1);
title(strcat(num2str(mu),'+-', num2str(disp_a)));
%disp_b = K(2,2);
output = [mu disp_a]
end

