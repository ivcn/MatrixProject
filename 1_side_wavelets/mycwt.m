function [ E ] = mycwt( input, mina, maxa )
%MYCWT Summary of this function goes here
%   Detailed explanation goes here
N = size(input,2);
wcoef = zeros(maxa-mina+1,N);
for b = 1:N
    for a = mina:maxa
        res = 0;
        for i=1:b
            res = res+input(i)*wavelet((i-b)/a)/sqrt(a);
        end
        wcoef(a-mina+1,b) = res;
    end
end

figure();
imagesc(wcoef.^2);

Ew = sum(abs(wcoef(:,:)).^2);
xs=1;
xo=1;
E=zeros(1,N-xo+1);
while(xs+xo-1<=N)%пока конечная позиция меньше или равна n
  %E=[E sum(Ew(1,xs:1:xs+xo-1))];
  E(xs)=sum(Ew(1,xs:1:xs+xo-1));%суммируем элементы внутри окна
  xs=xs+1;
end

end

function [r] = wavelet(x)
r(x>0) = 0;
% if(x>0)
%     r=0;
% else
    %r(x<=0) = 2.*exp(-x(x<=0).^2/2).*cos(5.*x(x<=0));
C = 2/sqrt(3)*pi^(1/4);
r(x<=0) = C.*exp(-x(x<=0).^2./2).*(1-x(x<=0).^2);
% end
end