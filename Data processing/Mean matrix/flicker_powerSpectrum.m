function [ output ] = flicker_powerSpectrum( s,a,freq1,freq2 )
%FLICKER_POWERSPECTRUM Summary of this function goes here
%   Detailed explanation goes here
%   s - source signal
%   a - autocorrelation function of source signal
%   freq1,freq2 - interval of frequency

N_freq = freq2-freq1+1;
%q = freq1:freq2;
pS = zeros(1,N_freq);
m = (mean(s))^2;
for q=freq1:freq2
    temp_sum = 0;
    for j = 0:size(a,2)-1
        temp_sum = temp_sum+a(j+1)*exp(-2*pi*q*1i*j/size(a,2));
    end
pS(q-freq1+1) = temp_sum;
end
output = abs(pS);