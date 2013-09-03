function [ E ] = mycwt( input, mina, maxa,wname,window_a, flagTrend,pow )
%MYCWT Summary of this function goes here
%   Detailed explanation goes here
N = size(input,2);
wcoef = zeros(maxa-mina+1,N);
for b = 1:N
    data = input(max(1,b-window_a*maxa):b);%�������� ����� ���� �������� � ������ ����� �
    if(flagTrend==true)%������� � ���� �����
        trend=ChebRazl(data,pow,0);
        data = data-trend;
    end
    %� ��� ����� ����, �������� window_a*maxa. ��� ����� ������� ���� ��
    %����� b-window_a*max_a �� ����� b.
    %����� b ������ ������������� ����� size(data,2) �.�. ���������
    %����� ������ ����. ������� ����� ����� ������ b ����� size(data,2)
    for a = mina:maxa
        left = max(1,size(data,2)-window_a*a);
        indexes = left:size(data,2);%�������� ��������������
        res = sum(data(indexes).*wavelet((indexes-size(data,2))./a,wname)./sqrt(a));%��������������
        wcoef(a-mina+1,b) = res;
    end
end

Ew = sum(abs(wcoef(:,:)).^2);
xs=1;
xo=1;
E=zeros(1,N-xo+1);
while(xs+xo-1<=N)%���� �������� ������� ������ ��� ����� n
  %E=[E sum(Ew(1,xs:1:xs+xo-1))];
  E(xs)=sum(Ew(1,xs:1:xs+xo-1));%��������� �������� ������ ����
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