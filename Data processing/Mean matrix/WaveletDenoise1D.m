function [ output ] = WaveletDenoise1D(wname, input )
%WAVELETDENOISE1D Summary of this function goes here
%   Detailed explanation goes here
X=input;
%wname = 'db4';
lev=3;
[c,l] = wavedec(X,lev,wname);
% Estimate the noise standard deviation from the
% detail coefficients at level 1.
sigma = wnoisest(c,l,1);
alpha=2;
thr = wbmpen(c,l,sigma,alpha);
% Use wdencmp for de-noising the image using the above
% thresholds with soft thresholding and approximation kept.
keepapp = 1;
output = wdencmp('gbl',c,l,wname,lev,thr','h',keepapp);
end

