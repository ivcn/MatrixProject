clear;
clc;

[filename pathname] = uigetfile('*.mat','Выберите файл с матрицами');
load(strcat(pathname,filename),'mat_intens');
[filename1 pathname1] = uigetfile('*.txt','Выберите файл с давлением');
data = dlmread(strcat(pathname1,filename1));
pressure = data(:,2);
delete data;

sig = mat_intens{4};
delete mat_intens;
%% extract data
sizePartR = floor(size(sig,1)/3);
sizePartC = floor(size(sig,2)/3);

s11 = squeeze(sum(sum(sig(1:sizePartR, 1:sizePartC,:),1),2));
s12 = squeeze(sum(sum(sig(1:sizePartR,sizePartC+1:2*sizePartC,:),1),2));
s13 = squeeze(sum(sum(sig(1:sizePartR,2*sizePartC+1:size(sig,2),:),1),2));
s1 = s11+s12+s13;

s21 = squeeze(sum(sum(sig(sizePartR+1:2*sizePartR,1:sizePartC,:),1),2));
s22 = squeeze(sum(sum(sig(sizePartR+1:2*sizePartR,sizePartC+1:2*sizePartC,:),1),2));
s23 = squeeze(sum(sum(sig(sizePartR+1:2*sizePartR,2*sizePartC+1:size(sig,2),:),1),2));
s2 = s21+s22+s23;

s31 = squeeze(sum(sum(sig(2*sizePartR+1:size(sig,1),1:sizePartC,:),1),2));
s32 = squeeze(sum(sum(sig(2*sizePartR+1:size(sig,1),sizePartC+1:2*sizePartC,:),1),2));
s33 = squeeze(sum(sum(sig(2*sizePartR+1:size(sig,1),2*sizePartC+1:size(sig,2),:),1),2));
s3 = s31+s32+s33;

fid = fopen('top2.txt','w');
for i=1:size(s1,1)
    fprintf(fid,'%d\t%d\n',i,s2(i));
end
fclose(fid);

%% pressure correction
s1_wp = pressure_correction(s1,pressure);
s2_wp = pressure_correction(s2,pressure);
s3_wp = pressure_correction(s3,pressure);
s22_wp = pressure_correction(s22,pressure);

fid = fopen('top2_wp.txt','w');
for i=1:size(s1,1)
    fprintf(fid,'%d\t%d\n',i,s2_wp(i));
end
fclose(fid);

x = 1:size(s11,1);
days = (x./144)+1;
x = x';

%s11 = [x s11];
%s12 = [x s12];
%s13 = [x s13];
%s21 = [x s21];
s22 = [x s22];
%s23 = [x s23];
%s31 = [x s31];
%s32 = [x s32];
%s33 = [x s33];
s1  = [x s1 ];
s2  = [x s2 ];
s3  = [x s3 ];
s1_wp = [x s1_wp];
s2_wp = [x s2_wp];
s3_wp = [x s3_wp];
s22_wp = [x s22_wp];

% figure();
% subplot(311);
% plot(days,s11(:,2));
% subplot(312);
% plot(days,s12(:,2));
% subplot(313);
% plot(days,s13(:,2));
% 
% figure()
% subplot(311);
% plot(days,s21(:,2));
% subplot(312);
% plot(days,s22(:,2));
% subplot(313);
% plot(days,s23(:,2));
% 
% figure();
% subplot(311);
% plot(days,s31(:,2));
% subplot(312);
% plot(days,s32(:,2));
% subplot(313);
% plot(days,s33(:,2));

figure();
subplot(211);
plot(days,s1(:,2),'k');
subplot(212);
plot(days,s1_wp(:,2),'k');
title('top');

figure();
subplot(211);
plot(days,s2(:,2),'k');
subplot(212);
plot(days,s2_wp(:,2),'k');
title('middle');

figure();
subplot(211);
plot(days,s3(:,2),'k');
subplot(212);
plot(days,s3_wp(:,2),'k');
title('bottom');

