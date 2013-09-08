function [out] = fourier_proc(data,m1,m2)
f = fft(data);
n = size(f,2);
f(1:m1) = zeros(1,m1);
f(n-m2+1:n) = zeros(1,m2);
out = real(ifft(f));
end