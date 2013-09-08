filename='ANALYZED DATA sm0001 01 04 2010 d10 uf1 ut1 obr0 0 10 20 sigma1 pr5 cheb71 a1-36 b36 wt haar A3 lev5 thr0.mat';
pathname='C:\Users\John\Documents\Матрицы\';
load([pathname filename], 'mat_intens');
signal1 = mat_intens{4}(:,:,300);