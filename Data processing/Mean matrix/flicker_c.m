function [ output ] = flicker_c( input, k )
%FLICKER_C Summary of this function goes here
%   Detailed explanation goes here
dt = 200;
t=300;
b = 1;%dt/t;
output = (flicker_q(input,k,b)-flicker_q(input,k-1,b))/(flicker_q(input,k,b)-flicker_q(input,k-1,b));
output = output*2;
output = output*dt/t;

end

