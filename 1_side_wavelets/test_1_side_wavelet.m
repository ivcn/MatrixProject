function [out] = test_1_side_wavelet()

t = -100:0.01:100;
N = size(t,2);%number of points
T = 100;%time of interval
%t = (0:N-1)./T; %time
%t = t*T;%time in secondsx = -5:0.02:5;

a = 1;
b=0;
w = wavelet(t);
%w = (1/sqrt(a)).*(1-((t-b)./a).^2).*exp(-((t-b)./a).^2/2);
a = 4;
b=4;
%w1 = (1/sqrt(a)).*(1-((t-b)./a).^2).*exp(-((t-b)./a).^2/2);
w1 = wavelet((t-b)./a);

figure(1);
plot(t,w,'k');
hold on;
plot(t,w1,'k--');
hold off;
axis([-10 15 -0.9 1.9]);

p = abs(fft(w))/(N/2);% absolute value of the fft
p1= abs(fft(w1))/(N/2);
p = p(1:N/2);%take the power of positive freq. half
p1 = p1(1:N/2);
freq = (0:N/2-1)/T;%find the corresponding frequency in Hz
figure();
plot(freq,p,'k');
hold on;
plot(freq,p1,'k--');
hold off;
axis([0 3 0 0.06]);
end



function [r] = wavelet(x)
r(x>0) = 0;
%if(x>0)
%    r=0;
%else
    %r = 2.*exp(-x.^2/2).*cos(5.*x);
C = 2/sqrt(3)*pi^(1/4);
r(x<=0) = C.*exp(-x(x<=0).^2./2).*(1-x(x<=0).^2);
%end
end