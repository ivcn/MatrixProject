function [l] = Analyztrend(A,trend) 
n = size(A,2);   % количество точек ряда
%UNTITLED1 Summary of this function goes here


l = Fisher(A,3,20);    %%  находим оптимальную степень полинома по критерию Фишера
F = ChebRazl(A,l,0);     %%  Раскладываем функцию по полиномам Чебышева
B = Balance(A,F);      %%  Убираем тренд 




% %%%% 
% xa = 250;
% wcoef = cwt(B,1:xa,'cmor2-1');
% E = sum(abs(wcoef(:,:)).^2);
% nw = size(E,2);
% %%%% 
% xa1 = 250;
% wcoef1 = cwt(trend-F,1:xa1,'cmor2-1');
% E1 = sum(abs(wcoef1(:,:)).^2);
% nw1 = size(E1,2);


subplot(6,1,1);
plot(1:n, trend);set(gca,'FontName','Arial Cyr');title('Тренд');set(gca,'XTick',0:100:n);
subplot(6,1,2);
plot(1:n, A, 1:n,F);set(gca,'FontName','Arial Cyr');title(['Временной ряд, макс степень полинома: ' int2str(l)]);set(gca,'XTick',0:100:n);
subplot(6,1,3);
plot(1:n, trend-F);set(gca,'FontName','Arial Cyr');title('Тренд-полином');set(gca,'XTick',0:100:n);
subplot(6,1,4);
plot(1:n, B);set(gca,'FontName','Arial Cyr');title('Ряд со снятым трендом');set(gca,'XTick',0:100:n);
subplot(6,1,5);
% plot(1:nw, E);set(gca,'FontName','Arial Cyr'); title(['Вейвлет-преобразование cmor2-1 Диапазон a: 1-' int2str(xa)]);set(gca,'XTick',0:100:n);
% subplot(6,1,6);
% plot(1:nw1, E1);set(gca,'FontName','Arial Cyr'); title(['Вейвлет-преобразование cmor2-1 от Тренд-полином. Диапазон a: 1-' int2str(xa)]);set(gca,'XTick',0:100:n);



Nsr = sum(B)/n;      %% среднее значение сбалансированного ряда

D = sqrt(sum((B-Nsr).^2)/(n-1));   %% Среднеквадратичное отклонение

G = sort(B);
G = G/D;
%Gauss(G);
%  Detailed explanation goes here
