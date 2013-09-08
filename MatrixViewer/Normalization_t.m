function [ output ] = Normalization_t( input )
%NORMALIZATION_T Summary of this function goes here
%   Detailed explanation goes here
output = zeros(size(input));
for i=1:size(input,1)
    for j=1:size(input,2)
        output(i,j,:) = SSA_Filter_Part(input(i,j,:),144,1);
    end
end

end

