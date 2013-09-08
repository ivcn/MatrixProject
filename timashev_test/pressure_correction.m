function [ output ] = pressure_correction( signal, pressure )
%PRESSURE_CORRECTION Summary of this function goes here
%   Detailed explanation goes here
output = zeros(size(signal));
beta = -0.002;
p0=994;
for t =1:size(signal,1)
    output(t) = signal(t)-beta*signal(1)*(pressure(t)-p0);
end

end

