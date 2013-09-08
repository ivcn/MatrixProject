%uiopen('*.mat');
[filename filepath]=uigetfile('*.mat');
load(strcat(filepath,filename),'mat_intens');
%load('C:\Users\John\Documents\MATLAB\Data\матрицы 29.02.2012\ANALYZED DATA sm0001 01 04 2010 d10 uf2 ut2 obr1 0 10 35 pr10 cheb71 a1-36 b6.mat');
data = mat_intens{4};
Nrow = size(data,1);
Ncol = size(data,2);
Ntime = size(data,3);
ser = zeros(1,Ntime);
days = 1:size(data,3);
days = (days/144)+1;

%%----------------------------------
%figure();
%plot(squeeze(data(20,20,:)),'k');
%break;
%%----------------------------------

for t=1:Ntime
    ser(t) = mean(mean(data(:,:,t)));
end
figure(1);
plot(ser,'k');
title('Сигнал усредненный по матрицам');

%ser1 = SSA_Filter_Part(ser,72,10);
%ser2 = SSA_Filter_Part(ser,144,2);
%ser3 = SSA_Filter_Part(ser,144,3);
%ser1 = cubicSplineSmooth1D(1:size(ser,2),ser)';x
ser1 = ChebRazl(ser,55,0);
%hold on;
%plot(ser1,'r');
%title('Тренд');

%lims = [min(ser1) max(ser1)];
figure(2);
plot(ser-ser1,'k');
%ylim(lims);
title('Сигнал без тренда');

%figure(3);


E = AnalyzW(ser-ser1,100,200,1,1);
%en_lims = [min(E)  max(E)];
daysE = 1:size(E,2);
daysE = (daysE/144)+1;
figure(4);
plot(daysE,E,'k');
%ylim(en_lims);
title('Энергия');

% ser_den = smoothFilter1D(ser1,3,10);
% %ser_den = WaveletDenoise1D('db4',ser1);
% figure(5);
% plot(days,ser_den,'k');
% ylim(lims);
% title('Сигнал после фильтрации');
% 
% E_den=AnalyzW(ser_den,1,36,1);
% figure(6);
% plot(E_den,'k');
% ylim(en_lims);
% title('Энергия после фильтрации');