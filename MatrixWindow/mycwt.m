function [ E ] = mycwt( input, mina, maxa,wname,window_a, flagTrend,pow )
%MYCWT Summary of this function goes here
%   Detailed explanation goes here
N = size(input,2);
wcoef = zeros(maxa-mina+1,N);
for b = 1:N
    data = input(max(1,b-window_a*maxa):b);%выдел€ем кусок р€да размером в нужное число а
    if(flagTrend==true)%удал€ем с него тренд
        trend=ChebRazl(data,pow,0);
        data = data-trend;
    end
    %у нас новый р€да, размером window_a*maxa. Ёто кусок старого р€да от
    %точки b-window_a*max_a до точки b.
    %“очка b теперь соответствует точке size(data,2) т.е. последней
    %точке нового р€да. ѕоэтому везде здесь вместо b стоит size(data,2)
    for a = mina:maxa
        left = max(1,size(data,2)-window_a*a);
        indexes = left:size(data,2);%интервал интегрировани€
        res = sum(data(indexes).*wavelet((indexes-size(data,2))./a,wname)./sqrt(a));%интегрирование
        wcoef(a-mina+1,b) = res;
    end
end

Ew = sum(abs(wcoef(:,:)).^2);
xs=1;
xo=1;
E=zeros(1,N-xo+1);
while(xs+xo-1<=N)%пока конечна€ позици€ меньше или равна n
  %E=[E sum(Ew(1,xs:1:xs+xo-1))];
  E(xs)=sum(Ew(1,xs:1:xs+xo-1));%суммируем элементы внутри окна
  xs=xs+1;
end

end

function [r] = wavelet(x,wname)
%if(x>0)
r(x>0)=0;
%else
if strcmp(wname,'mexh')
    C = 2/sqrt(3)*pi^(1/4);
    r(x<=0) = C.*exp(-x(x<=0).^2./2).*(1-x(x<=0).^2);
elseif strcmp(wname,'morle')
    r(x<=0) = 2.*exp(-x(x<=0).^2/2).*cos(5.*x(x<=0));
%end
end
end