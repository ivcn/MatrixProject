load('C:\Users\John\Documents\Матрицы\1 июня 2011\ANALYZED DATA sm0001 01 06 2011 d10 uf1 ut1 obr1 0 10 40 sigma0 pr5 ssa_seg72_win18_comp1_ a1-36 b36 wt haar A2 lev5 thr0.mat','mat_intens');
data = mat_intens{4};
Nrow = size(data,1);
Ncol = size(data,2);
Ntime = size(data,3);
sig = zeros(1,Ntime);
days = 1:size(data,3);
days = (days/144)+1;
for t=1:Ntime
    sig(t) = mean(mean(data(:,:,t)));
end
figure(1);
plot(sig,'k');
title('Сигнал усредненный по матрицам');

figure(2);
trend = ChebRazl(sig,25,0);
subplot(211);
plot(days,sig,'k');
hold on;
plot(days,trend,'r');
hold off;
subplot(212);
plot(days,sig-trend);

sig = sig-trend;
win = 1440;
comp1 = sig - SSA_Filter_Part(sig,win,1);
comp2 = sig - SSA_Filter_Part(sig,win,2)-comp1;
comp3 = sig - SSA_Filter_Part(sig,win,3)-comp1-comp2;
comp4 = sig - SSA_Filter_Part(sig,win,4)-comp1-comp2-comp3;
comp5 = sig - SSA_Filter_Part(sig,win,5)-comp1-comp2-comp3-comp4;
comp6 = sig - SSA_Filter_Part(sig,win,6)-comp1-comp2-comp3-comp4-comp5;

figure(3);
title('SSA-компоненты');
subplot(611);
plot(days,comp1);
subplot(612);
plot(days,comp2);
subplot(613);
plot(days,comp3);
subplot(614);
plot(days,comp4);
subplot(615);
plot(days,comp5);
subplot(616);
plot(days,comp6);

a1=1;
a2=5;
ener1 = AnalyzW(comp1,a1,a2,1,0);
ener2 = AnalyzW(comp2,a1,a2,1,0);
ener3 = AnalyzW(comp3,a1,a2,1,0);
ener4 = AnalyzW(comp4,a1,a2,1,0);
ener5 = AnalyzW(comp5,a1,a2,1,0);
ener6 = AnalyzW(comp6,a1,a2,1,0);

figure(4);
subplot(611);
plot(days,ener1);
subplot(612);
plot(days,ener2);
subplot(613);
plot(days,ener3);
subplot(614);
plot(days,ener4);
subplot(615);
plot(days,ener5);
subplot(616);
plot(days,ener6);

% 
% h1 = hilbert(comp1);
% h2 = hilbert(comp2);
% h3 = hilbert(comp3);
% h4 = hilbert(comp4);
% h5 = hilbert(comp5);
% 
% figure(4);
% title('преобразование Гильберта');
% subplot(511);
% plot(days,abs(h1));
% subplot(512);
% plot(days,abs(h2));
% subplot(513);
% plot(days,abs(h3));
% subplot(514);
% plot(days,abs(h4));
% subplot(515);
% plot(days,abs(h5));

rest = comp1+comp2+comp3;
E = AnalyzW(rest,a1,a2,1,1);
figure();
subplot(211);
plot(days,rest);
subplot(212);
plot(days,E);