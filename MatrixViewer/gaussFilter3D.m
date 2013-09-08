function [ output ] = gaussFilter3D( sig,sizeRow,sizeCol,sizeT,sigma )
%GAUSS3D Summary of this function goes here
%   Detailed explanation goes here
%construct filter
filter = zeros(sizeRow,sizeCol,sizeT);
centerRow = ceil(sizeRow/2);
centerCol = ceil(sizeCol/2);
centerT = ceil(sizeT/2);
for i=1:sizeRow
    for j=1:sizeCol
        for k=1:sizeT
            filter(i,j,k) = exp(-((i-centerRow)^2+(j-centerCol)^2+(k-centerT)^2)/(2*sigma^2))/((2*pi)^(3/2)*sigma^3);
        end
    end
end

s = sum(sum(sum(filter)));
filter = filter./s;
%extend data to eliminate border effect...already don't need..)
%s = zeros(size(sig,1)+sizeRow,size(sig,2)+sizeCol,size(sig,3)+sizeT);
output = imfilter(sig,filter,'symmetric');


end

