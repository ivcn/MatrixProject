function [ outImage ] = alignFunc( image,mid )
%ALIGNFUNC Summary of this function goes here
%   Detailed explanation goes here
l = 3.5;
b = 1.15;
g = 2;
Ny = size(image,2);
%[maxEls maxPoses] = max(image);
%[maxEl mid] = max(maxEls);
%mid = maxPoses(mid)
for i = 1:Ny
    for j=1:mid
        k = l/(l-b*abs(tan(pi*g*(mid-j)/180)));
        image(j,i) = image(j,i)*k;
    end
    for j=mid:size(image,1)
        k=l/(l-b*abs(tan(pi*g*(j-mid)/180)));
        image(j,i) = image(j,i)*k;
    end
end
outImage = image;

