function [m, HFS, LFS] = smoothing(omega,IterNo,M1);

%-----------------------------SMOOTHING------------------------------------
%omega - diffusion number
%IterNo - Number of iterations
%M1 - file name and path;
%--------------------------------------------------------------------------

%Loading the data of the first file into a matrix
%V=dlmread(M1,'\t',0,0);

V = M1;
M = size(M1,1);
%V1 = V(:,2);
V1 = V;
V2 = zeros(size(V1));
for j = 1:IterNo
    V2(1) = (1-2*omega)*V1(1)+2*omega*V1(2);
    V2(2:(M-1)) = omega*V1(3:M) + omega*V1(1:(M-2)) + (1-2*omega)*V1(2:(M-1));
    V2(M) = (1-2*omega)*V1(M)+2*omega*V1(M-1);
    V1 = V2;
end

LFS = V2;
HFS = V - V2;
m = V(:,1);