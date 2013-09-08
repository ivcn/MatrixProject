function [ output ] = normalization1( input )
%NORMALIZATION1 Summary of this function goes here
%   Detailed explanation goes here
Nr = size(input,1);
Nc = size(input,2);

output = zeros(size(input));
for i = 1:Nr
%    i
    for j=1:Nc
%        n = sqrt(sum(input(i,j,:).^2));
%        output = input(i,j,:)./n;
    end
end

for i = 1:Nr
    i
    for j=1:Nc
        n = sqrt(sum(input(i,j,:).^2));
        output(i,j,:) = input(i,j,:)./n;
    end
end

end

