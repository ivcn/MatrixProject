
%I=imread('C:\Users\Public\Pictures\Sample Pictures\Chrysanthemum.jpg');
%imshow(im);
load('../Data/SSA_01-10 апрель 2010 (2х1)/ANALYZED DATA sm0001 01 04 2010 d10 uf1 ut2 obr1 0 5 40 pr10 wd ssa71 a1-16 b36.mat');
I=mat_en(:,:,567,4);%.*(mat_en(:,:,567,4)>1100000);
%I=rgb2gray(I);
imagesc(I);
I=double(I);
%-------canny-------
% canny_best = edge(I,'canny',[0.04 0.10],1.5);
% figure();
% imagesc(canny_best);
% I2 = I;
% I2(canny_best==1) = 0;
% imagesc(I2);
%--------------
h = fspecial('sobel');
g = sqrt(imfilter(I,h,'replicate').^2+imfilter(I,h','replicate').^2);
L = watershed(g);
wr = L==0;
im = imextendedmin(I,2);
Lim = watershed(bwdist(im));
em = Lim==0;
g2 = imimposemin(g,im|em);
L2 = watershed(g2);
f2 = I;
f2(L==0) = 255;
figure();
imagesc(f2);
%load('../Data/SSA_01-10 апрель 2010 (2х2)/ANALYZED DATA sm0001 01 04 2010 d10 uf2 ut2 obr1 0 5 35 pr10 wd ssa51 a1-16 b36.mat');
%I=mat_en(:,:,567,4).*(mat_en(:,:,567,4)>1100000);
% imagesc(I)
% %text(732,501,'…',...
%      'FontSize',7,'HorizontalAlignment','right');
%  
% hy=fspecial('sobel');
% gaus=fspecial('gaussian',5,4);
% 
% hx=hy';
% Iy=imfilter(double(I), hy, 'replicate');
% Ix=imfilter(double(I), hx, 'replicate');
% figure,imagesc(Iy);
% figure,imagesc(Ix);
% gradmag=sqrt(Ix.^2+Iy.^2);
% figure, imagesc(gradmag), title('значение градиента')
% 
% im_gaus = imfilter(gradmag,gaus,'replicate');
% figure, imagesc(im_gaus);
% 
% L=watershed(im_gaus);
% Lrgb=label2rgb(L);
% figure, imagesc(Lrgb), title('Lrgb');