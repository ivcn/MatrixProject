[filename pathname] = uigetfile('*.mat');
load(strcat(pathname,filename),'mat_intens');
sig = mat_intens{4};
N1 = size(sig,1);
N2 = size(sig,2);
Ntime = size(sig,3);
days = 1:Ntime;
days = (days/144)+1;

sig = pressure_correction(sig);

sig1 = mean(mean(sig(1:floor(N1/2),1:floor(N2/2),:)));%усредняем каждую матрицу
sig2 = mean(mean(sig(1:floor(N1/2),ceil(N2/2):N2,:)));
sig3 = mean(mean(sig(ceil(N1/2):N1,1:floor(N2/2),:)));
sig4 = mean(mean(sig(ceil(N1/2):N1,ceil(N2/2):N2,:)));
sig1=sig1(:)';
sig2=sig2(:)';
sig3=sig3(:)';
sig4=sig4(:)';

figure(1);
plot(days,sig1,'k');
hold on;
plot(days,sig2,'r');
plot(days,sig3,'g');
plot(days,sig4,'y');

alpha = 6000;
pow=55;
t1 = ChebRazl(sig1,pow,0);
t2 = ChebRazl(sig2,pow,0);
t3 = ChebRazl(sig3,pow,0);
t4 = ChebRazl(sig4,pow,0);
plot(days,t1,'r');
plot(days,t2,'b');
plot(days,t3,'b');
plot(days,t4,'b');
hold off;

swt1 = sig1-t1;
swt2 = sig2-t2;
swt3 = sig3-t3;
swt4 = sig4-t4;
figure(2);
subplot(411);
plot(days,swt1,'k');
hold on;
subplot(412);
plot(days,swt2,'r');
hold on;
subplot(413);
plot(days,swt3,'g');
hold on;
subplot(414);
plot(days,swt4,'y');
hold on;

swn1 = fourier_proc(sig1,100,400);
swn2 = fourier_proc(sig2,100,400);
swn3 = fourier_proc(sig3,100,400);
swn4 = fourier_proc(sig4,100,400);
subplot(411);
plot(days,swn1,'r');
hold off;
subplot(412);
plot(days,swn2,'k');
hold off;
subplot(413);
plot(days,swn3,'k');
hold off;
subplot(414);
plot(days,swn4,'k');
hold off;

a1 = 10;
a2 = 72;
b=6;

e1 = AnalyzW(swn1,a1,a2,b,0);
e2 = AnalyzW(swn2,a1,a2,b,0);
e3 = AnalyzW(swn3,a1,a2,b,0);
e4 = AnalyzW(swn4,a1,a2,b,0);
days_e = (1:size(e1,2))./144+1;
figure(3);
subplot(411);
plot(days_e,e1,'k');
subplot(412);
plot(days_e,e2,'r');
subplot(413);
plot(days_e,e3,'g');
subplot(414);
plot(days_e,e4,'y');


