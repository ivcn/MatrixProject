function lrez = Fisher(A, lmin, lmax)
%UNTITLED1 Summary of this function goes here
n = size(A,2);

M = zeros(1,lmax-lmin+1);
S = zeros(1,lmax-lmin+1);

for l = lmin:1:lmax
    F = ChebRazl(A,l,0);
    M(l-lmin+1)=sum((F(1,:)-A(1,:)).^2);
    S(l-lmin+1)=M(l-lmin+1)/(n-(l+1));
end

M;
S;

lrez = lmin;
l1 = 1;
l2 = 2;


while (((S(l1))^2>(S(l2))^2)&&(lrez<lmax-lmin)&&((((S(l1))^2)/((S(l2))^2))>finv(0.05,n-lrez,n-lrez-1)))
    lrez = lrez + 1;
    l1 = l1+1;
    l2 = l2+1;
end

%  Detailed explanation goes here
