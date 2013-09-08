clear;
clc;
%filename='ANALYZED DATA sm0001 01 04 2010 d10 uf1 ut1 obr0 0 10 20 sigma1 pr5 cheb71 a1-36 b36 wt haar A3 lev5 thr0.mat';
%pathname='C:\Users\John\Documents\�������\';
%load([pathname filename], 'mat_intens');
%signal3D = mat_intens{4};
signal = zeros(1,500);
signal(:)=1;
signal(1:100) = 30.*rand(1,100);
signal(200:300)=50;
signal(400)=100;
figure();
subplot(211);
plot(signal);
title('signal');
a1 = 150;
a2 = 200;
b=1;
energy = AnalyzW(signal,a1,a2,b);
subplot(212);
plot(energy);
title(strcat('energy',' a= ',num2str(a1),'-',num2str(a2),', b=',num2str(b)));