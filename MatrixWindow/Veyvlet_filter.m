function xd=Veyvlet_filter(X)

wname = 'coif2'; lev=6;
[c,l] = wavedec2(X,lev,wname);

% Estimate the noise standard deviation from the
% detail coefficients at level 1.
det1 = detcoef2('compact',c,l,1);
sigma = median(abs(det1))/0.6745;

% Use wbmpen for selecting global threshold  
% for image de-noising.

alpha = 1.2;
alpha=2;
%alpha = 0.12;
%alpha = 10.2;
thr = wbmpen(c,l,sigma,alpha);

%thr=0.4;

%thr = 36.0621;

% Use wdencmp for de-noising the image using the above
% thresholds with soft thresholding and approximation kept.
keepapp = 1;
%keepapp = 5;
xd = wdencmp('gbl',c,l,wname,lev,thr,'s',keepapp);

% Plot original and de-noised images.
%figure(2)
%colormap(pink(nbc));
%subplot(221), image(wcodemat(X))
%title('Original image')
%subplot(222), image(wcodemat(xd))
%title('De-noised image')

end

