%[filename pathname] = uigetfile('*.mat');
%load(strcat(pathname,filename),'mat_wt');
load('C:\Users\John\Documents\ћатрицы\1 сент€бр€ 2011\ANALYZED DATA sm0001 01 09 2011 d30 uf1 ut1 obr1 0 10 40 sigma0 pr5 cheb_maxpow15 a1-144 b1 wt haar A2 lev5 thr0.mat','mat_intens');
sig = mat_intens{4};
sig = mean(mean(sig(20:40,:,:)));%усредн€ем каждую матрицу
sig = sig(:)';
Ntime = size(sig,2);
days = 1:Ntime;
days = (days/144)+1;
alpha = 6000;
trend = cubicSplineSmooth1D(1:Ntime,sig,alpha)';%аппроксимируем р€д и получаем тренд
%trend = ChebRazl(sig,14,0);
%trend = GetSSAComponent(sig,size(sig,2),36,1);

figure(1);
plot(days,sig,'k');
hold on;
plot(days,trend,'r');
hold off;
%break;

figure(2);
sig_wt = sig - trend;%получаем остаток - шум+сигнал.
plot(days,sig_wt,'k');
title('шум+сигнал');

%чистим от шума
%sig_wn = robustCubicSplineSmooth1D(sig_wt,alpha)';
sig_wn = fourier_proc(sig_wt,1000,400);
figure(3);
plot(days,sig_wt,'k');
hold on;
plot(days,sig_wn,'r');
hold off;
title('сигнал без тренда до и после фильтрации');

a1=1;
a2=144;

e = AnalyzW(trend,a1,a2,2,0);
maxe = max(e(500:end-500));
figure(4);
days_e = (1:size(e,2))./144+1;
plot(days_e,e);
ylim([0 maxe]);
title('Ёнерги€ тренда');

e = AnalyzW(sig_wt,a1,a2,2,0);
figure(5);
days_e = (1:size(e,2))./144+1;
plot(days_e,e);
title('Ёнерги€ после вычета тренда');

e = AnalyzW(sig_wn,a1,a2,36,1);
figure(8);
days_e = (1:size(e,2))./144+1;
plot(days_e,e);
title('Ёнерги€ после фильтрации');

% figure(7);
% spectrogram(sig_wt,256,250,256,5000);
% title('—пектрограмма сигнала без тренда');