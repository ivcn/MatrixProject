function [] = Wavelet() 

%UNTITLED1 Summary of this function goes here

A=Readrow();    %% читаем из файла исх ряд
A=Obrezka(A);     %% обрабатываем его (из 5-минутных интервалов делаем 10-минутные)
n = size(A,2);   % количество точек ряда

B=[];
F=[];

xn=1;
while (xn+239<=n)
    A1=A(1,xn:1:xn+239);  
    l = Fisher(A1,2,20);    %%  находим оптимальную степень полинома по критерию Фишера
    l=3;
    F1 = ChebRazl(A1,l,0);     %%  Раскладываем функцию по полиномам Чебышева
    B1 = Balance(A1,F1);      %%  Убираем тренд 
    xn=xn+240;
    B=[B,B1];
    F=[F,F1];
end



wcoef = cwt(B,1:50,'cmor1-1');
wcoef1 = cwt(B,1:30,'morl');

nw = size(wcoef,2);
nw1 = size(wcoef1,2);

E = sum(abs(wcoef(:,:)).^2);
E1 = sum(wcoef1(:,:).^2);

subplot(4,1,1);
plot(1:n, A, 1:n,F);set(gca,'FontName','Arial Cyr');title('Временной ряд');
subplot(4,1,2);
plot(1:n, B);set(gca,'FontName','Arial Cyr');title('Ряд со снятым трендом');
subplot(4,1,3);
plot(1:nw, E);set(gca,'FontName','Arial Cyr'); title('Вейвлет-преобразование cmor2-1');
subplot(4,1,4); 
plot(1:nw1, E1);set(gca,'FontName','Arial Cyr');title('Вейвлет-преобразование morl');
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
