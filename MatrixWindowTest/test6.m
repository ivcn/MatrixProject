clear;
[filename pathname] = uigetfile('*.mat');
load(strcat(pathname,filename),'mat_wt');
sig = mat_wt{4};
Ntime = size(sig,3);
days = 1:Ntime;
days = (days/144)+1;
teta = 30;

im = squeeze(sig(:,10,:));
figure();
imagesc(im);
m = fspecial('gaussian',[10 800],10);
figure();
im2 = imfilter(im,m);
imagesc(im2);

s = sum(im,1);
figure();
plot(days,s,'k');

e = AnalyzW(s,1,24,1,1);
figure();
plot(days,e,'k');