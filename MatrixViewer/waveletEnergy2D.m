function [ output ] = waveletEnergy2D( input, min_a, max_a )
%WAVELETENERGY2D Summary of this function goes here
%   Detailed explanation goes here
Nx = size(input,1);
Ny = size(input,2);

outputX = zeros(size(input));
outputY = zeros(size(input));

%min_a = 2;
%max_a = 32;

for i=1:Nx
    outputX(i,:) = AnalyzW( input(i,:),min_a,max_a,1);
end
for i=1:Ny
    temp = AnalyzW(outputX(:,i)',min_a,max_a,1);
    outputY(:,i) = temp';
end
output = outputY;%sqrt(outputY.^2 + outputX.^2);%sqrt(outputX.*outputY);
end

