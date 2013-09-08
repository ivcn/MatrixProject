clear;
clc;
filename='ANALYZED DATA sm0001 01 04 2010 d15 uf1 ut1 obr1 0 5 35 sigma0 pr5 ssa_seg36_win18_comp1_ a40-50 b10 wt haar A2 lev5 thr0.mat';
pathname='C:\Users\John\Documents\Матрицы\';
load([pathname filename], 'mat_intens');
signal3D = mat_intens{4};
num = 450;
image = signal3D(:,:,num);
%s = image(:,50)';
%figure();
%plot(s,'-o');
%l = 3.5;
%b = 1.15;
%g = 2;
% if(rem(size(s,1),2) == 0)
%     mid = size(s,1)/2;
%     for i=mid:1
%         s(i) = s(i)*l/(l-b*abs(tan(mid-i+1)));
%     end
%     for i=mid:size(s,1)
%         s(i) = s(i)*l/(l-b*abs(tan(i-mid+1)));
%     end
% else
%     [max mid] = max(s);% ceil(size(s,1)/2);
%     for i=1:mid
%         k = l/(l-b*abs(tan(pi*g*(mid-i)/180)));
%         s(i) = s(i)*k;
%     end
%     for i=mid:size(s,2)
%         k=l/(l-b*abs(tan(pi*g*(i-mid)/180)));
%         s(i) = s(i)*k;
%     end
%end
%figure();
%plot(s,'r-o');
im = alignFunc(image);
figure();
imagesc(image,[0 500]);
figure();
imagesc(im,[0 500]);