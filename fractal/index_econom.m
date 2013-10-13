clc;
clear;
[filename pathname] = uigetfile('*.txt');
fid = fopen(strcat(pathname,filename));
D = textscan(fid,'%s %s %f %f %f %f %*[^\n]','CommentStyle','//');
fclose(fid);
data_high = D{4};%high
data_low = D{5}; %low
N = length(data_high);
series = data_high;
pow = floor(log2(N));

numberOfIntervalsInPartition = 2.^(0:pow);
%deltas = zeros(1, size(numberOfIntervals,2));
V = zeros(1,size(numberOfIntervalsInPartition,2));
sizeOfIntervalsInPartition = floor(N./numberOfIntervalsInPartition);%delta
for j = 1:size(numberOfIntervalsInPartition, 2);
    for i=1:numberOfIntervalsInPartition(j)
        interval_high = data_high(max(1,(i-1)*sizeOfIntervalsInPartition(j)):i*sizeOfIntervalsInPartition(j));
        interval_low =  data_low(max(1,(i-1)*sizeOfIntervalsInPartition(j)):i*sizeOfIntervalsInPartition(j));
        A = max(interval_high) - min(interval_low);%calc A
        V(j) = V(j) + A;%add to V
        %store V
    end
end

figure();
plot(log(sizeOfIntervalsInPartition), log(V), 'k.');
hold on;
c = polyfit(log(sizeOfIntervalsInPartition), log(V), 1);
mean_xy = mean(log(sizeOfIntervalsInPartition).*log(V));
mean_x = mean(log(sizeOfIntervalsInPartition));
mean_y = mean(log(V));
mean_square_x = mean(log(sizeOfIntervalsInPartition).*log(sizeOfIntervalsInPartition));
square_mean_x = mean(log(sizeOfIntervalsInPartition)).*mean(log(sizeOfIntervalsInPartition));
mu = -(mean_xy - mean_x*mean_y)/(mean_square_x - square_mean_x);
title(mu);
plot(log(sizeOfIntervalsInPartition),log(sizeOfIntervalsInPartition).*c(1)+c(2), 'r');