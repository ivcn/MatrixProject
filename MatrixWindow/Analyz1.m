function [l] = Analyz(A) 
n = size(A,2);   % количество точек ряда
%UNTITLED1 Summary of this function goes here

B0 = A;

l = Fisher(A,1,20);    %%  находим оптимальную степень полинома по критерию Фишера
F = ChebRazl(A,l,0);     %%  Раскладываем функцию по полиномам Чебышева
B = Balance(A,F);      %%  Убираем тренд 



xa = 50;

wcoef = cwt(B,1:xa,'cmor2-1');
E = sum(abs(wcoef(:,:)).^2);

% xo = 48;  %% размер окна
% xs=1;
% 
% E=[];
% E1=[];
% 
% while (xs+xo-1<=n)
%   E=[E sum(Ew(1,xs:1:xs+xo-1))];      
%   E1=[E1 sum(Ew1(1,xs:1:xs+xo-1))];
%   xs=xs+1;
% end

nw = size(E,2);

%%%% 
xa1 = 250;
wcoef1 = cwt(B0,1:xa1,'cmor2-1');
E1 = sum(abs(wcoef1(:,:)).^2);
%%%% 
xa2 = 250;
wcoef2 = cwt(B,100:xa2,'cmor2-1');
E2 = sum(abs(wcoef2(:,:)).^2);
%%%% 
% xa3 = 500;
% wcoef3 = cwt(B,1:xa3,'cmor2-1');
% E3 = sum(abs(wcoef3(:,:)).^2);
%%%% 
% xa4 = 1000;
% wcoef4 = cwt(B,1:xa4,'cmor2-1');
% E4 = sum(abs(wcoef4(:,:)).^2);


subplot(5,1,1);
plot(1:n, A, 1:n,F);set(gca,'FontName','Arial Cyr');title(['Временной ряд, макс степень полинома: ' int2str(l)]);set(gca,'XTick',0:100:n);
subplot(5,1,2);
plot(1:n, B);set(gca,'FontName','Arial Cyr');title('Ряд со снятым трендом');set(gca,'XTick',0:100:n);
subplot(5,1,3);
plot(1:nw, E);set(gca,'FontName','Arial Cyr'); title(['Вейвлет-преобразование cmor2-1 Диапазон a: 1-' int2str(xa)]);set(gca,'XTick',0:100:n);
subplot(5,1,4); 
plot(1:nw, E1);set(gca,'FontName','Arial Cyr'); title(['Тренд не снят. Вейвлет-преобразование cmor2-1 Диапазон a: 1-' int2str(xa1)]);set(gca,'XTick',0:100:n);
subplot(5,1,5);
plot(1:nw, E2);set(gca,'FontName','Arial Cyr'); title(['Вейвлет-преобразование cmor2-1 Диапазон a: 1-' int2str(xa2)]);set(gca,'XTick',0:100:n);
% subplot(7,1,6);
% plot(1:nw, E3);set(gca,'FontName','Arial Cyr'); title(['Вейвлет-преобразование cmor2-1 Диапазон a: 1-' int2str(xa3)]);set(gca,'XTick',0:100:n);
% subplot(7,1,7);
% plot(1:nw, E);set(gca,'FontName','Arial Cyr'); title(['Вейвлет-преобразование cmor2-1 Диапазон a: 1-' int2str(xa4)]);set(gca,'XTick',0:100:n);
% plot(1:nw1, E1);set(gca,'FontName','Arial Cyr');title('Вейвлет-преобразование morl');set(gca,'XTick',0:100:n);
% figure (1); plot(1:n, B);
% subplot(211),plot(1:n, B);
% subplot(212), wcoef = cwt(B,1:30,'morl', 'abslvl',[0 10]);
% wcoef


Nsr = sum(B)/n;      %% среднее значение сбалансированного ряда

D = sqrt(sum((B-Nsr).^2)/(n-1));   %% Среднеквадратичное отклонение

G = sort(B);
G = G/D;
%Gauss(G);
%  Detailed explanation goes here
