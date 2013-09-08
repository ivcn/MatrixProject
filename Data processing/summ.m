function [ output ] = summ( input, n)
%summ Суммирование изображений по n штук
%   Detailed explanation goes here
m=input(:,:,1);
m=m-m;
s=size(input);
output=zeros(s(1),s(2),round(s(3)/n));
j=1;
for i=1:s(3)
    m=m+input(:,:,i);
    if rem(i,n) == 0
        %figure, imagesc(m);
        output(:,:,j)=m;
       % figure(j), imagesc(ar(:,:,j));
        j=j+1;
        m=m-m;
    end
end

end