figure();
subplot(211);
plot(days,s22(:,2),'k');
subplot(212);
plot(days,s22_wp(:,2),'k');
title('center');

%% nonstationarity
% [m nf11] = nonstationarity(T,size(s11,1),0.5,1,0,1,2,0,s11,-1,25,1);
% 'one'
% [m nf12] = nonstationarity(T,size(s11,1),0.5,1,0,1,2,0,s12,-1,25,1);
% 'two'
% [m nf13] = nonstationarity(T,size(s11,1),0.5,1,0,1,2,0,s13,-1,25,1);
% 'three'
% [m nf21] = nonstationarity(T,size(s11,1),0.5,1,0,1,2,0,s21,-1,25,1);
% 'four'
% [m nf22] = nonstationarity(T,size(s11,1),0.5,1,0,1,2,0,s22,-1,25,1);
% 'five'
% [m nf23] = nonstationarity(T,size(s11,1),0.5,1,0,1,2,0,s23,-1,25,1);
% 'six'
% [m nf31] = nonstationarity(T,size(s11,1),0.5,1,0,1,2,0,s31,-1,25,1);
% 'seven'
% [m nf32] = nonstationarity(T,size(s11,1),0.5,1,0,1,2,0,s32,-1,25,1);
% 'eight'
% [m nf33] = nonstationarity(T,size(s11,1),0.5,1,0,1,2,0,s33,-1,25,1);
% 'nine'

tic;
T = 576;
subinterval = 1;
TStart=0;
[m nf1] = nonstationarity(T,size(s11,1),0.5,subinterval,TStart,1,2,0,s1,-1,25,1);
'one'
[m nf2] = nonstationarity(T,size(s11,1),0.5,subinterval,0,1,2,0,s2,-1,25,1);
'two'
[m nf3] = nonstationarity(T,size(s11,1),0.5,subinterval,0,1,2,0,s3,-1,25,1);
'three'
[m nf22] = nonstationarity(T,size(s11,1),0.5,subinterval,0,1,2,0,s22,-1,25,1);
'four'
[m nf1_wp] = nonstationarity(T,size(s11,1),0.5,subinterval,0,1,2,0,s1_wp,-1,25,1);
'five'
[m nf2_wp] = nonstationarity(T,size(s11,1),0.5,subinterval,0,1,2,0,s2_wp,-1,25,1);
'six'
[m nf3_wp] = nonstationarity(T,size(s11,1),0.5,subinterval,0,1,2,0,s3_wp,-1,25,1);
'seven'
[m nf22_wp] = nonstationarity(T,size(s11,1),0.5,subinterval,0,1,2,0,s22_wp,-1,25,1);
'eight'
toc;
parameters = strcat('T=',num2str(T),' subinterval=',num2str(subinterval));


%% output results
%x = (1+TStart+T:subinterval:1+(length(nf11)-1)*subinterval+TStart+T);
x = 1:size(nf1,2);
x =x+T;
days = x./144+1;

% figure();
% subplot(311);
% plot(days,nf11);
% subplot(312);
% plot(days,nf12);
% subplot(313);
% plot(days,nf13);
% 
% figure();
% subplot(311);
% plot(days,nf21);
% subplot(312);
% plot(days,nf22);
% subplot(313);
% plot(days,nf23);
% 
% figure();
% subplot(311);
% plot(days,nf31);
% subplot(312);
% plot(days,nf32);
% subplot(313);
% plot(days,nf33);

figure();
subplot(211);
plot(days,nf1,'k');
subplot(212);
plot(days,nf1_wp,'k');
title(strcat('top',32,parameters));

figure();
subplot(211);
plot(days,nf2,'k');
subplot(212);
plot(days,nf2_wp,'k');
title(strcat('middle',32,parameters));

figure();
subplot(211);
plot(days,nf3,'k');
subplot(212);
plot(days,nf3_wp,'k');
title(strcat('bottom',32,parameters));

figure();
subplot(211);
plot(days,nf22,'k');
subplot(212);
plot(days,nf22_wp,'k');
title(strcat('center',32,parameters));