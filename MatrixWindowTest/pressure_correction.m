function [ output ] = pressure_correction( input )
%PRESSURE_CORRECTION Summary of this function goes here
%   Detailed explanation goes here
s = input;
mid = floor(size(s,2)/2);
for i=1:size(s,3)
    i
    temp = squeeze(s(:,:,i));
    for j=1:size(s,1)
        for k=1:mid%size(s,2)
            m=k+mid+rem(size(s,2),2);
            %if m > size(s,2)
            %    m = m-size(s,2);
            %end
            s(j,k,i) = temp(j,k)-temp(j,m);
            s(j,m,i) = s(j,k,i);
        end
    end
end

output = s;
end

