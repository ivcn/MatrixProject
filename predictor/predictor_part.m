clear;
clc;

windowDays = 0.5;% движущееся окно в днях
window = windowDays*144;
step=1;%шаг движения
a1=1;
a2=18;
beta = -0.002;
p0=994;
sizeA=a2-a1+1;




[filename pathname] = uigetfile('*.mat','Выберите файл с матрицами');
load(strcat(pathname,filename),'mat_intens');
[filename1 pathname1] = uigetfile('*.txt','Выберите файл с давлением');
data = dlmread(strcat(pathname1,filename1));
pressure = data(:,2);
delete data;

sig = mat_intens{4};
delete mat_intens;

sizeT = size(sig,3);
%% extract data
sizePartR = floor(size(sig,1)/3);
sizePartC = floor(size(sig,2)/3);

s11 = squeeze(sum(sum(sig(1:sizePartR, 1:sizePartC,:),1),2))';
s12 = squeeze(sum(sum(sig(1:sizePartR,sizePartC+1:2*sizePartC,:),1),2))';
s13 = squeeze(sum(sum(sig(1:sizePartR,2*sizePartC+1:size(sig,2),:),1),2))';
s1 = s11+s12+s13;

s21 = squeeze(sum(sum(sig(sizePartR+1:2*sizePartR,1:sizePartC,:),1),2))';
s22 = squeeze(sum(sum(sig(sizePartR+1:2*sizePartR,sizePartC+1:2*sizePartC,:),1),2))';
s23 = squeeze(sum(sum(sig(sizePartR+1:2*sizePartR,2*sizePartC+1:size(sig,2),:),1),2))';
s2 = s21+s22+s23;

s31 = squeeze(sum(sum(sig(2*sizePartR+1:size(sig,1),1:sizePartC,:),1),2))';
s32 = squeeze(sum(sum(sig(2*sizePartR+1:size(sig,1),sizePartC+1:2*sizePartC,:),1),2))';
s33 = squeeze(sum(sum(sig(2*sizePartR+1:size(sig,1),2*sizePartC+1:size(sig,2),:),1),2))';
s3 = s31+s32+s33;

%% pressure correction
s11_wp = zeros(size(s11));
s12_wp = zeros(size(s12));
s13_wp = zeros(size(s13));
s21_wp = zeros(size(s21));
s22_wp = zeros(size(s22));
s23_wp = zeros(size(s23));
s31_wp = zeros(size(s31));
s32_wp = zeros(size(s32));
s33_wp = zeros(size(s33));
for t =1:size(s1,2)
    %s2(t) = s(t)*(1+beta*(pressure(t)-p0));%pressure(1)));
    s11_wp(t) = s11(t)-beta*s11(1)*(pressure(t)-p0);
    s12_wp(t) = s12(t)-beta*s12(1)*(pressure(t)-p0);
    s13_wp(t) = s13(t)-beta*s13(1)*(pressure(t)-p0);
    s21_wp(t) = s21(t)-beta*s21(1)*(pressure(t)-p0);
    s22_wp(t) = s22(t)-beta*s22(1)*(pressure(t)-p0);
    s23_wp(t) = s23(t)-beta*s23(1)*(pressure(t)-p0);
    s31_wp(t) = s31(t)-beta*s31(1)*(pressure(t)-p0);
    s32_wp(t) = s32(t)-beta*s32(1)*(pressure(t)-p0);
    s33_wp(t) = s33(t)-beta*s33(1)*(pressure(t)-p0);
end
%s1_wp = pressure_correction(s1,pressure);
%s2_wp = pressure_correction(s2,pressure);
%s3_wp = pressure_correction(s3,pressure);
%s22_wp = pressure_correction(s22,pressure);

%x = 1:size(s11,1);
%days = (x./144)+1;
%x = x';

%% calculating indexes
%расчет индексов
pos_index=1;
index11 = zeros(1,(sizeT-window)/step);
index12 = zeros(1,(sizeT-window)/step);
index13 = zeros(1,(sizeT-window)/step);
index21 = zeros(1,(sizeT-window)/step);
index22 = zeros(1,(sizeT-window)/step);
index23 = zeros(1,(sizeT-window)/step);
index31 = zeros(1,(sizeT-window)/step);
index32 = zeros(1,(sizeT-window)/step);
index33 = zeros(1,(sizeT-window)/step);

