function [ output ] = WaveletDenoise2D( input )
%WAVELETDENOISE2D Summary of this function goes here
%   Detailed explanation goes here
wname = 'coif2';
lev = 3;
[c,s] = wavedec2(input,lev,wname);
% Estimate the noise standard deviation from the
% detail coefficients at level 1.
det1 = detcoef2('compact',c,s,1);
sigma = median(abs(det1))/0.6745;

% Use wbmpen for selecting global threshold  
% for image de-noising.
alpha = 2;
thr = wbmpen(c,s,sigma,alpha)

% Use wdencmp for de-noising the image using the above
% thresholds with soft thresholding and approximation kept.
keepapp = 1;
output = wdencmp('gbl',c,s,wname,lev,thr,'s',keepapp);
end