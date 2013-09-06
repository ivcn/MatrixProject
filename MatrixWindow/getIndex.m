function [ res ] = getIndex( input, b, mina, maxa,window )
%GETINDEX Summary of this function goes here
%   Detailed explanation goes here

res = 0;
leftBorder = max(1,b-window);
indexes = leftBorder:b;
    temp = ChebRazl(input(indexes),3,0);
for a = mina:maxa   
    res = res+sum(temp.*wavelet((indexes-b)./a)./sqrt(a));
end

end

function [r] = wavelet(x)
if(x>0)
    r=0;
else
    r = 2.*exp(-x.^2/2).*cos(5.*x);
    %C = 2/sqrt(3)*pi^(1/4);
    %r = C.*exp(-x.^2./2).*(1-x.^2);
end
end