%h_index = zeros(1,(sizeT-window)/step);
d_index11 = zeros(1,(sizeT-window)/step);
d_index12 = zeros(1,(sizeT-window)/step);
d_index13 = zeros(1,(sizeT-window)/step);
d_index21 = zeros(1,(sizeT-window)/step);
d_index22 = zeros(1,(sizeT-window)/step);
d_index23 = zeros(1,(sizeT-window)/step);
d_index31 = zeros(1,(sizeT-window)/step);
d_index32 = zeros(1,(sizeT-window)/step);
d_index33 = zeros(1,(sizeT-window)/step);


pow = 30;
for pos = 1:step:sizeT-window
    windowData11 = s11_wp(pos:pos+window);
    windowData12 = s12_wp(pos:pos+window);
    windowData13 = s13_wp(pos:pos+window);
    windowData21 = s21_wp(pos:pos+window);
    windowData22 = s22_wp(pos:pos+window);
    windowData23 = s23_wp(pos:pos+window);
    windowData31 = s31_wp(pos:pos+window);
    windowData32 = s32_wp(pos:pos+window);
    windowData33 = s33_wp(pos:pos+window);
    trend11 = ChebRazl(windowData11,pow,0);
    trend12 = ChebRazl(windowData12,pow,0);
    trend13 = ChebRazl(windowData13,pow,0);
    trend21 = ChebRazl(windowData21,pow,0);
    trend22 = ChebRazl(windowData22,pow,0);
    trend23 = ChebRazl(windowData23,pow,0);
    trend31 = ChebRazl(windowData31,pow,0);
    trend32 = ChebRazl(windowData32,pow,0);
    trend33 = ChebRazl(windowData33,pow,0);
    windowData11 = windowData11-trend11;
    windowData12 = windowData12-trend12;
    windowData13 = windowData13-trend13;
    windowData21 = windowData21-trend21;
    windowData22 = windowData22-trend22;
    windowData23 = windowData23-trend23;
    windowData31 = windowData31-trend31;
    windowData32 = windowData32-trend32;
    windowData33 = windowData33-trend33;
    %e = mycwt(windowData,a1,a2);
    %index(pos_index) = e(end);
    index11(pos_index) = sum(AnalyzW(windowData11,a1,a2,1,0));
    index12(pos_index) = sum(AnalyzW(windowData12,a1,a2,1,0));
    index13(pos_index) = sum(AnalyzW(windowData13,a1,a2,1,0));
    index21(pos_index) = sum(AnalyzW(windowData21,a1,a2,1,0));
    index22(pos_index) = sum(AnalyzW(windowData22,a1,a2,1,0));
    index23(pos_index) = sum(AnalyzW(windowData23,a1,a2,1,0));
    index31(pos_index) = sum(AnalyzW(windowData31,a1,a2,1,0));
    index32(pos_index) = sum(AnalyzW(windowData32,a1,a2,1,0));
    index33(pos_index) = sum(AnalyzW(windowData33,a1,a2,1,0));
    %index(pos_index) = sum(mycwt(windowData,a1,a2));
    %h_index(pos_index) = estimate_hurst_exponent(windowData);
    d_index11(pos_index) = std(windowData11);
    d_index12(pos_index) = std(windowData12);
    d_index13(pos_index) = std(windowData13);
    d_index21(pos_index) = std(windowData21);
    d_index22(pos_index) = std(windowData22);
    d_index23(pos_index) = std(windowData23);
    d_index31(pos_index) = std(windowData31);
    d_index32(pos_index) = std(windowData32);
    d_index33(pos_index) = std(windowData33);
    pos_index=pos_index+1;
    
    progress = floor(pos_index./size(index11,2)*100);
    if(rem(progress,10)==0)
        progress
    end
end

pos = 1:size(index11,2);
pos = pos+window;
days = (pos./144)+1;
figure();
subplot(311);
plot(days,index11,'k');
subplot(312);
plot(days,index12,'k');
subplot(313);
plot(days,index13,'k');
title('ener-top');

figure();
subplot(311);
plot(days,index21,'k');
subplot(312);
plot(days,index22,'k');
subplot(313);
plot(days,index23,'k');
title('ener-mid');

figure();
subplot(311);
plot(days,index31,'k');
subplot(312);
plot(days,index32,'k');
subplot(313);
plot(days,index33,'k');
title('ener-bot');

figure();
subplot(311);
plot(days,d_index11,'k');
subplot(312);
plot(days,d_index12,'k');
subplot(313);
plot(days,d_index13,'k');
title('disp-top');

figure();
subplot(311);
plot(days,d_index21,'k');
subplot(312);
plot(days,d_index22,'k');
subplot(313);
plot(days,d_index23,'k');
title('disp-top');

figure();
subplot(311);
plot(days,d_index31,'k');
subplot(312);
plot(days,d_index32,'k');
subplot(313);
plot(days,d_index33,'k');
title('disp-top');