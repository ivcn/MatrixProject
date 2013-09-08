clear;
%close all;
[filename pathname] = uigetfile('*.mat');
load(strcat(pathname,filename),'mat_wt');
sig = mat_wt{4};
N1 = size(sig,1);
N2 = size(sig,2);
Ntime = size(sig,3);
days = 1:Ntime;
days = (days/144)+1;

%sig3d = normalization1(mat_intens{4});
% figure(1);
% imagesc(sig3d(:,:,500));
% 
% figure(2);
% t = sig3d(2,5,:);
% t = t(:)';
% plot(days,t);
%'pressure correction'
%sig = pressure_correction(sig);

%надо превратить трехмерный массив в матрицу. Столбцы ее будут представлять
%собой временные ряды. Строки будут нумеровать временные отсчеты. Порядок
%столбцов соответствует порядку элементов в исходной матрице.
% 1 2 3
% 4 5 6  -> 1 2 3 4 5 6 7 8 9
% 7 8 9
matr = zeros(size(sig,1)*size(sig,2),size(sig,3));
for i =1:Ntime
    a = sig(:,:,i);%получаем следующую матрицу
    a1 = a(:);%векторизуем ее
    matr(:,i) = a1;%кладем в соответствующий столбец матрицы
end
'clusterization'
%T = clusterdata(matr,'maxclust',4);
D = pdist(matr);
Z = linkage(D,'complete');
idx = cluster(Z,'maxclust',5);
%idx = kmeans(matr,5);
%теперь надо превратить полученный вектор в матрицу (матрицировать его)
matr2 = zeros(size(sig,1),size(sig,2));
for i=1:size(sig,1)
    matr2(i,:) = idx((i-1)*size(sig,2)+1:i*size(sig,2));
end
'processing'
figure();
imagesc(matr2);
m1 = matr(matr2==1,:);
m2 = matr(matr2==2,:);
m3 = matr(matr2==3,:);
m4 = matr(matr2==4,:);
m5 = matr(matr2==5,:);
if( size(m1,1)>1 )
    a1 = sum(m1);
else
    a1 = m1;
end
if( size(m2,1)>1 )
    a2 = sum(m2);
else
    a2 = m2;
end
if( size(m3,1)>1 )
    a3 = sum(m3);
else
    a3 = m3;
end
if( size(m4,1)>1 )
    a4 = sum(m4);
else
    a4 = m4;
end
if( size(m5,1)>1 )
    a5 = sum(m5);
else
    a5 = m5;
end
figure();
plot(a1,'k');
hold on;
plot(a2,'r');
plot(a3,'g');
plot(a4,'y');
plot(a5,'b');

pow = 15;
scale1 = 6;
scale2 = 24;
b = 1;

% t1 = ChebRazl(a1,pow,0);
% awt1 = a1-t1;
% t2 = ChebRazl(a2,pow,0);
% awt2 = a2-t2;
% t3 = ChebRazl(a3,pow,0);
% awt3 = a3-t3;
% t4 = ChebRazl(a4,pow,0);
% awt4 = a4-t4;
% t5 = ChebRazl(a5,pow,0);
% awt5 = a5-t5;
% 
% figure();
% subplot(511);
% plot(days,awt1,'k');
% xlim([days(1) days(end)]);
% hold on;
% subplot(512);
% plot(days,awt2,'r');
% xlim([days(1) days(end)]);
% hold on;
% subplot(513);
% plot(days,awt3,'g');
% xlim([days(1) days(end)]);
% hold on;
% subplot(514);
% plot(days,awt4,'y');
% xlim([days(1) days(end)]);
% hold on;
% subplot(515);
% plot(days,awt5,'b');
% hold on;
% xlim([days(1) days(end)]);

fr1 = 0;
fr2 = 500;
swn1 = fourier_proc(a1,fr1,fr2);
swn2 = fourier_proc(a2,fr1,fr2);
swn3 = fourier_proc(a3,fr1,fr2);
swn4 = fourier_proc(a4,fr1,fr2);
swn5 = fourier_proc(a5,fr1,fr2);
figure();
subplot(511);
plot(days,swn1,'r');
xlim([days(1) days(end)]);
subplot(512);
plot(days,swn2,'k');
xlim([days(1) days(end)]);
subplot(513);
plot(days,swn3,'k');
xlim([days(1) days(end)]);
subplot(514);
plot(days,swn4,'k');
xlim([days(1) days(end)]);
subplot(515);
plot(days,swn5,'k');
xlim([days(1) days(end)]);

e1 = AnalyzW(swn1,scale1,scale2,b,0);
e2 = AnalyzW(swn2,scale1,scale2,b,0);
e3 = AnalyzW(swn3,scale1,scale2,b,0);
e4 = AnalyzW(swn4,scale1,scale2,b,0);
e5 = AnalyzW(swn5,scale1,scale2,b,0);
days_e = (1:size(e1,2))./144+1;

figure();
subplot(511);
plot(days_e,e1,'k');
xlim([days_e(1) days_e(end)]);
subplot(512);
plot(days_e,e2,'r');
xlim([days_e(1) days_e(end)]);
subplot(513);
plot(days_e,e3,'g');
xlim([days_e(1) days_e(end)]);
subplot(514);
plot(days_e,e4,'y');
xlim([days_e(1) days_e(end)]);
subplot(515);
plot(days_e,e5,'b');
xlim([days_e(1) days_e(end)]);