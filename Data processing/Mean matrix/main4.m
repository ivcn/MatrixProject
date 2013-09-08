load('C:\Users\John\Documents\Матрицы\ANALYZED DATA sm0001 01 04 2010 d15 uf1 ut1 obr1 0 5 35 sigma0 pr5 ssa_seg36_win18_comp1_ a40-50 b10 wt haar A2 lev5 thr0.mat','mat_intens');
data = mat_intens{4};
Nrow = size(data,1);
Ncol = size(data,2);
Ntime = size(data,3);
source = zeros(1,Ntime);
sig = zeros(1,Ntime);
days = 1:size(data,3);
days = (days/144)+1;
for t=1:Ntime
    source(t) = mean(mean(data(:,:,t)));
end
figure(1);
plot(source,'k');
title('Сигнал усредненный по матрицам');
sig = source;
figure(2);
trend = ChebRazl(sig,15,0);
%trend = sig - SSA_Filter_Part(sig,72,1);
subplot(211);
plot(days,sig,'k');
hold on;
plot(days,trend,'r');
hold off;
subplot(212);
plot(days,sig-trend);

sig = sig-trend;

figure(3);
A = autocorrelation(sig);
%[A lags] = autocorr(sig,Ntime-1);
plot(0:size(A,2)-1,A,'k');
%hold on;
%plot(lags,A1,'g');
%hold off;
title('Автокорреляционная функция');

figure(4);
S = flicker_powerSpectrum(sig,A,1,size(sig,2));
plot(days,S);

figure(5);
F = flicker_moment(sig,2);
plot(days,F);
hold on;
F = flicker_moment(sig,3);
plot(days,F,'k')
F = flicker_moment(sig,4);
plot(days,F,'r');
F = flicker_moment(sig,5);
plot(days,F,'g');
title('p=2,3,4,5');
hold off;
%C = zeros(1,size(sig,2)-1);
%for i = 2:size(sig,2)
%    C(i)=flicker_c(sig,i);
%end
%figure(6);
%plot(days,C,'k');

f = fft(sig);
figure(6);
plot(abs(f).^2);
