t = 0:0.01:20;
sig = sin(t);
figure();
plot(sig,'k');
hold on;
A = autocorrelation(sig);
plot(0:size(A,2)-1,A,'g');
title('Автокорреляционная функция');