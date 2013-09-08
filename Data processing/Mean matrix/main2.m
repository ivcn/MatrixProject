%uiopen('*.mat');
load('C:\Users\John\Documents\MATLAB\Data\матрицы 29.02.2012\ANALYZED DATA sm0001 01 04 2010 d10 uf2 ut2 obr1 0 10 35 pr10 cheb71 a1-36 b6.mat');
data = mat_intens(:,:,:,4);
Nrow = size(data,1);
Ncol = size(data,2);
Ntime = size(data,3);
%рассчитаем середины сторон
%midRow = 0;
%midCol = 0;
if( rem(Nrow,2) == 0)
    midRow = Nrow/2;
else
    midRow = ceil(Nrow/2);
end
if( rem(Ncol,2) == 0)
    midCol = Ncol/2;
else
    midCol = ceil(Ncol/2);
end
%усредн€ем куски матриц
ser11 = zeros(1,Ntime);
ser12 = zeros(1,Ntime);
ser21 = zeros(1,Ntime);
ser22 = zeros(1,Ntime);
for t=1:Ntime
    ser11(t) = mean(mean(data(1:midRow,1:midCol,t)));
    ser12(t) = mean(mean(data(1:midRow,midCol+1:Ncol,t)));
    ser21(t) = mean(mean(data(midRow+1:Nrow,1:midCol,t)));
    ser22(t) = mean(mean(data(midRow+1:Nrow,midCol+1:Ncol,t)));
end
figure(1);
subplot(221), plot(ser11,'k');
subplot(222), plot(ser12,'k');
subplot(223), plot(ser21,'k');
subplot(224), plot(ser22,'k');
title('”средненный сигнал');
%вычитаем тренд
wt_ser11 = zeros(1,Ntime);
wt_ser12 = zeros(1,Ntime);
wt_ser21 = zeros(1,Ntime);
wt_ser22 = zeros(1,Ntime);
wt_ser11 = SSA_Filter_Part(ser11,144,1);
wt_ser12 = SSA_Filter_Part(ser12,144,1);
wt_ser21 = SSA_Filter_Part(ser21,144,1);
wt_ser22 = SSA_Filter_Part(ser22,144,1);
figure(2);
subplot(221), plot(wt_ser11,'k');
subplot(222), plot(wt_ser12,'k');
subplot(223), plot(wt_ser21,'k');
subplot(224), plot(wt_ser22,'k');
title('Cигнал без тренда');

%считаем энергию
start_a = 1;
end_a = 36;
E11 = AnalyzW(wt_ser11,start_a,end_a,1);
E12 = AnalyzW(wt_ser12,start_a,end_a,1);
E21 = AnalyzW(wt_ser21,start_a,end_a,1);
E22 = AnalyzW(wt_ser22,start_a,end_a,1);
figure(3);
subplot(221), plot(E11,'k');
subplot(222), plot(E12,'k');
subplot(223), plot(E21,'k');
subplot(224), plot(E22,'k');
title('Ёнерги€ после удалени€ тренда');

%сглаживание сигнала
den_ser11 = zeros(1,Ntime);
den_ser12 = zeros(1,Ntime);
den_ser21 = zeros(1,Ntime);
den_ser22 = zeros(1,Ntime);
den_ser11 = smoothFilter1D(wt_ser11,3,50);
den_ser12 = smoothFilter1D(wt_ser12,3,50);
den_ser21 = smoothFilter1D(wt_ser21,3,50);
den_ser22 = smoothFilter1D(wt_ser22,3,50);
figure(4);
subplot(221), plot(den_ser11,'k');
subplot(222), plot(den_ser12,'k');
subplot(223), plot(den_ser21,'k');
subplot(224), plot(den_ser22,'k');
title('—глаженный сигнал');

%считаем энергию от сглаженного сигнала
den_E11 = AnalyzW(den_ser11,start_a,end_a,1);
den_E12 = AnalyzW(den_ser12,start_a,end_a,1);
den_E21 = AnalyzW(den_ser21,start_a,end_a,1);
den_E22 = AnalyzW(den_ser22,start_a,end_a,1);
figure(5);
subplot(221), plot(den_E11,'k');
subplot(222), plot(den_E12,'k');
subplot(223), plot(den_E21,'k');
subplot(224), plot(den_E22,'k');
title('Ёнерги€ после сглаживани€');

