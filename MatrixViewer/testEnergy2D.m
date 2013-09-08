clear;
clc;
filename='ANALYZED DATA sm0001 01 04 2010 d10 uf1 ut1 obr0 0 10 20 sigma1 pr5 cheb71 a1-36 b36 wt haar A3 lev5 thr0.mat';
pathname='C:\Users\John\Documents\Матрицы\';
load([pathname filename], 'mat_intens');
pos = 484;
im = mat_intens{4}(:,:,pos);
figure();
imagesc(im,[0 500]);
colorbar();

sum_comp5 = SSA_2D(im,10);
figure();
imagesc(sum_comp5,[0 500]);
colorbar();

summ_comp400 = SSA_2D(im,400);
figure();
imagesc(summ_comp400,[0 500]);
colorbar();

im_ssa = im - summ_comp400;
figure();
imagesc(im_ssa);
colorbar();
%im_norm = Normalization(im_ssa);
energy = waveletEnergy2D(im_ssa,20,40);
figure();
imagesc(energy,[0 8e5]);
colorbar();